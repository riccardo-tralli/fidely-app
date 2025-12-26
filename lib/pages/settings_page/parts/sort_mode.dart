part of "../settings_page.dart";

Widget sortMode({required BuildContext context}) =>
    BlocBuilder<SortCubit, SortMode>(
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            L10n.of(context)!.settings_page_sort_title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(L10n.of(context)!.settings_page_sort_description),
          SizedBox(height: Spaces.small),
          IntrinsicHeight(
            child: Row(
              spacing: Spaces.medium,
              children: [
                nameSort(context),
                dateSort(context),
                categorySort(context),
              ],
            ),
          ),
          reverseSort(context),
        ],
      ),
    );

Widget dateSort(BuildContext context) => Expanded(
  child: Option(
    context: context,
    icon: HugeIcons.strokeRoundedClock01,
    label: L10n.of(context)!.settings_page_sort_mode_date,
    onTap: () => context.read<SortCubit>().setOption(SortOption.creationDate),
    active: context.read<SortCubit>().state.option == SortOption.creationDate,
  ),
);

Widget nameSort(BuildContext context) => Expanded(
  child: Option(
    context: context,
    icon: context.read<SortCubit>().state.reverse
        ? HugeIcons.strokeRoundedArrangeByLettersZA
        : HugeIcons.strokeRoundedArrangeByLettersAZ,
    label: L10n.of(context)!.settings_page_sort_mode_name,
    onTap: () => context.read<SortCubit>().setOption(SortOption.alphabetical),
    active: context.read<SortCubit>().state.option == SortOption.alphabetical,
  ),
);

Widget categorySort(BuildContext context) => Expanded(
  child: Option(
    context: context,
    icon: HugeIcons.strokeRoundedTag01,
    label: L10n.of(context)!.settings_page_sort_mode_category,
    onTap: () => context.read<SortCubit>().setOption(SortOption.category),
    active: context.read<SortCubit>().state.option == SortOption.category,
  ),
);

Widget reverseSort(BuildContext context) => SwitchListTile(
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
