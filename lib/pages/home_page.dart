import 'package:fidely_app/blocs/loyalty_card/loyalty_card_bloc.dart';
import 'package:fidely_app/l10n/l10n.dart';
import 'package:fidely_app/misc/themes/spaces.dart';
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
      actions: [
        settingsButton(context),
        searchButton(context),
        addButton(context),
      ],
    ),
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: cardList(context),
    ),
  );

  Widget settingsButton(BuildContext context) => IconButton(
    icon: Hicon(HugeIcons.strokeRoundedSettings05),
    onPressed: () => Navigator.pushNamed(context, SettingsPage.route),
  );

  Widget searchButton(BuildContext context) => IconButton(
    icon: Hicon(HugeIcons.strokeRoundedSearchArea),
    onPressed: () => (),
  );

  Widget addButton(BuildContext context) => IconButton(
    icon: Hicon(
      HugeIcons.strokeRoundedAddSquare,
      color: Theme.of(context).scaffoldBackgroundColor,
      backgroundColor: Theme.of(context).colorScheme.primary,
    ),
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
                  ? SizedBox(height: Spaces.small)
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

  Widget error(BuildContext context, String message) => SizedBox(
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: Spaces.medium,
      children: [
        Image.asset("assets/images/error.png", width: 300),
        Text(
          L10n.of(context)!.home_page_generic_error_title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Text(message),
      ],
    ),
  );
}
