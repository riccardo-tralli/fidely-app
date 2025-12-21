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
import "package:fidely_app/widgets/text_divider.dart";
import "package:fidely_app/widgets/top_bar.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_colorpicker/flutter_colorpicker.dart";
import "package:hugeicons/hugeicons.dart";
import "package:image_picker/image_picker.dart";
import "package:mobile_scanner/mobile_scanner.dart" hide BarcodeType;
import "package:permission_handler/permission_handler.dart";

part "parts/card_preview.dart";
part "parts/title.dart";
part "parts/code.dart";
part "parts/type.dart";
part "parts/owner.dart";
part "parts/category.dart";
part "parts/color.dart";
part "parts/note.dart";
part "parts/photos.dart";
part "parts/save.dart";

// TODO: fix category selection bug (null value) when editing a card just created (having valid category)

class CardPage extends StatefulWidget {
  static const route = "/card";

  final LoyaltyCard? card;

  const CardPage({super.key, this.card});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey _cardPreviewKey = GlobalKey();
  final GlobalKey _customDividerKey = GlobalKey();

  final MobileScannerController _scannerController = MobileScannerController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _ownerController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  BarcodeType _typeValue = BarcodeType.Code39;
  Color _colorValue = Colors.white;
  String? _categoryValue;
  bool _showScanner = false;
  bool _flashOn = false;
  bool _frontCamera = false;
  File? _frontPhoto;
  File? _rearPhoto;

  ScrollController scrollController = ScrollController();
  double _cardPreviewSpace = 0;
  double _minScroll = 0;
  final double _minBarcodeHeight = 50;
  final double _maxBarcodeHeight = 150;
  double _barcodeHeight = 150;

  void onScroll() {
    final double height =
        _maxBarcodeHeight - (scrollController.offset - _minScroll);
    if ((scrollController.offset > _minScroll && height > _minBarcodeHeight) ||
        (scrollController.offset <= _minScroll &&
            height <= _maxBarcodeHeight)) {
      setState(() {
        _barcodeHeight = height;
      });
    }
  }

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

    scrollController.addListener(onScroll);

    // Calculate card preview space and min scroll after first frame rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox dividerBox =
          _customDividerKey.currentContext?.findRenderObject() as RenderBox;
      final RenderBox cardBox =
          _cardPreviewKey.currentContext?.findRenderObject() as RenderBox;

      // Set state with calculated values
      setState(() {
        _cardPreviewSpace = cardBox.size.height + Spaces.medium;
        _minScroll =
            dividerBox.localToGlobal(Offset.zero).dy -
            kToolbarHeight -
            Spaces.medium;
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    resizeToAvoidBottomInset: false,
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
                  spacing: Spaces.medium,
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
      SingleChildScrollView(
        controller: scrollController,
        child: form(context, showScanner),
      ),
      cardPreview(
        key: _cardPreviewKey,
        context: context,
        controller: _scannerController,
        card: LoyaltyCard(
          id: 0,
          title: _titleController.text.isEmpty
              ? L10n.of(context)!.card_page_card_preview_title
              : _titleController.text,
          code: _codeController.text.isEmpty
              ? L10n.of(context)!.card_page_card_preview_code
              : _codeController.text,
          type: _typeValue,
          owner: _ownerController.text.isEmpty ? null : _ownerController.text,
          color: _colorValue,
          note: _noteController.text.isEmpty ? null : _noteController.text,
        ),
        height: _barcodeHeight,
        showScanner: showScanner,
        flashOn: _flashOn,
        frontCamera: _frontCamera,
        onDetect: (value) => onScannerDetect(value),
        onClose: () => setState(() {
          _showScanner = false;
        }),
        onToggleFlash: () {
          _scannerController.toggleTorch();
          setState(() {
            _flashOn = !_flashOn;
          });
        },
        onSwitchCamera: () {
          _scannerController.switchCamera();
          setState(() {
            _frontCamera = !_frontCamera;
          });
        },
      ),
      save(context: context, onTap: (value) => onSave(value)),
    ],
  );

  Widget form(BuildContext context, bool showScanner) => Padding(
    padding: EdgeInsets.only(
      top: _cardPreviewSpace, // * Space under card preview
      bottom: Spaces.large,
    ),
    child: Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Spaces.medium),
            child: Column(
              spacing: Spaces.medium,
              children: [
                title(
                  context: context,
                  controller: _titleController,
                  onChanged: () => setState(() {}),
                ),
                code(
                  context: context,
                  controller: _codeController,
                  onChanged: () => setState(() {}),
                  showScanner: showScanner,
                ),
                type(
                  context: context,
                  initialValue: _typeValue,
                  onChanged: (value) => setState(() {
                    _typeValue = value;
                  }),
                ),
              ],
            ),
          ),
          Padding(
            key: _customDividerKey,
            padding: EdgeInsets.only(top: Spaces.large, bottom: Spaces.medium),
            child: TextDivider(title: "Personalizza la carta", size: .5),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Spaces.medium),
            child: Column(
              spacing: Spaces.medium,
              children: [
                owner(
                  context: context,
                  controller: _ownerController,
                  onChanged: () => setState(() {}),
                ),
                category(
                  context: context,
                  initialValue: _categoryValue,
                  onChanged: (value) => setState(() {
                    _categoryValue = value;
                  }),
                ),
                color(
                  context: context,
                  colorValue: _colorValue,
                  onColorChange: (value) => setState(() => _colorValue = value),
                ),
                note(
                  context: context,
                  controller: _noteController,
                  onChanged: () => setState(() {}),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: Spaces.large),
                  child: photos(
                    context: context,
                    frontPhoto: _frontPhoto,
                    rearPhoto: _rearPhoto,
                    onFrontPhotoTap: (value) => _frontPhoto = value,
                    onRearPhotoTap: (value) => _rearPhoto = value,
                  ),
                ),
                SizedBox(height: 40), // * Space under save button
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
