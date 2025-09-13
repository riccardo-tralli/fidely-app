import "package:barcode_widget/barcode_widget.dart";
import "package:fidely_app/models/loyalty_card.dart";
import "package:fidely_app/widgets/loyalty_card_widget.dart";
import "package:fidely_app/widgets/top_bar.dart";
import "package:flutter/material.dart";
import "package:flutter_colorpicker/flutter_colorpicker.dart";

class CardPage extends StatefulWidget {
  static const route = "/card";

  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController ownerController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  BarcodeType typeValue = BarcodeType.Code93;
  Color colorValue = Colors.white;
  Color tempColor = Colors.white;

  void onColorChange(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Pick a color"),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: colorValue,
            onColorChanged: (color) => tempColor = color,
            pickerAreaHeightPercent: 0.8,
            enableAlpha: false,
            labelTypes: [],
            pickerAreaBorderRadius: BorderRadius.circular(16),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => colorValue = tempColor);
              Navigator.of(context).pop();
            },
            child: const Text("Select"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: TopBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      showTitle: false,
      showActions: false,
    ),
    body: SafeArea(
      child: SingleChildScrollView(
        child: Column(children: [cardPreview(context), form(context)]),
      ),
    ),
  );

  Widget cardPreview(BuildContext context) => Container(
    padding: const EdgeInsets.only(top: 8, right: 16, bottom: 16, left: 16),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.secondary,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(32),
        bottomRight: Radius.circular(32),
      ),
    ),
    child: LoyaltyCardWidget(
      card: LoyaltyCard(
        id: 0,
        title: titleController.text.isEmpty
            ? "Store Name"
            : titleController.text,
        code: codeController.text.isEmpty ? "123456" : codeController.text,
        type: Barcode.fromType(typeValue),
        owner: ownerController.text.isEmpty ? null : ownerController.text,
        color: colorValue,
        note: noteController.text.isEmpty ? null : noteController.text,
      ),
      isSelected: true,
      isSelectable: false,
    ),
  );

  Widget form(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Form(
      child: Column(
        spacing: 16,
        children: [
          title(context),
          code(context),
          type(context),
          owner(context),
          color(context),
          note(context),
          save(context),
        ],
      ),
    ),
  );

  Widget title(BuildContext context) => TextFormField(
    controller: titleController,
    onChanged: (value) => setState(() {}),
    decoration: const InputDecoration(labelText: "Store Name"),
  );

  Widget code(BuildContext context) => TextFormField(
    controller: codeController,
    onChanged: (value) => setState(() {}),
    decoration: const InputDecoration(labelText: "Card Code"),
  );

  Widget type(BuildContext context) => DropdownButtonFormField(
    initialValue: typeValue,
    items: [
      DropdownMenuItem(value: BarcodeType.Code93, child: Text("Code 93")),
      DropdownMenuItem(value: BarcodeType.Code128, child: Text("Code 128")),
      DropdownMenuItem(value: BarcodeType.CodeEAN13, child: Text("EAN-13")),
    ],
    onChanged: (value) => setState(() => typeValue = value!),
    decoration: const InputDecoration(labelText: "Card Type"),
  );

  Widget owner(BuildContext context) => TextFormField(
    controller: ownerController,
    onChanged: (value) => setState(() {}),
    decoration: const InputDecoration(labelText: "Card Owner"),
  );

  Widget note(BuildContext context) => TextFormField(
    controller: noteController,
    onChanged: (value) => setState(() {}),
    decoration: const InputDecoration(labelText: "Note"),
  );

  Widget color(BuildContext context) => InkWell(
    onTap: () => onColorChange(context),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withAlpha(50),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Icon(Icons.color_lens, color: colorValue),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Text(
                "Card Color",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text("Select a surface color for your card"),
            ],
          ),
        ],
      ),
    ),
  );

  Widget save(BuildContext context) =>
      ElevatedButton(onPressed: () {}, child: const Text("Save"));
}
