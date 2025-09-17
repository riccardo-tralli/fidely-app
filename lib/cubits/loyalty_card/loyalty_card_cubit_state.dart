part of "loyalty_card_cubit.dart";

sealed class LoyaltyCardCubitState extends Equatable {
  const LoyaltyCardCubitState();

  @override
  List<Object> get props => [];
}

final class LoyaltyCardCubitInitialState extends LoyaltyCardCubitState {
  const LoyaltyCardCubitInitialState();
}

final class LoyaltyCardCubitAddSuccessState extends LoyaltyCardCubitState {
  final LoyaltyCard card;

  const LoyaltyCardCubitAddSuccessState(this.card);

  @override
  List<Object> get props => [card];
}

final class LoyaltyCardCubitUpdateSuccessState extends LoyaltyCardCubitState {
  final LoyaltyCard card;

  const LoyaltyCardCubitUpdateSuccessState(this.card);

  @override
  List<Object> get props => [card];
}

final class LoyaltyCardCubitDeleteSuccessState extends LoyaltyCardCubitState {
  final LoyaltyCard card;

  const LoyaltyCardCubitDeleteSuccessState(this.card);

  @override
  List<Object> get props => [card];
}

final class LoyaltyCardCubitErrorState extends LoyaltyCardCubitState {
  final String message;

  const LoyaltyCardCubitErrorState(this.message);

  @override
  List<Object> get props => [message];
}
