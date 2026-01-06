part of "../ui_settings_page.dart";

Widget sortMode({required BuildContext context}) {
  final List<Map<String, dynamic>> modes = [
    {
      "icon": HugeIcons.strokeRoundedArrangeByLettersAZ,
      "label": L10n.of(context)!.settings_page_sort_mode_name,
      "option": SortOption.alphabetical,
    },
    {
      "icon": HugeIcons.strokeRoundedClock01,
      "label": L10n.of(context)!.settings_page_sort_mode_date,
      "option": SortOption.creationDate,
    },
    {
      "icon": HugeIcons.strokeRoundedTag01,
      "label": L10n.of(context)!.settings_page_sort_mode_category,
      "option": SortOption.category,
    },
  ];

  return BlocBuilder<SortCubit, SortMode>(
    builder: (context, state) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          L10n.of(context)!.settings_page_sort_title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(L10n.of(context)!.settings_page_sort_description),
        SizedBox(height: Spaces.small),
        Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(
                context,
              ).inputDecorationTheme.border!.borderSide.color,
            ),
            borderRadius: BorderRadius.circular(RRadius.medium),
          ),
          child: Column(children: sortModes(context, modes, state.option)),
        ),
        reverseSort(context),
      ],
    ),
  );
}

List<Widget> sortModes(
  BuildContext context,
  List<Map<String, dynamic>> modes,
  SortOption selected,
) => List.generate(
  modes.length,
  (index) => Column(
    children: [
      ListTile(
        leading: Hicon(modes[index]["icon"]),
        title: Text(modes[index]["label"]),
        trailing: selected == modes[index]["option"]
            ? Hicon(HugeIcons.strokeRoundedTick01)
            : null,
        selected: selected == modes[index]["option"],
        onTap: () =>
            context.read<SortCubit>().setOption(modes[index]["option"]),
      ),
      if (index < modes.length - 1)
        Divider(
          color: Theme.of(
            context,
          ).inputDecorationTheme.border!.borderSide.color,
          height: 0,
        ),
    ],
  ),
);

Widget reverseSort(BuildContext context) => SwitchListTile(
  contentPadding: EdgeInsets.zero,
  title: Text(L10n.of(context)!.settings_page_sort_reverse_title),
  subtitle: Text(
    L10n.of(context)!.settings_page_sort_reverse_description(
      context.read<SortCubit>().state.reverse
          ? L10n.of(context)!.settings_page_sort_reverse_direction_desc
          : L10n.of(context)!.settings_page_sort_reverse_direction_asc,
    ),
  ),
  value: context.read<SortCubit>().state.reverse,
  onChanged: (_) => context.read<SortCubit>().toggleReverse(),
);
