import 'package:barcode_widget/barcode_widget.dart';
import 'package:fidely_app/cubits/loyalty_card/loyalty_card_cubit.dart';
import 'package:fidely_app/models/loyalty_card.dart';
import 'package:fidely_app/pages/card_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  void onLongPress(BuildContext context) {
    if (widget.isSelectable) {
      showModalBottomSheet(
        context: context,
        builder: (context) => SafeArea(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                Text(
                  widget.card.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () => onEdit(context),
                        icon: Icon(Icons.edit),
                        label: Text("Edit"),
                      ),
                    ),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onDelete(context);
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.red),
                        ),
                        icon: Icon(Icons.delete),
                        label: Text("Delete"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  void onEdit(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed(CardPage.route, arguments: widget.card);
  }

  void onDelete(BuildContext context) => showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Delete"),
        content: Text("Are you sure you want to delete this loyalty card?"),
        actions: [
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancel"),
          ),
          FilledButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<LoyaltyCardCubit>().deleteLoyaltyCard(widget.card);
            },
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.red),
            ),
            icon: Icon(Icons.delete),
            label: Text("Confirm"),
          ),
        ],
      );
    },
  );

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    onLongPress: () => onLongPress(context),
    borderRadius: BorderRadius.circular(16),

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
      child: content(context),
    ),
  );

  Widget content(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: double.infinity,
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: [
            title(context),
            if (widget.card.owner != null) owner(context),
          ],
        ),
      ),
      if (isSelected) barcode(context),
      if (isSelected && widget.card.note != null) note(context),
    ],
  );

  Widget title(BuildContext context) => Text(
    widget.card.title,
    style: Theme.of(
      context,
    ).textTheme.headlineLarge?.copyWith(color: textColor),
  );

  Widget barcode(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 16, bottom: 8),
    child: BarcodeWidget(
      barcode: Barcode.fromType(widget.card.type),
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

  Widget owner(BuildContext context) => Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface.withAlpha(50),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      widget.card.owner!,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: textColor),
      overflow: TextOverflow.ellipsis,
    ),
  );

  Widget note(BuildContext context) => Text(
    widget.card.note!,
    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: textColor,
      fontStyle: FontStyle.italic,
    ),
  );
}
