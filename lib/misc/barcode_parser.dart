import 'package:barcode_widget/barcode_widget.dart';
import 'package:mobile_scanner/mobile_scanner.dart' hide BarcodeType;

class BarcodeParser {
  static BarcodeType? parse(BarcodeFormat format) {
    switch (format) {
      case BarcodeFormat.code39:
        return BarcodeType.Code39;
      case BarcodeFormat.code93:
        return BarcodeType.Code93;
      case BarcodeFormat.code128:
        return BarcodeType.Code128;
      case BarcodeFormat.ean8:
        return BarcodeType.CodeEAN8;
      case BarcodeFormat.ean13:
        return BarcodeType.CodeEAN13;
      case BarcodeFormat.upcA:
        return BarcodeType.CodeUPCA;
      case BarcodeFormat.upcE:
        return BarcodeType.CodeUPCE;
      case BarcodeFormat.aztec:
        return BarcodeType.Aztec;
      case BarcodeFormat.pdf417:
        return BarcodeType.PDF417;
      case BarcodeFormat.qrCode:
        return BarcodeType.QrCode;
      default:
        return null;
    }
  }
}
