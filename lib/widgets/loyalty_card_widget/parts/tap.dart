part of "../loyalty_card_widget.dart";

void showPhoto(BuildContext context, File photo) => showDialog(
  barrierColor: Theme.of(context).scaffoldBackgroundColor.withAlpha(220),
  context: context,
  builder: (context) => Dialog(
    child: InkWell(
      borderRadius: BorderRadius.circular(RRadius.medium),
      onTap: () => Navigator.of(context).pop(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(RRadius.medium),
        child: Image.file(photo),
      ),
    ),
  ),
);

void onTap({
  required BuildContext context,
  required LoyaltyCardWidget widget,
  File? frontPhoto,
  File? rearPhoto,
}) {
  if (widget.isSelectable) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Spaces.large),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: Spaces.small,
            children: [
              title(context, widget.card.title, widget.card.color),
              BarcodeWidget(
                data: widget.card.code,
                barcode: Barcode.fromType(widget.card.type),
                drawText: true,
                height: 150,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: Spaces.small,
                children: [
                  if (widget.card.owner != null &&
                      widget.card.owner!.isNotEmpty)
                    owner(context, widget.card.owner!),
                  if (widget.card.category != null)
                    category(context, widget.card.category!),
                ],
              ),
              if (widget.card.note != null && widget.card.note!.isNotEmpty)
                notes(context, widget.card.note!),
              if (frontPhoto != null || rearPhoto != null)
                Padding(
                  padding: EdgeInsets.only(top: Spaces.small),
                  child: photos(
                    context,
                    frontPhoto,
                    rearPhoto,
                    widget.card.color,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget title(BuildContext context, String content, Color color) => Row(
  spacing: Spaces.small,
  children: [
    SizedBox(
      width: 10,
      height: 10,
      child: CircleAvatar(backgroundColor: color),
    ),
    Text(content, style: Theme.of(context).textTheme.headlineLarge),
  ],
);

Widget owner(BuildContext context, String content) => Expanded(
  child: Row(
    spacing: Spaces.small,
    children: [
      Hicon(HugeIcons.strokeRoundedUser02),
      Expanded(child: Text(content, overflow: TextOverflow.ellipsis)),
    ],
  ),
);

Widget category(BuildContext context, String category) {
  final Category cat = Categories(context).fromName(category);
  return RoundChip(label: cat.label, icon: cat.icon);
}

Widget notes(BuildContext context, String content) => Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  spacing: Spaces.small,
  children: [
    Hicon(HugeIcons.strokeRoundedNote02),
    Text(content, style: Theme.of(context).textTheme.bodySmall),
  ],
);

Widget photos(
  BuildContext context,
  File? frontPhoto,
  File? rearPhoto,
  Color color,
) => Row(
  spacing: Spaces.medium,
  children: [
    if (frontPhoto != null)
      PhotoContainer(
        photo: frontPhoto,
        borderColor: color,
        pickable: false,
        onTap: (photo) => showPhoto(context, photo!),
      ),
    if (rearPhoto != null)
      PhotoContainer(
        photo: rearPhoto,
        borderColor: color,
        pickable: false,
        onTap: (photo) => showPhoto(context, photo!),
      ),
  ],
);
