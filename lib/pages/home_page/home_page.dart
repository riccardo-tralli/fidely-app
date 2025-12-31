import 'package:fidely_app/blocs/loyalty_card/loyalty_card_bloc.dart';
import 'package:fidely_app/cubits/settings/sort_cubit.dart';
import 'package:fidely_app/cubits/settings/view_mode_cubit.dart';
import 'package:fidely_app/l10n/l10n.dart';
import 'package:fidely_app/misc/themes/spaces.dart';
import 'package:fidely_app/models/category.dart';
import 'package:fidely_app/models/loyalty_card.dart';
import 'package:fidely_app/models/settings/sort_mode.dart';
import 'package:fidely_app/models/settings/view_mode.dart';
import 'package:fidely_app/pages/card_page/card_page.dart';
import 'package:fidely_app/pages/settings_page/settings_page.dart';
import 'package:fidely_app/widgets/hicon.dart';
import 'package:fidely_app/widgets/loyalty_card_widget/loyalty_card_widget.dart';
import 'package:fidely_app/widgets/round_chip.dart';
import 'package:fidely_app/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

part "parts/list.dart";
part "parts/empty_list.dart";
part "parts/error.dart";

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
    body: cardList(context),
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
              return emptyList(context: context);
            }

            return list(context: context, state: state);
          }

          return error(
            context: context,
            message: (state as LoyaltyCardErrorState).message,
          );
        },
      );
}
