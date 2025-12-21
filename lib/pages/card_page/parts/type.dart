part of "../card_page.dart";

Widget type({
  required BuildContext context,
  required BarcodeType initialValue,
  required Function(BarcodeType) onChanged,
}) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(
      padding: EdgeInsets.only(left: Spaces.small),
      child: Text(
        L10n.of(context)!.card_page_input_type_title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    ),
    DropdownButtonFormField<BarcodeType>(
      initialValue: initialValue,
      items: [
        DropdownMenuItem(value: BarcodeType.Code39, child: Text("Code 39")),
        DropdownMenuItem(value: BarcodeType.Code93, child: Text("Code 93")),
        DropdownMenuItem(value: BarcodeType.Code128, child: Text("Code 128")),
        DropdownMenuItem(value: BarcodeType.CodeEAN8, child: Text("EAN-8")),
        DropdownMenuItem(value: BarcodeType.CodeEAN13, child: Text("EAN-13")),
        DropdownMenuItem(value: BarcodeType.CodeUPCA, child: Text("UPC-A")),
        DropdownMenuItem(value: BarcodeType.CodeUPCE, child: Text("UPC-E")),
        DropdownMenuItem(value: BarcodeType.Aztec, child: Text("Aztec")),
        DropdownMenuItem(value: BarcodeType.PDF417, child: Text("PDF417")),
        DropdownMenuItem(value: BarcodeType.QrCode, child: Text("QR Code")),
      ],
      onChanged: (value) => onChanged(value!),
      style: Theme.of(context).textTheme.bodyLarge,
    ),
  ],
);
