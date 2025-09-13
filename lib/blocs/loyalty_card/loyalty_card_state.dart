part of "loyalty_card_bloc.dart";

sealed class LoyaltyCardState extends Equatable {
  const LoyaltyCardState();

  @override
  List<Object> get props => [];
}

final class LoyaltyCardInitialState extends LoyaltyCardState {
  const LoyaltyCardInitialState();
}

final class LoyaltyCardLoadingState extends LoyaltyCardState {
  const LoyaltyCardLoadingState();
}

final class LoyaltyCardLoadedState extends LoyaltyCardState {
  final List<LoyaltyCard> cards;

  const LoyaltyCardLoadedState(this.cards);

  @override
  List<Object> get props => [cards];
}

final class LoyaltyCardErrorState extends LoyaltyCardState {
  final String message;

  const LoyaltyCardErrorState(this.message);

  @override
  List<Object> get props => [message];
}
