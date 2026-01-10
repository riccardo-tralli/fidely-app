import 'package:fidely_app/l10n/l10n.dart';
import 'package:fidely_app/misc/themes/rradius.dart';
import 'package:fidely_app/misc/themes/spaces.dart';
import 'package:fidely_app/widgets/hicon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hugeicons/hugeicons.dart';

class ColorDialog extends StatefulWidget {
  final Color initialColor;
  final Function(Color) onColorChange;

  const ColorDialog({
    super.key,
    required this.initialColor,
    required this.onColorChange,
  });

  @override
  State<ColorDialog> createState() => _ColorDialogState();
}

class _ColorDialogState extends State<ColorDialog> {
  final PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;
  late Color tempColor;

  void onColorPick(Color color) {
    setState(() {
      tempColor = color;
    });
    widget.onColorChange(color);
  }

  void onPageChange(int index) => setState(() {
    currentPage = pageController.page!.round();
  });

  @override
  void initState() {
    super.initState();
    tempColor = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    spacing: Spaces.small,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: pageTitles(context, pageController),
      ),
      SizedBox(
        width: double.maxFinite,
        height: 400,
        child: PageView(
          controller: pageController,
          onPageChanged: onPageChange,
          physics: NeverScrollableScrollPhysics(),
          children: pages,
        ),
      ),
    ],
  );

  List<Widget> pageTitles(
    BuildContext context,
    PageController pageController,
  ) => [
    title(
      context,
      L10n.of(context)!.card_page_color_pick_colors_tab_title,
      HugeIcons.strokeRoundedColors,
      0,
    ),
    title(
      context,
      L10n.of(context)!.card_page_color_pick_list_tab_title,
      HugeIcons.strokeRoundedLeftToRightListBullet,
      1,
    ),
    title(
      context,
      L10n.of(context)!.card_page_color_pick_palette_tab_title,
      HugeIcons.strokeRoundedColorPicker,
      2,
    ),
  ];

  Widget title(
    BuildContext context,
    String title,
    List<List<dynamic>> icon,
    int index,
  ) => TextButton.icon(
    label: Text(title),
    icon: currentPage == index ? Hicon(icon) : null,
    style: currentPage == index
        ? ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              Theme.of(context).colorScheme.primary.withAlpha(25),
            ),
          )
        : null,
    onPressed: () => pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    ),
  );

  List<Widget> get pages => [
    BlockPicker(
      pickerColor: tempColor,
      onColorChanged: (color) => onColorPick(color),
    ),
    MaterialPicker(
      pickerColor: tempColor,
      onColorChanged: (color) => onColorPick(color),
    ),
    ColorPicker(
      pickerColor: tempColor,
      onColorChanged: (color) => onColorPick(color),
      pickerAreaHeightPercent: 0.8,
      enableAlpha: false,
      labelTypes: [],
      pickerAreaBorderRadius: BorderRadius.circular(RRadius.medium),
      displayThumbColor: true,
    ),
  ];
}
