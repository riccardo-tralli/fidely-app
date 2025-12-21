part of "../card_page.dart";

Widget photos({
  required BuildContext context,
  File? frontPhoto,
  File? rearPhoto,
  void Function(File?)? onFrontPhotoTap,
  void Function(File?)? onRearPhotoTap,
}) => Row(
  spacing: Spaces.medium,
  children: [
    PhotoContainer(
      label: L10n.of(context)!.card_page_photo_front_title,
      photo: frontPhoto,
      onTap: onFrontPhotoTap,
    ),
    PhotoContainer(
      label: L10n.of(context)!.card_page_photo_rear_title,
      photo: rearPhoto,
      onTap: onRearPhotoTap,
    ),
  ],
);
