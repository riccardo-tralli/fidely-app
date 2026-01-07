part of "../card_page.dart";

Widget cardPreview({
  required Key key,
  required BuildContext context,
  required MobileScannerController controller,
  required LoyaltyCard card,
  required double height,
  required bool showScanner,
  required bool flashOn,
  required bool frontCamera,
  required Function(BarcodeCapture capture) onDetect,
  required Function() onClose,
  required Function() onToggleFlash,
  required Function() onSwitchCamera,
}) => Container(
  key: key,
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
      BoxShadow(color: Theme.of(context).colorScheme.shadow, blurRadius: 5),
    ],
  ),
  child: showScanner
      ? scanner(
          context,
          controller,
          onDetect,
          flashOn,
          frontCamera,
          onClose,
          onToggleFlash,
          onSwitchCamera,
        )
      : preview(context, card, height),
);

Widget scanner(
  BuildContext context,
  MobileScannerController controller,
  Function(BarcodeCapture capture) onDetect,
  bool flashOn,
  bool frontCamera,
  Function() onClose,
  Function() onToggleFlash,
  Function() onSwitchCamera,
) => Padding(
  padding: EdgeInsets.symmetric(horizontal: Spaces.small),
  child: SizedBox(
    width: double.infinity,
    height: 240,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(RRadius.medium),
      child: Stack(
        children: [
          Positioned.fill(
            child: MobileScanner(
              controller: controller,
              onDetect: (value) => onDetect(value),
            ),
          ),
          buttons(
            context,
            flashOn,
            frontCamera,
            onClose,
            onToggleFlash,
            onSwitchCamera,
          ),
        ],
      ),
    ),
  ),
);

Widget buttons(
  BuildContext context,
  bool flashOn,
  bool frontCamera,
  Function() onClose,
  Function() onToggleFlash,
  Function() onSwitchCamera,
) => Positioned(
  top: Spaces.zero,
  right: Spaces.zero,
  bottom: Spaces.zero,
  child: Container(
    padding: EdgeInsets.all(Spaces.small),
    decoration: BoxDecoration(
      color: Colors.black.withAlpha(100),
      borderRadius: BorderRadius.circular(RRadius.medium),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: Spaces.small,
      children: [
        IconButton.filled(
          onPressed: () => onClose(),
          icon: Hicon(HugeIcons.strokeRoundedCancel01, color: Colors.white),
        ),
        IconButton.filled(
          onPressed: () => onToggleFlash(),
          icon: Hicon(
            flashOn
                ? HugeIcons.strokeRoundedFlash
                : HugeIcons.strokeRoundedFlashOff,
            color: Colors.white,
          ),
        ),
        IconButton.filled(
          onPressed: () => onSwitchCamera(),
          icon: Hicon(
            frontCamera
                ? HugeIcons.strokeRoundedCamera01
                : HugeIcons.strokeRoundedFaceId,
            color: Colors.white,
          ),
        ),
      ],
    ),
  ),
);

Widget preview(BuildContext context, LoyaltyCard card, double height) =>
    LoyaltyCardWidget(
      card: card,
      isSelectable: false,
      height: height,
      showTitle: height > 120,
    );
