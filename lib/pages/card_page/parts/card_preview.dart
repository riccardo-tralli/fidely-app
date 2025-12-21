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
  required Function onClose,
  required Function onToggleFlash,
  required Function onSwitchCamera,
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
  Function onClose,
  Function onToggleFlash,
  Function onSwitchCamera,
) => Padding(
  padding: EdgeInsets.symmetric(horizontal: Spaces.small),
  child: SizedBox(
    width: double.infinity,
    height: 260,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(RRadius.medium),
      child: MobileScanner(
        controller: controller,
        onDetect: (value) => onDetect(value),
        overlayBuilder: (context, constraints) => Container(
          margin: EdgeInsets.only(
            top: Spaces.medium,
            right: Spaces.medium,
            bottom: Spaces.medium,
            left: constraints.maxWidth - 76,
          ),
          padding: EdgeInsets.all(Spaces.small),
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(100),
            borderRadius: BorderRadius.circular(RRadius.medium),
          ),
          child: SingleChildScrollView(
            child: Column(
              spacing: Spaces.small,
              children: [
                IconButton.filled(
                  onPressed: () => onClose(),
                  icon: Hicon(
                    HugeIcons.strokeRoundedCancel01,
                    color: Colors.white,
                  ),
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
        ),
      ),
    ),
  ),
);

Widget preview(BuildContext context, LoyaltyCard card, double height) =>
    LoyaltyCardWidget(
      card: card,
      isSelected: true,
      isSelectable: false,
      height: height,
    );
