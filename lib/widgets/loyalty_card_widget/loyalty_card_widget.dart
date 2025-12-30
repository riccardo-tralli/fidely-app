// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:fidely_app/cubits/loyalty_card/loyalty_card_cubit.dart';
import 'package:fidely_app/cubits/settings/view_mode_cubit.dart';
import 'package:fidely_app/l10n/l10n.dart';
import 'package:fidely_app/misc/themes/rradius.dart';
import 'package:fidely_app/misc/themes/spaces.dart';
import 'package:fidely_app/models/category.dart';
import 'package:fidely_app/models/loyalty_card.dart';
import 'package:fidely_app/pages/card_page/card_page.dart';
import 'package:fidely_app/services/photo_service.dart';
import 'package:fidely_app/widgets/hicon.dart';
import 'package:fidely_app/widgets/photo_container.dart';
import 'package:fidely_app/widgets/round_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

part "parts/tap.dart";

class LoyaltyCardWidget extends StatefulWidget {
  final LoyaltyCard card;
  final bool showBarcode;
  final bool showOwner;
  final bool isSelectable;
  final double? height;

  const LoyaltyCardWidget({
    super.key,
    required this.card,
    this.showBarcode = true,
    this.showOwner = true,
    this.isSelectable = true,
    this.height,
  });

  @override
  State<LoyaltyCardWidget> createState() => _LoyaltyCardWidgetState();
}

class _LoyaltyCardWidgetState extends State<LoyaltyCardWidget> {
  Color textColor = Colors.white;
  File? frontPhoto;
  File? rearPhoto;

  void onLongPress(BuildContext context) async {
    if (widget.isSelectable) {
      showModalBottomSheet(
        context: context,
        builder: (context) => SafeArea(
          child: Container(
            padding: EdgeInsets.all(Spaces.large),
            decoration: BoxDecoration(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: Spaces.medium,
              children: [
                Text(
                  widget.card.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Row(
                  spacing: Spaces.medium,
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () => onEdit(context),
                        icon: Hicon(HugeIcons.strokeRoundedEdit04),
                        label: Text(L10n.of(context)!.card_edit_title),
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
                          ).textTheme.bodyMedium?.copyWith(color: Colors.white),
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
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actionsOverflowAlignment: OverflowBarAlignment.end,
        actionsOverflowButtonSpacing: Spaces.medium,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(L10n.of(context)!.card_delete_cancel),
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
              ).textTheme.bodyMedium?.copyWith(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );

  Future<void> loadPhotos() async {
    frontPhoto = await PhotoService.instance.get(
      widget.card.id,
      PhotoType.front,
    );
    rearPhoto = await PhotoService.instance.get(widget.card.id, PhotoType.rear);
    if (frontPhoto != null || rearPhoto != null) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    loadPhotos();
  }

  @override
  Widget build(BuildContext context) {
    textColor = widget.card.color.computeLuminance() > 0.4
        ? Colors.black
        : Colors.white;

    final double width = MediaQuery.of(context).size.width;
    final double height = widget.height ?? width / 3 * 2;

    return InkWell(
      onTap: () => onTap(
        context: context,
        widget: widget,
        frontPhoto: frontPhoto,
        rearPhoto: rearPhoto,
      ),
      onLongPress: () => onLongPress(context),
      borderRadius: BorderRadius.circular(RRadius.medium),
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.all(Spaces.small),
        decoration: BoxDecoration(
          color: widget.card.color,
          borderRadius: BorderRadius.circular(RRadius.medium),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child:
            context.read<ViewModeCubit>().state.usePhoto == true &&
                frontPhoto != null
            ? photoContent(context)
            : textContent(context, height),
      ),
    );
  }

  Widget photoContent(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(RRadius.medium),
    child: Image.file(frontPhoto!, fit: BoxFit.cover),
  );

  Widget textContent(BuildContext context, double height) => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: Spaces.large,
      vertical: Spaces.medium,
    ),
    child: OverflowBox(
      alignment: AlignmentGeometry.center,
      maxHeight: double.infinity,
      child: Column(
        mainAxisAlignment: !widget.showBarcode && !widget.showOwner
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: !widget.showBarcode && !widget.showOwner
                  ? WrapAlignment.center
                  : WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: Spaces.small,
              runSpacing: Spaces.small,
              children: [
                title(context),
                if (widget.showOwner &&
                    widget.card.owner != null &&
                    widget.card.owner!.isNotEmpty)
                  owner(context),
              ],
            ),
          ),
          if (widget.showBarcode) barcode(context, height),
        ],
      ),
    ),
  );

  Widget title(BuildContext context) {
    TextStyle? style;
    if (!widget.showBarcode && !widget.showOwner) {
      style = Theme.of(context).textTheme.headlineSmall;
    } else {
      style = widget.height != null && widget.height! <= 70
          ? Theme.of(context).textTheme.headlineSmall
          : Theme.of(context).textTheme.headlineLarge;
    }

    return Expanded(
      child: Text(
        widget.card.title,
        style: style?.copyWith(color: textColor),
        textAlign: !widget.showBarcode && !widget.showOwner
            ? TextAlign.center
            : TextAlign.start,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget barcode(BuildContext context, double height) => Padding(
    padding: EdgeInsets.only(top: Spaces.medium, bottom: Spaces.small),
    child: BarcodeWidget(
      barcode: Barcode.fromType(widget.card.type),
      data: widget.card.code,
      color: textColor,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: textColor),
      errorBuilder: (context, _) => barcodeError(context),
      height: height / 5 * 3,
    ),
  );

  Widget barcodeError(BuildContext context) => Container(
    padding: EdgeInsets.all(Spaces.medium),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.error.withAlpha(15),
      borderRadius: BorderRadius.circular(RRadius.small),
    ),
    child: Row(
      spacing: Spaces.medium,
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
    padding: EdgeInsets.all(Spaces.small),
    decoration: BoxDecoration(
      color: textColor.withAlpha(50),
      borderRadius: BorderRadius.circular(RRadius.small),
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
