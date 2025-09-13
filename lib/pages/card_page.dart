import "package:barcode_widget/barcode_widget.dart";
import "package:fidely_app/cubits/loyalty_card/loyalty_card_cubit.dart";
import "package:fidely_app/cubits/loyalty_card/loyalty_card_cubit_state.dart";
import "package:fidely_app/models/loyalty_card.dart";
import "package:fidely_app/models/requests/loyalty_card_request.dart";
import "package:fidely_app/widgets/loyalty_card_widget.dart";
import "package:fidely_app/widgets/top_bar.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_colorpicker/flutter_colorpicker.dart";

class CardPage extends StatefulWidget {
  static const route = "/card";

  final LoyaltyCard? card;

  const CardPage({super.key, this.card});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _ownerController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  BarcodeType _typeValue = BarcodeType.Code93;
  Color _colorValue = Colors.white;
  Color _tempColor = Colors.white;

  void onColorChange(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Pick a color"),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: _colorValue,
            onColorChanged: (color) => _tempColor = color,
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
              setState(() => _colorValue = _tempColor);
              Navigator.of(context).pop();
            },
            child: const Text("Select"),
          ),
        ],
      ),
    );
  }

  void onSave(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (widget.card == null) {
        context.read<LoyaltyCardCubit>().addLoyaltyCard(
          LoyaltyCardInsertRequest(
            title: _titleController.text,
            code: _codeController.text,
            type: _typeValue,
            owner: _ownerController.text.isEmpty ? null : _ownerController.text,
            color: _colorValue,
            note: _noteController.text.isEmpty ? null : _noteController.text,
          ),
        );
      } else {
        context.read<LoyaltyCardCubit>().updateLoyaltyCard(
          widget.card!.copyWith(
            title: _titleController.text,
            code: _codeController.text,
            type: _typeValue,
            owner: _ownerController.text.isEmpty ? "" : _ownerController.text,
            color: _colorValue,
            note: _noteController.text.isEmpty ? "" : _noteController.text,
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.card != null) {
      _titleController.text = widget.card!.title;
      _codeController.text = widget.card!.code;
      _typeValue = widget.card!.type;
      _ownerController.text = widget.card!.owner ?? "";
      _colorValue = widget.card!.color;
      _noteController.text = widget.card!.note ?? "";
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: TopBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      showTitle: false,
      showActions: false,
    ),
    body: SafeArea(
      child: BlocListener<LoyaltyCardCubit, LoyaltyCardCubitState>(
        listener: (context, state) {
          if (state is LoyaltyCardCubitAddSuccessState) {
            Navigator.of(context).pop();
          }
          if (state is LoyaltyCardCubitUpdateSuccessState) {
            Navigator.of(context).pop();
          }
          if (state is LoyaltyCardCubitErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Error: ${state.message}")));
          }
        },
        child: SingleChildScrollView(
          child: Column(children: [cardPreview(context), form(context)]),
        ),
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
        title: _titleController.text.isEmpty
            ? "Store Name"
            : _titleController.text,
        code: _codeController.text.isEmpty ? "123456" : _codeController.text,
        type: _typeValue,
        owner: _ownerController.text.isEmpty ? null : _ownerController.text,
        color: _colorValue,
        note: _noteController.text.isEmpty ? null : _noteController.text,
      ),
      isSelected: true,
      isSelectable: false,
    ),
  );

  Widget form(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Form(
      key: _formKey,
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
    controller: _titleController,
    onChanged: (value) => setState(() {}),
    validator: (value) => value == null || value.isEmpty ? "Required" : null,
    decoration: const InputDecoration(labelText: "Store Name"),
  );

  Widget code(BuildContext context) => TextFormField(
    controller: _codeController,
    onChanged: (value) => setState(() {}),
    validator: (value) => value == null || value.isEmpty ? "Required" : null,
    decoration: const InputDecoration(labelText: "Card Code"),
  );

  Widget type(BuildContext context) => DropdownButtonFormField(
    initialValue: _typeValue,
    items: [
      DropdownMenuItem(value: BarcodeType.Code93, child: Text("Code 93")),
      DropdownMenuItem(value: BarcodeType.Code128, child: Text("Code 128")),
      DropdownMenuItem(value: BarcodeType.CodeEAN13, child: Text("EAN-13")),
    ],
    onChanged: (value) => setState(() => _typeValue = value!),
    decoration: const InputDecoration(labelText: "Card Type"),
  );

  Widget owner(BuildContext context) => TextFormField(
    controller: _ownerController,
    onChanged: (value) => setState(() {}),
    decoration: const InputDecoration(labelText: "Card Owner"),
  );

  Widget note(BuildContext context) => TextFormField(
    controller: _noteController,
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
          Icon(Icons.color_lens, color: _colorValue),
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

  Widget save(BuildContext context) => ElevatedButton(
    onPressed: () => onSave(context),
    child: const Text("Save"),
  );
}
