import 'package:butterfly_touch/presentation/widgets/global/toast.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scan/scan.dart';

import '../../../../business_logic/cubit/scan/scan_cubit.dart';
import '../../../../business_logic/cubit/scan/scan_states.dart';
import '../../../../data/local/cache_helper.dart';
import '../../../widgets/scan/add_container.dart';
import '../../regisation_screen.dart';

class AdminScan extends StatefulWidget {
  const AdminScan({super.key});

  @override
  State<AdminScan> createState() => _AdminScanState();
}

class _AdminScanState extends State<AdminScan> {
  String _platformVersion = 'Unknown';
  String qrcode = 'Unknown';
  ScanController controller = ScanController();
  String qrcode1 = 'Unknown';
  bool lightFlag = false;
  bool progressFlag = false;
  TextEditingController descriptionController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await Scan.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    late ScanCubit cub;
    return BlocProvider(
        create: (BuildContext context) => ScanCubit(),
        child: BlocConsumer<ScanCubit, ScanStates>(
            listener: (BuildContext context, ScanStates state) {
          if (state is CreateBarcodeLoadingScanStates) {
            cub.changeShowContainerFlag(false);
            progressFlag = true;
            descriptionController.text = '';
            showToast(message: 'Done');
          }

          if (state is CreateBarcodeSuccessScanStates) {
            controller.resume();

            cub.changeShowContainerFlag(false);
            progressFlag = false;
          }

          if (state is CreateBarcodeErrorScanStates) {
            progressFlag = false;
            cub.changeShowContainerFlag(true);
            showToast(message: state.error);
          }
          if (state is LogOutSuccessScanStates) {
            showToast(
              message: 'Log out Successfully',
            );
            CacheHelper.removeData(key: "user");
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Registration(),
                ));
          }
        }, builder: (BuildContext context, ScanStates state) {
          cub = ScanCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.black,
            body: DoubleBackToCloseApp(
              snackBar: const SnackBar(
                content: Text('Tap back again to leave'),
              ),
              child: SafeArea(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(
                      width: width, // custom wrap size
                      height: height,
                      child: ScanView(
                        controller: controller,
                        scanAreaScale: 1,
                        scanLineColor: Colors.green.shade400,
                        onCapture: (data) {
                          setState(() {
                            qrcode = data;
                            controller.pause();
                            cub.changeShowContainerFlag(true);
                          });
                        },
                      ),
                    ),
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        SizedBox(
                          width: width,
                          height: height,
                        ),
                        FloatingActionButton(
                          mini: true,
                          onPressed: () {
                            cub.logout();
                          },
                          child: const Icon(FontAwesomeIcons.signOut),
                        )
                      ],
                    ),
                    Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        SizedBox(
                          width: width,
                          height: height,
                        ),
                        FloatingActionButton(
                          mini: true,
                          onPressed: () {
                            controller.toggleTorchMode();
                            setState(() {
                              lightFlag = !lightFlag;
                            });
                          },
                          child: Icon(lightFlag
                              ? FontAwesomeIcons.solidLightbulb
                              : FontAwesomeIcons.lightbulb),
                        )
                      ],
                    ),
                    progressFlag
                        ? Stack(
                            children: [
                              SizedBox(
                                width: width,
                                height: height,
                              ),
                              const Center(child: CircularProgressIndicator()),
                            ],
                          )
                        : const SizedBox(),
                    cub.showContainerFlag
                        ? addContainer(
                            width: width,
                            height: height,
                            descriptionController: descriptionController,
                            onTapCancel: () {
                              cub.changeShowContainerFlag(false);
                              controller.resume();
                            },
                            onTapSave: () {
                              controller.pause();
                              cub.createBarcode(
                                  barcode: qrcode,
                                  isGood: cub.envFlag,
                                  description: descriptionController.text);
                            },
                            qrcode: qrcode,
                            onToggle: (value) {
                              cub.changeEnvFlag(value);
                            },
                            state: cub.envFlag,
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
