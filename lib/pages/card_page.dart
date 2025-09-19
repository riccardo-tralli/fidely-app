import "package:barcode_widget/barcode_widget.dart";
import "package:change_case/change_case.dart";
import "package:fidely_app/cubits/loyalty_card/loyalty_card_cubit.dart";
import "package:fidely_app/cubits/permission/permission_cubit.dart";
import "package:fidely_app/misc/barcode_parser.dart";
import "package:fidely_app/models/loyalty_card.dart";
import "package:fidely_app/models/requests/loyalty_card_request.dart";
import "package:fidely_app/widgets/hicon.dart";
import "package:fidely_app/widgets/loyalty_card_widget.dart";
import "package:fidely_app/widgets/top_bar.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_colorpicker/flutter_colorpicker.dart";
import "package:hugeicons/hugeicons.dart";
import "package:image_picker/image_picker.dart";
import "package:mobile_scanner/mobile_scanner.dart" as mobile_scanner;
import "package:permission_handler/permission_handler.dart";

class CardPage extends StatefulWidget {
  static const route = "/card";

  final LoyaltyCard? card;

  const CardPage({super.key, this.card});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final mobile_scanner.MobileScannerController _scannerController =
      mobile_scanner.MobileScannerController(autoStart: true);
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _ownerController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  BarcodeType _typeValue = BarcodeType.Code39;
  Color _colorValue = Colors.white;
  Color _tempColor = Colors.white;
  bool _showScanner = false;
  bool _flashOn = false;
  bool _frontCamera = false;

  void onPickUpCode(BuildContext context) => showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Pick a code"),
        content: Text("How would you like to pick a code?"),
        actions: [
          FilledButton.icon(
            onPressed: () {
              context.read<PermissionCubit>().requestCameraPermission();
              Navigator.of(context).pop();
            },
            icon: Hicon(HugeIcons.strokeRoundedCamera01),
            label: Text(
              "Camera",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.white),
            ),
          ),
          FilledButton.icon(
            onPressed: () {
              context.read<PermissionCubit>().requestGalleryPermission();
              Navigator.of(context).pop();
            },
            icon: Hicon(HugeIcons.strokeRoundedAlbum02),
            label: Text(
              "Gallery",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );

  void onGalleryScan() async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      final mobile_scanner.BarcodeCapture? capture = await _scannerController
          .analyzeImage(image.path);
      if (capture != null) {
        onScannerDetect(capture);
      }
    }
  }

  void onScannerDetect(mobile_scanner.BarcodeCapture capture) {
    if (capture.barcodes.isNotEmpty) {
      setState(() {
        _codeController.text = capture.barcodes.first.rawValue ?? "";
        _typeValue =
            BarcodeParser.parse(capture.barcodes.first.format) ??
            BarcodeType.Code39;
        _showScanner = false;
      });
    }
  }

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
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.grey.shade400),
            ),
            child: const Text("Cancel"),
          ),
          FilledButton.icon(
            onPressed: () {
              setState(() => _colorValue = _tempColor);
              Navigator.of(context).pop();
            },
            icon: Hicon(HugeIcons.strokeRoundedTick01),
            label: Text("Select"),
          ),
        ],
      ),
    );
  }

  void onSave(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _titleController.text = _titleController.text
          .trim()
          .toLowerCase()
          .toCapitalCase();
      _codeController.text = _codeController.text.trim().toUpperCase();
      _ownerController.text = _ownerController.text
          .trim()
          .toLowerCase()
          .toCapitalCase();
      _noteController.text = _noteController.text.trim();

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
    body: SafeArea(child: cardCubitListener(context)),
  );

  Widget cardCubitListener(BuildContext context) =>
      BlocListener<LoyaltyCardCubit, LoyaltyCardCubitState>(
        listener: (context, state) {
          if (state is LoyaltyCardCubitAddSuccessState ||
              state is LoyaltyCardCubitUpdateSuccessState) {
            Navigator.of(context).pop();
          }
          if (state is LoyaltyCardCubitErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Error: ${state.message}")));
          }
        },
        child: permissionCubitListener(context),
      );

  Widget permissionCubitListener(
    BuildContext context,
  ) => BlocConsumer<PermissionCubit, PermissionState>(
    listener: (context, state) {
      if (state is PermissionGrantedState) {
        if (state.permission == Permission.camera) {
          setState(() {
            _showScanner = true;
          });
        }
        if (state.permission == Permission.photos) {
          onGalleryScan();
        }
      }
      if (state is PermissionDeniedState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              spacing: 16,
              children: [
                Hicon(
                  HugeIcons.strokeRoundedAlert02,
                  color: Theme.of(
                    context,
                  ).snackBarTheme.contentTextStyle?.color,
                ),
                Expanded(
                  child: Text(
                    "Permission denied. Please go to device settings to enable it.",
                  ),
                ),
              ],
            ),
          ),
        );
      }
    },
    builder: (context, state) => body(
      context,
      _showScanner &&
          (state is PermissionGrantedState &&
              state.permission == Permission.camera),
    ),
  );

  Widget body(BuildContext context, bool showScanner) => Column(
    children: [
      cardPreview(context, showScanner),
      Expanded(child: SingleChildScrollView(child: form(context, showScanner))),
    ],
  );

  Widget cardPreview(BuildContext context, bool showScanner) => Container(
    padding: const EdgeInsets.only(right: 16, bottom: 24, left: 16),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.secondary,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(32),
        bottomRight: Radius.circular(32),
      ),
    ),
    child: showScanner
        ? scanner(context)
        : LoyaltyCardWidget(
            card: LoyaltyCard(
              id: 0,
              title: _titleController.text.isEmpty
                  ? "Store Name"
                  : _titleController.text,
              code: _codeController.text.isEmpty
                  ? "123456"
                  : _codeController.text,
              type: _typeValue,
              owner: _ownerController.text.isEmpty
                  ? null
                  : _ownerController.text,
              color: _colorValue,
              note: _noteController.text.isEmpty ? null : _noteController.text,
            ),
            isSelected: true,
            isSelectable: false,
          ),
  );

  Widget scanner(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: SizedBox(
      width: double.infinity,
      height: 260,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: mobile_scanner.MobileScanner(
          controller: _scannerController,
          onDetect: onScannerDetect,
          overlayBuilder: (context, constraints) => Container(
            margin: EdgeInsets.only(
              top: 16,
              right: 16,
              bottom: 16,
              left: constraints.maxWidth - 76,
            ),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(100),
              borderRadius: BorderRadius.circular(16),
            ),
            child: SingleChildScrollView(
              child: Column(
                spacing: 8,
                children: [
                  IconButton.filled(
                    onPressed: () => setState(() {
                      _showScanner = false;
                    }),
                    icon: Hicon(HugeIcons.strokeRoundedCancel01),
                  ),
                  IconButton.filled(
                    onPressed: () {
                      _scannerController.toggleTorch();
                      setState(() {
                        _flashOn = !_flashOn;
                      });
                    },
                    icon: Hicon(
                      _flashOn
                          ? HugeIcons.strokeRoundedFlash
                          : HugeIcons.strokeRoundedFlashOff,
                    ),
                  ),
                  IconButton.filled(
                    onPressed: () {
                      _scannerController.switchCamera();
                      setState(() {
                        _frontCamera = !_frontCamera;
                      });
                    },
                    icon: Hicon(
                      _frontCamera
                          ? HugeIcons.strokeRoundedCamera01
                          : HugeIcons.strokeRoundedFaceId,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );

  Widget form(BuildContext context, bool showScanner) => Padding(
    padding: const EdgeInsets.all(24),
    child: Form(
      key: _formKey,
      child: Column(
        spacing: 8,
        children: [
          title(context),
          code(context, showScanner),
          type(context),
          owner(context),
          color(context),
          note(context),
          SizedBox(width: double.infinity, child: save(context)),
        ],
      ),
    ),
  );

  Widget title(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text("Store Name"),
      ),
      TextFormField(
        controller: _titleController,
        onChanged: (value) => setState(() {}),
        validator: (value) =>
            value == null || value.isEmpty ? "Required" : null,
      ),
    ],
  );

  Widget code(BuildContext context, bool showScanner) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text("Card Code"),
      ),
      TextFormField(
        controller: _codeController,
        onChanged: (value) => setState(() {}),
        validator: (value) =>
            value == null || value.isEmpty ? "Required" : null,
        decoration: showScanner
            ? null
            : InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () => onPickUpCode(context),
                  icon: Hicon(HugeIcons.strokeRoundedSelect01),
                ),
              ),
      ),
    ],
  );

  Widget type(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text("Card Type"),
      ),
      DropdownButtonFormField(
        initialValue: _typeValue,
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
        onChanged: (value) => setState(() => _typeValue = value!),
      ),
    ],
  );

  Widget owner(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text("Card Owner"),
      ),
      TextFormField(
        controller: _ownerController,
        onChanged: (value) => setState(() {}),
      ),
    ],
  );

  Widget note(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text("Card Note"),
      ),
      TextFormField(
        controller: _noteController,
        onChanged: (value) => setState(() {}),
        maxLines: 3,
      ),
    ],
  );

  Widget color(BuildContext context) => InkWell(
    onTap: () => onColorChange(context),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 12,
        children: [
          Hicon(HugeIcons.strokeRoundedPaintBoard, color: _colorValue),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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

  Widget save(BuildContext context) => FilledButton.icon(
    onPressed: () => onSave(context),
    icon: const Hicon(HugeIcons.strokeRoundedFloppyDisk),
    label: Text(
      "Save",
      style: Theme.of(
        context,
      ).textTheme.bodyLarge?.copyWith(color: Colors.white),
    ),
  );
}
