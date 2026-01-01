// ignore_for_file: use_build_context_synchronously

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
    context.read<LoyaltyCardCubit>().updateLoyaltyCard(
      widget.card.copyWith(usageCount: widget.card.usageCount + 1),
    );

    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(Spaces.large),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: Spaces.small,
              children: [
                titleRow(context, widget),
                barcode(context, widget),
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
      ),
    );
  }
}

Widget titleRow(BuildContext context, LoyaltyCardWidget widget) => Row(
  spacing: Spaces.small,
  children: [
    SizedBox(
      width: 10,
      height: 10,
      child: CircleAvatar(backgroundColor: widget.card.color),
    ),
    Expanded(child: title(context, widget.card.title)),
    favoriteButton(widget),
  ],
);

Widget title(BuildContext context, String content) =>
    Text(content, style: Theme.of(context).textTheme.headlineLarge);

Widget favoriteButton(LoyaltyCardWidget widget) =>
    BlocBuilder<LoyaltyCardCubit, LoyaltyCardCubitState>(
      builder: (context, state) => IconButton(
        onPressed: () {
          bool isFavorite = widget.card.favorite;
          if (state is LoyaltyCardCubitUpdateSuccessState &&
              widget.card.favorite != state.card.favorite) {
            isFavorite = state.card.favorite;
          }
          context.read<LoyaltyCardCubit>().updateLoyaltyCard(
            widget.card.copyWith(favorite: !isFavorite),
          );
        },
        icon: Hicon(
          HugeIcons.strokeRoundedFavourite,
          color:
              state is LoyaltyCardCubitUpdateSuccessState && state.card.favorite
              ? Colors.red
              : null,
        ),
      ),
    );

Widget barcode(BuildContext context, LoyaltyCardWidget widget) => InkWell(
  onTap: () async {
    await Clipboard.setData(ClipboardData(text: widget.card.code));
    AlertInfo.show(
      context: context,
      text: L10n.of(context)!.card_barcode_tap,
      position: MessagePosition.bottom,
    );
  },
  child: BarcodeWidget(
    data: widget.card.code,
    barcode: Barcode.fromType(widget.card.type),
    drawText: true,
    height: 150,
    color: Theme.of(context).brightness == Brightness.light
        ? Colors.black
        : Colors.white,
  ),
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
