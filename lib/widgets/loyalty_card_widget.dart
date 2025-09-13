import 'package:barcode_widget/barcode_widget.dart';
import 'package:fidely_app/models/loyalty_card.dart';
import 'package:flutter/material.dart';

class LoyaltyCardWidget extends StatefulWidget {
  final LoyaltyCard card;
  final bool isSelected;
  final bool isSelectable;

  const LoyaltyCardWidget({
    super.key,
    required this.card,
    this.isSelected = false,
    this.isSelectable = true,
  });

  @override
  State<LoyaltyCardWidget> createState() => _LoyaltyCardWidgetState();
}

class _LoyaltyCardWidgetState extends State<LoyaltyCardWidget> {
  late final Color textColor = widget.card.color.computeLuminance() > 0.4
      ? Colors.black
      : Colors.white;

  bool isSelected = false;

  void onTap() {
    if (widget.isSelectable) {
      setState(() {
        isSelected = !isSelected;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: widget.card.color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(100),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title(context),
          if (isSelected) barcode(context),
          if (widget.card.owner != null) owner(context),
          if (isSelected && widget.card.note != null) note(context),
        ],
      ),
    ),
  );

  Widget title(BuildContext context) => Text(
    widget.card.title,
    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: textColor),
  );

  Widget barcode(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: BarcodeWidget(
      barcode: widget.card.type,
      data: widget.card.code,
      color: textColor,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: textColor),
      errorBuilder: (context, error) => Text(
        error,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: textColor),
      ),
    ),
  );

  Widget owner(BuildContext context) => Text(
    widget.card.owner!,
    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: textColor),
  );

  Widget note(BuildContext context) => Text(
    widget.card.note!,
    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: textColor),
  );
}
