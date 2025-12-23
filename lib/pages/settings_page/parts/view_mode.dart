part of "../settings_page.dart";

Widget viewMode({required BuildContext context}) =>
    BlocBuilder<ViewModeCubit, ViewMode>(
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            L10n.of(context)!.settings_page_view_mode_title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(L10n.of(context)!.settings_page_view_mode_description),
          SizedBox(height: Spaces.small),
          Row(
            spacing: Spaces.medium,
            children: [listView(context), gridView(context)],
          ),
          usePhoto(context),
        ],
      ),
    );

Widget listView(BuildContext context) => Expanded(
  child: Option(
    context: context,
    icon: HugeIcons.strokeRoundedListView,
    label: L10n.of(context)!.settings_page_view_mode_grid,
    onTap: () => context.read<ViewModeCubit>().setColumns(1),
    active: context.read<ViewModeCubit>().state.columns == 1,
  ),
);

Widget gridView(BuildContext context) => Expanded(
  child: Option(
    context: context,
    icon: HugeIcons.strokeRoundedGridView,
    label: L10n.of(context)!.settings_page_view_mode_list,
    onTap: () => context.read<ViewModeCubit>().setColumns(2),
    active: context.read<ViewModeCubit>().state.columns == 2,
  ),
);

Widget usePhoto(BuildContext context) => SwitchListTile(
  title: Text(L10n.of(context)!.settings_page_view_mode_use_photo_title),
  subtitle: Text(
    L10n.of(context)!.settings_page_view_mode_use_photo_description,
  ),
  value: context.read<ViewModeCubit>().state.usePhoto ?? false,
  onChanged: (value) => context.read<ViewModeCubit>().setUsePhoto(value),
);
