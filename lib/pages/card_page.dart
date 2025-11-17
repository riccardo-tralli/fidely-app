// ignore_for_file: use_build_context_synchronously

import "dart:io";

import "package:barcode_widget/barcode_widget.dart";
import "package:change_case/change_case.dart";
import "package:fidely_app/cubits/loyalty_card/loyalty_card_cubit.dart";
import "package:fidely_app/cubits/permission/permission_cubit.dart";
import "package:fidely_app/l10n/l10n.dart";
import "package:fidely_app/misc/barcode_parser.dart";
import "package:fidely_app/misc/themes/rradius.dart";
import "package:fidely_app/misc/themes/spaces.dart";
import "package:fidely_app/models/category.dart";
import "package:fidely_app/models/loyalty_card.dart";
import "package:fidely_app/models/requests/loyalty_card_request.dart";
import "package:fidely_app/services/photo_service.dart";
import "package:fidely_app/widgets/hicon.dart";
import "package:fidely_app/widgets/loyalty_card_widget.dart";
import "package:fidely_app/widgets/photo_container.dart";
import "package:fidely_app/widgets/top_bar.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_colorpicker/flutter_colorpicker.dart";
import "package:hugeicons/hugeicons.dart";
import "package:image_picker/image_picker.dart";
import "package:mobile_scanner/mobile_scanner.dart" hide BarcodeType;
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

  final MobileScannerController _scannerController = MobileScannerController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _ownerController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  BarcodeType _typeValue = BarcodeType.Code39;
  Color _colorValue = Colors.white;
  Category? _categoryValue;
  Color _tempColor = Colors.white;
  bool _showScanner = false;
  bool _flashOn = false;
  bool _frontCamera = false;
  File? _frontPhoto;
  File? _rearPhoto;

  void onPickUpCode(BuildContext context) => showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(L10n.of(context)!.card_page_code_pick_title),
        content: Text(L10n.of(context)!.card_page_code_pick_description),
        actionsOverflowButtonSpacing: 8,
        actions: [
          FilledButton.icon(
            onPressed: () {
              context.read<PermissionCubit>().requestCameraPermission();
              Navigator.of(context).pop();
            },
            icon: Hicon(HugeIcons.strokeRoundedCamera01, color: Colors.white),
            label: Text(
              L10n.of(context)!.card_page_code_pick_buttons_camera,
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
            icon: Hicon(HugeIcons.strokeRoundedAlbum02, color: Colors.white),
            label: Text(
              L10n.of(context)!.card_page_code_pick_buttons_gallery,
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
      final BarcodeCapture? capture = await _scannerController.analyzeImage(
        image.path,
      );
      if (capture != null) {
        onScannerDetect(capture);
      }
    }
  }

  void onScannerDetect(BarcodeCapture capture) {
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
        title: Text(L10n.of(context)!.card_page_color_pick_title),
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
        actionsOverflowButtonSpacing: 8,
        actions: [
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.grey),
            ),
            child: Text(
              L10n.of(context)!.card_page_color_pick_buttons_cancel,
              style: TextStyle(color: Colors.white),
            ),
          ),
          FilledButton.icon(
            onPressed: () {
              setState(() => _colorValue = _tempColor);
              Navigator.of(context).pop();
            },
            icon: Hicon(HugeIcons.strokeRoundedTick01, color: Colors.white),
            label: Text(
              L10n.of(context)!.card_page_color_pick_buttons_confirm,
              style: TextStyle(color: Colors.white),
            ),
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
            category: _categoryValue,
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
            category: _categoryValue,
          ),
        );
      }
    }
  }

  Future<void> savePhotos(int cardId) async {
    if (_frontPhoto != null) {
      if (_frontPhoto!.path !=
          PhotoService.instance.getPath(cardId, PhotoType.front)) {
        await PhotoService.instance.save(cardId, PhotoType.front, _frontPhoto!);
      }
    } else {
      await PhotoService.instance.delete(cardId, PhotoType.front);
    }
    if (_rearPhoto != null) {
      if (_rearPhoto!.path !=
          PhotoService.instance.getPath(cardId, PhotoType.rear)) {
        await PhotoService.instance.save(cardId, PhotoType.rear, _rearPhoto!);
      }
    } else {
      await PhotoService.instance.delete(cardId, PhotoType.rear);
    }
  }

  Future<void> loadPhotos() async {
    _frontPhoto = await PhotoService.instance.get(
      widget.card!.id,
      PhotoType.front,
    );
    _rearPhoto = await PhotoService.instance.get(
      widget.card!.id,
      PhotoType.rear,
    );
    setState(() {});
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
      _categoryValue = widget.card!.category;

      loadPhotos();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: TopBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      showTitle: false,
    ),
    body: SafeArea(child: cardCubitListener(context)),
  );

  Widget cardCubitListener(
    BuildContext context,
  ) => BlocListener<LoyaltyCardCubit, LoyaltyCardCubitState>(
    listener: (context, state) async {
      if (state is LoyaltyCardCubitAddSuccessState) {
        await savePhotos(state.card.id);
        Navigator.of(context).pop();
      }
      if (state is LoyaltyCardCubitUpdateSuccessState) {
        await savePhotos(state.card.id);
        Navigator.of(context).pop();
      }
      if (state is LoyaltyCardCubitErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "${L10n.of(context)!.card_page_generic_error_title}: ${state.message}",
            ),
          ),
        );
      }
    },
    child: permissionCubitListener(context),
  );

  Widget permissionCubitListener(BuildContext context) =>
      BlocConsumer<PermissionCubit, PermissionState>(
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
                    Hicon(HugeIcons.strokeRoundedAlert02),
                    Expanded(
                      child: Text(
                        L10n.of(context)!.card_page_permission_error_title,
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

  Widget body(BuildContext context, bool showScanner) => Stack(
    children: [
      Expanded(child: SingleChildScrollView(child: form(context, showScanner))),
      cardPreview(context, showScanner),
      save(context),
    ],
  );

  Widget cardPreview(BuildContext context, bool showScanner) => Container(
    padding: EdgeInsets.only(
      right: Spaces.medium,
      bottom: Spaces.large,
      left: Spaces.medium,
    ),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(RRadius.large),
        bottomRight: Radius.circular(RRadius.large),
      ),
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).colorScheme.onSurface,
          blurRadius: 5,
        ),
      ],
    ),
    child: showScanner
        ? scanner(context)
        : LoyaltyCardWidget(
            card: LoyaltyCard(
              id: 0,
              title: _titleController.text.isEmpty
                  ? L10n.of(context)!.card_page_card_preview_title
                  : _titleController.text,
              code: _codeController.text.isEmpty
                  ? L10n.of(context)!.card_page_card_preview_code
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
        child: MobileScanner(
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
                    onPressed: () {
                      setState(() {
                        _showScanner = false;
                      });
                    },
                    icon: Hicon(
                      HugeIcons.strokeRoundedCancel01,
                      color: Colors.white,
                    ),
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
                      color: Colors.white,
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
                      color: Colors.white,
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
    padding: EdgeInsets.only(
      top: 300, // * Space under card preview
      right: Spaces.large,
      bottom: Spaces.large,
      left: Spaces.large,
    ),
    child: Form(
      key: _formKey,
      child: Column(
        spacing: Spaces.medium,
        children: [
          title(context),
          code(context, showScanner),
          type(context),
          // owner(context),
          // color(context),
          // note(context),
          // category(context),
          // Padding(
          //   padding: EdgeInsets.symmetric(vertical: Spaces.medium),
          //   child: photos(context),
          // ),
          SizedBox(height: 50), // * Space under save button
        ],
      ),
    ),
  );

  Widget title(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(left: Spaces.small),
        child: Text(
          L10n.of(context)!.card_page_input_store_name_title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      TextFormField(
        controller: _titleController,
        onChanged: (value) => setState(() {}),
        validator: (value) => value == null || value.isEmpty
            ? L10n.of(context)!.card_page_input_error_required
            : null,
      ),
    ],
  );

  Widget code(BuildContext context, bool showScanner) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(left: Spaces.small),
        child: Text(
          L10n.of(context)!.card_page_input_code_title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      TextFormField(
        controller: _codeController,
        onChanged: (value) => setState(() {}),
        validator: (value) => value == null || value.isEmpty
            ? L10n.of(context)!.card_page_input_error_required
            : null,
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
        padding: EdgeInsets.only(left: Spaces.small),
        child: Text(
          L10n.of(context)!.card_page_input_type_title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
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
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    ],
  );

  Widget owner(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(left: Spaces.small),
        child: Text(L10n.of(context)!.card_page_input_owner_title),
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
        padding: EdgeInsets.only(left: Spaces.small),
        child: Text(L10n.of(context)!.card_page_input_notes_title),
      ),
      TextFormField(
        controller: _noteController,
        onChanged: (value) => setState(() {}),
        maxLines: 3,
      ),
    ],
  );

  Widget category(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(left: Spaces.small),
        child: Text(L10n.of(context)!.card_page_input_category_title),
      ),
      DropdownButtonFormField(
        initialValue: _categoryValue,
        items: [
          DropdownMenuItem(
            value: null,
            child: Text(L10n.of(context)!.card_page_input_category_option_none),
          ),
          DropdownMenuItem(
            value: Category.market,
            child: Text(
              L10n.of(context)!.card_page_input_category_option_grocery,
            ),
          ),
          DropdownMenuItem(
            value: Category.food,
            child: Text(L10n.of(context)!.card_page_input_category_option_food),
          ),
          DropdownMenuItem(
            value: Category.fuel,
            child: Text(L10n.of(context)!.card_page_input_category_option_fuel),
          ),
          DropdownMenuItem(
            value: Category.entertainment,
            child: Text(
              L10n.of(context)!.card_page_input_category_option_entertainment,
            ),
          ),
          DropdownMenuItem(
            value: Category.fashion,
            child: Text(
              L10n.of(context)!.card_page_input_category_option_fashion,
            ),
          ),
          DropdownMenuItem(
            value: Category.electronics,
            child: Text(
              L10n.of(context)!.card_page_input_category_option_electronics,
            ),
          ),
          DropdownMenuItem(
            value: Category.health,
            child: Text(
              L10n.of(context)!.card_page_input_category_option_health,
            ),
          ),
          DropdownMenuItem(
            value: Category.travel,
            child: Text(
              L10n.of(context)!.card_page_input_category_option_travel,
            ),
          ),
          DropdownMenuItem(
            value: Category.sport,
            child: Text(
              L10n.of(context)!.card_page_input_category_option_sport,
            ),
          ),
          DropdownMenuItem(
            value: Category.other,
            child: Text(
              L10n.of(context)!.card_page_input_category_option_other,
            ),
          ),
        ],
        onChanged: (value) {
          setState(() {
            _categoryValue = value;
          });
        },
      ),
    ],
  );

  Widget color(BuildContext context) => InkWell(
    onTap: () => onColorChange(context),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        border: Border.all(color: Theme.of(context).colorScheme.outline),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 12,
        children: [
          Hicon(HugeIcons.strokeRoundedPaintBoard, color: _colorValue),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  L10n.of(context)!.card_page_color_title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(L10n.of(context)!.card_page_color_description),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget photos(BuildContext context) => Row(
    spacing: 16,
    children: [
      PhotoContainer(
        label: L10n.of(context)!.card_page_photo_front_title,
        photo: _frontPhoto,
        onTap: (photo) => _frontPhoto = photo,
      ),
      PhotoContainer(
        label: L10n.of(context)!.card_page_photo_rear_title,
        photo: _rearPhoto,
        onTap: (photo) => _rearPhoto = photo,
      ),
    ],
  );

  Widget save(BuildContext context) => Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(color: Theme.of(context).colorScheme.outline),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: Spaces.large,
          left: Spaces.large,
          right: Spaces.large,
          bottom: Spaces.small,
        ),
        child: SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () => onSave(context),
            style: Theme.of(context).filledButtonTheme.style?.copyWith(
              backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).colorScheme.secondary,
              ),
            ),
            child: Text(
              L10n.of(context)!.card_page_save_button_title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ),
    ),
  );
}
