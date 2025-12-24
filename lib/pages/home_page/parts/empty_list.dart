part of "../home_page.dart";

Widget emptyList({required BuildContext context}) => SizedBox(
  width: double.infinity,
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    spacing: Spaces.extraSmall,
    children: [
      Image.asset("assets/images/empty.png", width: 300),
      SizedBox(height: Spaces.medium),
      Text(
        L10n.of(context)!.home_page_no_cards_title,
        style: Theme.of(context).textTheme.headlineLarge,
        textAlign: TextAlign.center,
      ),
      Text(
        L10n.of(context)!.home_page_no_cards_description,
        style: Theme.of(context).textTheme.bodyMedium,
        textAlign: TextAlign.center,
      ),
      SizedBox(height: Spaces.medium),
      FilledButton.icon(
        onPressed: () => Navigator.of(context).pushNamed(CardPage.route),
        icon: Hicon(HugeIcons.strokeRoundedAddSquare),
        label: Text(L10n.of(context)!.home_page_no_cards_add_button),
      ),
    ],
  ),
);
