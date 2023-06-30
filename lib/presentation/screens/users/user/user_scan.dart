import 'package:butterfly_touch/constants/conestant.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scan/scan.dart';

import '../../../../business_logic/cubit/scan/scan_cubit.dart';
import '../../../../business_logic/cubit/scan/scan_states.dart';
import '../../../widgets/global/toast.dart';
import '../../../widgets/scan/add_container.dart';

class UserScan extends StatefulWidget {
  const UserScan({super.key});

  @override
  State<UserScan> createState() => _UserScanState();
}

class _UserScanState extends State<UserScan> {
  String _platformVersion = 'Unknown';
  String qrcode = 'Unknown';
  ScanController controller = ScanController();
  String qrcode1 = 'Unknown';
  bool lightFlag = false;
  bool progressFlag = false;
  TextEditingController descriptionController = TextEditingController();
  Map<String, dynamic>? barcode;

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
        create: (BuildContext context) => ScanCubit()..getUserData(),
        child: BlocConsumer<ScanCubit, ScanStates>(
            listener: (BuildContext context, ScanStates state) {
          if (state is GetBarcodeLoadingScanStates) {
            cub.changeShowContainerFlag(false);
            progressFlag = true;
          }
          if (state is GetBarcodeSuccessScanStates) {
            cub.changeShowContainerFlag(true);
            barcode = state.barcode;
            progressFlag = false;
            showToast(message: 'Done');
          }
          if (state is GetBarcodeErrorScanStates) {
            cub.changeShowContainerFlag(false);
            progressFlag = false;
            controller.resume();
            showToast(message: state.error);
          }
          if (state is CreateBarcodeLoadingScanStates) {
            cub.changeShowContainerFlag(false);
            progressFlag = true;
          }

          if (state is CreateBarcodeSuccessScanStates) {
            controller.resume();
            cub.changeShowContainerFlag(false);
            progressFlag = false;
            showToast(message: 'Done');
          }

          if (state is CreateBarcodeErrorScanStates) {
            progressFlag = false;
            cub.changeShowContainerFlag(true);
            showToast(message: state.error);
          }
        }, builder: (BuildContext context, ScanStates state) {
          cub = ScanCubit.get(context);
          if (barcode != null) {
            descriptionController.text = barcode?['description'];
          }
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
                      width: width,
                      height: height,
                      child: ScanView(
                        controller: controller,
                        scanAreaScale: 1,
                        scanLineColor: Colors.green.shade400,
                        onCapture: (data) {
                          setState(() {
                            qrcode = data;
                            controller.pause();
                            cub.getBarcode(barcode: qrcode);
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
                    cub.showContainerFlag && barcode != null
                        ?
                        // const SizedBox()
                        addContainer(
                            width: width,
                            height: height,
                            readOnly: true,
                            btnText: 'Buy',
                            descriptionController: descriptionController,
                            onTapCancel: () {
                              cub.changeShowContainerFlag(false);
                              controller.resume();
                            },
                            onTapSave: () {
                              barcode!['isGood']
                                  ? cub.updateScore(ChangeScore.increase)
                                  : cub.updateScore(ChangeScore.decrease);

                              cub.changeShowContainerFlag(false);
                              controller.resume();
                            },
                            qrcode: qrcode,
                            onToggle: (value) {},
                            state: barcode!['isGood'],
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
