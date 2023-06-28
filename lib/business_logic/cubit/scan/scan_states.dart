abstract class ScanStates {}

class InitialAdminState extends ScanStates {}

class ChangeEnvState extends ScanStates {}

class ChangeShowContainerState extends ScanStates {}

class CreateBarcodeLoadingScanStates extends ScanStates {}

class CreateBarcodeSuccessScanStates extends ScanStates {}

class CreateBarcodeErrorScanStates extends ScanStates {
  late String error;

  CreateBarcodeErrorScanStates(this.error);
}

class DeleteBarcodeLoadingScanStates extends ScanStates {}

class DeleteBarcodeSuccessScanStates extends ScanStates {}

class DeleteBarcodeErrorScanStates extends ScanStates {
  late String error;

  DeleteBarcodeErrorScanStates(this.error);
}
