import 'dart:io';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:fidely_app/cubits/loyalty_card/loyalty_card_cubit.dart';
import 'package:fidely_app/models/loyalty_card.dart';
import 'package:fidely_app/pages/card_page.dart';
import 'package:fidely_app/services/photo_service.dart';
import 'package:fidely_app/widgets/hicon.dart';
import 'package:fidely_app/widgets/photo_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

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
  Color textColor = Colors.white;
  bool isSelected = false;

  void onTap() {
    if (widget.isSelectable) {
      setState(() {
        isSelected = !isSelected;
      });
    }
  }

  void onLongPress(BuildContext context) async {
    if (widget.isSelectable) {
      final File? frontPhoto = await PhotoService.instance.get(
        widget.card.id,
        PhotoType.front,
      );
      final File? rearPhoto = await PhotoService.instance.get(
        widget.card.id,
        PhotoType.rear,
      );

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
                if (frontPhoto != null || rearPhoto != null)
                  Row(
                    spacing: 16,
                    children: [
                      if (frontPhoto != null)
                        PhotoContainer(
                          photo: frontPhoto,
                          borderColor: widget.card.color,
                          pickable: false,
                        ),
                      if (rearPhoto != null)
                        PhotoContainer(
                          photo: rearPhoto,
                          borderColor: widget.card.color,
                          pickable: false,
                        ),
                    ],
                  ),
                Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () => onEdit(context),
                        icon: Hicon(HugeIcons.strokeRoundedEdit04),
                        label: Text(
                          "Edit",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(color: Colors.white),
                        ),
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
                        icon: Hicon(HugeIcons.strokeRoundedDelete02),
                        label: Text(
                          "Delete",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(color: Colors.white),
                        ),
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
            child: Text(
              "Cancel",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.white),
            ),
          ),
          FilledButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<LoyaltyCardCubit>().deleteLoyaltyCard(widget.card);
            },
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.red),
            ),
            icon: Hicon(HugeIcons.strokeRoundedDelete02),
            label: Text(
              "Confirm",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.white),
            ),
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
  Widget build(BuildContext context) {
    textColor = widget.card.color.computeLuminance() > 0.4
        ? Colors.black
        : Colors.white;

    return InkWell(
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
  }

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
            if (widget.card.owner != null && widget.card.owner!.isNotEmpty)
              owner(context),
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
      errorBuilder: (context, _) => barcodeError(context),
    ),
  );

  Widget barcodeError(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.error.withAlpha(15),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      spacing: 16,
      children: [
        Hicon(
          HugeIcons.strokeRoundedAlertDiamond,
          color: Theme.of(context).colorScheme.error,
        ),
        Expanded(
          child: Text(
            "Unable to generate barcode. Please check the code and type.",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
      ],
    ),
  );

  Widget owner(BuildContext context) => Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: textColor.withAlpha(50),
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
