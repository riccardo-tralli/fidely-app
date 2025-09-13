import 'package:fidely_app/blocs/loyalty_card/loyalty_card_bloc.dart';
import 'package:fidely_app/widgets/loyalty_card_widget.dart';
import 'package:fidely_app/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  static const route = "/home";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: TopBar(),
    body: Padding(padding: const EdgeInsets.all(8), child: cardList(context)),
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
              return Center(child: Text("No loyalty cards found."));
            }

            return ListView.builder(
              itemCount: state.cards.length,
              itemBuilder: (context, index) =>
                  LoyaltyCardWidget(card: state.cards[index]),
            );
          }

          return Center(
            child: Text("Error: ${(state as LoyaltyCardErrorState).message}"),
          );
        },
      );
}
