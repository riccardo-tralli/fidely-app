part of "../home_page.dart";

Widget list({
  required BuildContext context,
  required LoyaltyCardLoadedState state,
}) => ListView.builder(
  itemCount: state.cards.length + 1,
  itemBuilder: (context, index) => index == 0
      ? SizedBox(height: Spaces.small)
      : LoyaltyCardWidget(card: state.cards[index - 1]),
);
