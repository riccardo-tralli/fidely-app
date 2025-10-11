import 'package:fidely_app/blocs/loyalty_card/loyalty_card_bloc.dart';
import 'package:fidely_app/pages/card_page.dart';
import 'package:fidely_app/pages/settings_page.dart';
import 'package:fidely_app/widgets/hicon.dart';
import 'package:fidely_app/widgets/loyalty_card_widget.dart';
import 'package:fidely_app/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

class HomePage extends StatelessWidget {
  static const route = "/home";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: TopBar(
      roundedBorders: true,
      leading: settingsButton(context),
      trailing: [addButton(context)],
    ),
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: cardList(context),
    ),
  );

  Widget settingsButton(BuildContext context) => IconButton(
    icon: Hicon(HugeIcons.strokeRoundedSettings01),
    onPressed: () => Navigator.pushNamed(context, SettingsPage.route),
  );

  Widget addButton(BuildContext context) => IconButton(
    icon: Hicon(HugeIcons.strokeRoundedAddSquare),
    onPressed: () => Navigator.pushNamed(context, CardPage.route),
  );

  Widget cardList(BuildContext context) =>
      BlocBuilder<LoyaltyCardBloc, LoyaltyCardState>(
        builder: (context, state) {
          if (state is LoyaltyCardLoadingState ||
              state is LoyaltyCardInitialState) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is LoyaltyCardLoadedState) {
            if (state.cards.isEmpty) {
              return emptyList(context);
            }

            return ListView.builder(
              itemCount: state.cards.length + 1,
              itemBuilder: (context, index) => index == 0
                  ? SizedBox(height: 8)
                  : LoyaltyCardWidget(card: state.cards[index - 1]),
            );
          }

          return error(context, (state as LoyaltyCardErrorState).message);
        },
      );

  Widget emptyList(BuildContext context) => SizedBox(
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 16,
      children: [
        Image.asset("assets/images/empty.png", width: 250),
        Text(
          "No loyalty cards found",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        FilledButton.icon(
          onPressed: () => Navigator.of(context).pushNamed(CardPage.route),
          icon: Hicon(HugeIcons.strokeRoundedAddSquare),
          label: Text(
            "Add the first one",
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.white),
          ),
        ),
      ],
    ),
  );

  Widget error(BuildContext context, String message) => SizedBox(
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 16,
      children: [
        Image.asset("assets/images/error.png", width: 250),
        Text(
          "Something went wrong",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(message),
      ],
    ),
  );
}
