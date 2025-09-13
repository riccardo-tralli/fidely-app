part of "loyalty_card_bloc.dart";

sealed class LoyaltyCardEvent extends Equatable {
  const LoyaltyCardEvent();

  @override
  List<Object> get props => [];
}

final class LoadLoyaltyCardsEvent extends LoyaltyCardEvent {
  const LoadLoyaltyCardsEvent();
}

final class AddLoyaltyCardEvent extends LoyaltyCardEvent {
  final LoyaltyCard card;

  const AddLoyaltyCardEvent(this.card);

  @override
  List<Object> get props => [card];
}

final class UpdateLoyaltyCardEvent extends LoyaltyCardEvent {
  final LoyaltyCard card;

  const UpdateLoyaltyCardEvent(this.card);

  @override
  List<Object> get props => [card];
}

final class DeleteLoyaltyCardEvent extends LoyaltyCardEvent {
  final LoyaltyCard card;

  const DeleteLoyaltyCardEvent(this.card);

  @override
  List<Object> get props => [card];
}
