part of "../ui_settings_page.dart";

Widget themeMode({required BuildContext context}) =>
    BlocBuilder<DarkModeCubit, ThemeMode>(
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            L10n.of(context)!.settings_page_theme_title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(L10n.of(context)!.settings_page_theme_description),
          SizedBox(height: Spaces.small),
          IntrinsicHeight(
            child: Row(
              spacing: Spaces.medium,
              children: [light(context), dark(context), system(context)],
            ),
          ),
          SizedBox(height: Spaces.medium),
        ],
      ),
    );

Widget light(BuildContext context) => Expanded(
  child: Option(
    context: context,
    icon: HugeIcons.strokeRoundedSun02,
    label: L10n.of(context)!.settings_page_theme_mode_light,
    onTap: () => context.read<DarkModeCubit>().set(ThemeMode.light),
    active: context.read<DarkModeCubit>().state == ThemeMode.light,
  ),
);

Widget dark(BuildContext context) => Expanded(
  child: Option(
    context: context,
    icon: HugeIcons.strokeRoundedMoon01,
    label: L10n.of(context)!.settings_page_theme_mode_dark,
    onTap: () => context.read<DarkModeCubit>().set(ThemeMode.dark),
    active: context.read<DarkModeCubit>().state == ThemeMode.dark,
  ),
);

Widget system(BuildContext context) => Expanded(
  child: Option(
    context: context,
    icon: HugeIcons.strokeRoundedSmartPhone02,
    label: L10n.of(context)!.settings_page_theme_mode_system,
    onTap: () => context.read<DarkModeCubit>().set(ThemeMode.system),
    active: context.read<DarkModeCubit>().state == ThemeMode.system,
  ),
);
