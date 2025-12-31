part of "../settings_page.dart";

Widget language({required BuildContext context}) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      L10n.of(context)!.settings_page_language_title,
      style: Theme.of(context).textTheme.headlineSmall,
    ),
    Text(L10n.of(context)!.settings_page_language_description),
    SizedBox(height: Spaces.small),
    DropdownButtonFormField(
      initialValue: context.read<LanguageCubit>().state,
      items: languages(context),
      onChanged: (value) => context.read<LanguageCubit>().set(value),
      style: Theme.of(context).textTheme.bodyLarge,
    ),
  ],
);

List<DropdownMenuItem<String?>> languages(BuildContext context) => [
  DropdownMenuItem(
    value: null,
    child: Text(L10n.of(context)!.settings_page_language_option_system),
  ),
  DropdownMenuItem(
    value: "en",
    child: Text(L10n.of(context)!.settings_page_language_option_english),
  ),
  DropdownMenuItem(
    value: "fr",
    child: Text(L10n.of(context)!.settings_page_language_option_french),
  ),
  DropdownMenuItem(
    value: "es",
    child: Text(L10n.of(context)!.settings_page_language_option_spanish),
  ),
  DropdownMenuItem(
    value: "it",
    child: Text(L10n.of(context)!.settings_page_language_option_italian),
  ),
];
