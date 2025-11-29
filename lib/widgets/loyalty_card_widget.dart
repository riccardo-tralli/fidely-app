// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:fidely_app/cubits/loyalty_card/loyalty_card_cubit.dart';
import 'package:fidely_app/l10n/l10n.dart';
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
  final double? height;

  const LoyaltyCardWidget({
    super.key,
    required this.card,
    this.isSelected = false,
    this.isSelectable = true,
    this.height,
  });

  @override
  State<LoyaltyCardWidget> createState() => _LoyaltyCardWidgetState();
}

class _LoyaltyCardWidgetState extends State<LoyaltyCardWidget> {
  Color textColor = Colors.white;
  bool isSelected = false;

  void showPhoto(File photo) => showDialog(
    barrierColor: Theme.of(context).scaffoldBackgroundColor.withAlpha(220),
    context: context,
    builder: (context) => Dialog(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.of(context).pop(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.file(photo),
        ),
      ),
    ),
  );

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
                          onTap: (photo) => showPhoto(photo!),
                        ),
                      if (rearPhoto != null)
                        PhotoContainer(
                          photo: rearPhoto,
                          borderColor: widget.card.color,
                          pickable: false,
                          onTap: (photo) => showPhoto(photo!),
                        ),
                    ],
                  ),
                Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () => onEdit(context),
                        icon: Hicon(
                          HugeIcons.strokeRoundedEdit04,
                          color: Colors.white,
                        ),
                        label: Text(
                          L10n.of(context)!.card_edit_title,
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
                        icon: Hicon(
                          HugeIcons.strokeRoundedDelete02,
                          color: Colors.white,
                        ),
                        label: Text(
                          L10n.of(context)!.card_delete_title,
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
        title: Text(L10n.of(context)!.card_delete_title),
        content: Text(L10n.of(context)!.card_delete_description),
        actions: [
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              L10n.of(context)!.card_delete_cancel,
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
            icon: Hicon(HugeIcons.strokeRoundedDelete02, color: Colors.white),
            label: Text(
              L10n.of(context)!.card_delete_confirm,
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
      child: IntrinsicHeight(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: widget.card.color,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: content(context),
        ),
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

  Widget title(BuildContext context) {
    TextStyle? style = widget.height != null && widget.height! <= 70
        ? Theme.of(context).textTheme.headlineSmall
        : Theme.of(context).textTheme.headlineLarge;

    return Text(widget.card.title, style: style?.copyWith(color: textColor));
  }

  Widget barcode(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 16, bottom: 8),
    child: BarcodeWidget(
      barcode: Barcode.fromType(widget.card.type),
      data: widget.card.code,
      color: textColor,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: textColor),
      errorBuilder: (context, _) => barcodeError(context),
      height: widget.height ?? 150,
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
            L10n.of(context)!.card_barcode_invalid,
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
