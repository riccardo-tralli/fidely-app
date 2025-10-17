// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:fidely_app/misc/themes/light.dart';
import 'package:fidely_app/repositories/permission_repository.dart';
import 'package:fidely_app/widgets/hicon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PhotoContainer extends StatefulWidget {
  final String? label;
  final File? photo;
  final Color? borderColor;
  final bool pickable;
  final Function(File? photo)? onTap;

  const PhotoContainer({
    super.key,
    this.label,
    this.photo,
    this.borderColor,
    this.pickable = true,
    this.onTap,
  });

  @override
  State<PhotoContainer> createState() => _PermissionState();
}

class _PermissionState extends State<PhotoContainer> {
  File? _pickedPhoto;

  void onTap(BuildContext context, {bool force = false}) => showDialog(
    context: context,
    builder: (context) => _pickedPhoto == null || force
        ? onEmptyPhoto(context)
        : onFilledPhoto(context),
  );

  void pickPhoto(BuildContext context, ImageSource source) async {
    final bool granted = source == ImageSource.camera
        ? await context.read<PermissionRepository>().camera()
        : await context.read<PermissionRepository>().gallery();
    if (granted) {
      Navigator.of(context).pop();
      final XFile? image = await ImagePicker().pickImage(source: source);
      if (image != null) {
        final CroppedFile? cropped = await ImageCropper().cropImage(
          sourcePath: image.path,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop Photo',
              toolbarColor: Colors.black,
              toolbarWidgetColor: Colors.white,
              statusBarLight: false,
              initAspectRatio: CropAspectRatioPreset.ratio16x9,
              lockAspectRatio: false,
              activeControlsWidgetColor: LightTheme.primaryColor,
            ),
            IOSUiSettings(title: 'Crop Photo', aspectRatioLockEnabled: true),
          ],
        );
        setState(() {
          _pickedPhoto = File(cropped?.path ?? image.path);
        });
        widget.onTap?.call(_pickedPhoto!);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _pickedPhoto = widget.photo;
  }

  @override
  void didUpdateWidget(PhotoContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.photo?.path != oldWidget.photo?.path) {
      setState(() {
        _pickedPhoto = widget.photo;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Expanded(
    child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        if (widget.pickable) {
          onTap(context);
        } else if (widget.onTap != null && _pickedPhoto != null) {
          widget.onTap!(_pickedPhoto);
        }
      },
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          color: widget.borderColor ?? Theme.of(context).colorScheme.secondary,
          radius: Radius.circular(16),
          dashPattern: [8, 4],
        ),
        child: SizedBox(
          height: 100,
          child: Stack(
            children: [if (_pickedPhoto != null) image, label(context)],
          ),
        ),
      ),
    ),
  );

  Widget get image => ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: Image.file(
      _pickedPhoto!,
      width: double.infinity,
      height: 100,
      fit: BoxFit.cover,
      color: Colors.black.withAlpha(widget.pickable ? 100 : 0),
      colorBlendMode: BlendMode.darken,
    ),
  );

  Widget label(BuildContext context) => Center(
    child: widget.pickable
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: _pickedPhoto != null
                ? tapToChange(context)
                : tapToPick(context),
          )
        : Text(
            widget.label ?? "",
            style: TextStyle(
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withAlpha(150),
                  offset: Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
  );

  List<Widget> tapToChange(BuildContext context) => [
    Hicon(HugeIcons.strokeRoundedEdit01, color: Colors.white),
    Text(
      "Tap to change",
      style: TextStyle(
        color: Colors.white,
        shadows: [
          Shadow(
            color: Colors.black.withAlpha(150),
            offset: Offset(2, 2),
            blurRadius: 4,
          ),
        ],
      ),
    ),
  ];

  List<Widget> tapToPick(BuildContext context) => [
    Hicon(
      HugeIcons.strokeRoundedAdd01,
      color: Theme.of(context).textTheme.bodyMedium?.color,
    ),
    if (widget.label != null && widget.label!.isNotEmpty) Text(widget.label!),
  ];

  Widget onEmptyPhoto(BuildContext context) => AlertDialog(
    title: Text("Pick a photo"),
    content: Text("How would you like to pick a photo?"),
    actions: [
      FilledButton.icon(
        onPressed: () => pickPhoto(context, ImageSource.camera),
        icon: Hicon(HugeIcons.strokeRoundedCamera01, color: Colors.white),
        label: Text(
          "Camera",
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: Colors.white),
        ),
      ),
      FilledButton.icon(
        onPressed: () => pickPhoto(context, ImageSource.gallery),
        icon: Hicon(HugeIcons.strokeRoundedAlbum02, color: Colors.white),
        label: Text(
          "Gallery",
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: Colors.white),
        ),
      ),
    ],
  );

  Widget onFilledPhoto(BuildContext context) => AlertDialog(
    title: Text("Change photo"),
    content: Text("How would you like to change the photo?"),
    actionsOverflowButtonSpacing: 8,
    actions: [
      FilledButton.icon(
        onPressed: () {
          Navigator.of(context).pop();
          onTap(context, force: true);
        },
        icon: Hicon(HugeIcons.strokeRoundedEdit01, color: Colors.white),
        label: Text(
          "Pick a new photo",
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: Colors.white),
        ),
      ),
      FilledButton.icon(
        onPressed: () {
          Navigator.of(context).pop();
          setState(() {
            _pickedPhoto = null;
          });
          widget.onTap?.call(null);
        },
        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red)),
        icon: Hicon(HugeIcons.strokeRoundedDelete02, color: Colors.white),
        label: Text(
          "Remove photo",
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: Colors.white),
        ),
      ),
    ],
  );
}
