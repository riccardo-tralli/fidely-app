import 'package:equatable/equatable.dart';
import 'package:fidely_app/models/loyalty_card.dart';
import 'package:fidely_app/repositories/loyalty_card_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "loyalty_card_event.dart";
part "loyalty_card_state.dart";

class LoyaltyCardBloc extends Bloc<LoyaltyCardEvent, LoyaltyCardState> {
  final LoyaltyCardRepository repository;

  LoyaltyCardBloc({required this.repository})
    : super(LoyaltyCardInitialState()) {
    on<LoadLoyaltyCardsEvent>(_onLoadLoyaltyCards);
    on<AddLoyaltyCardEvent>(_onAddLoyaltyCard);
    on<UpdateLoyaltyCardEvent>(_onUpdateLoyaltyCard);
    on<DeleteLoyaltyCardEvent>(_onDeleteLoyaltyCard);
  }

  Future<void> _onLoadLoyaltyCards(
    LoadLoyaltyCardsEvent event,
    Emitter<LoyaltyCardState> emit,
  ) async {
    emit(LoyaltyCardLoadingState());
    try {
      final List<LoyaltyCard> cards = await repository.get();
      emit(LoyaltyCardLoadedState(cards));
    } catch (e) {
      emit(LoyaltyCardErrorState(e.toString()));
    }
  }

  Future<void> _onAddLoyaltyCard(
    AddLoyaltyCardEvent event,
    Emitter<LoyaltyCardState> emit,
  ) async {
    final LoyaltyCardLoadedState currentState = state as LoyaltyCardLoadedState;
    emit(LoyaltyCardLoadingState());
    try {
      final List<LoyaltyCard> data = currentState.cards..add(event.card);
      emit(LoyaltyCardLoadedState(data));
    } catch (e) {
      emit(LoyaltyCardErrorState(e.toString()));
    }
  }

  Future<void> _onUpdateLoyaltyCard(
    UpdateLoyaltyCardEvent event,
    Emitter<LoyaltyCardState> emit,
  ) async {
    final LoyaltyCardLoadedState currentState = state as LoyaltyCardLoadedState;
    emit(LoyaltyCardLoadingState());
    try {
      final LoyaltyCard updatedCard = await repository.update(event.card);
      final List<LoyaltyCard> data = currentState.cards
          .map((e) => e.id == updatedCard.id ? updatedCard : e)
          .toList();
      emit(LoyaltyCardLoadedState(data));
    } catch (e) {
      emit(LoyaltyCardErrorState(e.toString()));
    }
  }

  Future<void> _onDeleteLoyaltyCard(
    DeleteLoyaltyCardEvent event,
    Emitter<LoyaltyCardState> emit,
  ) async {
    final LoyaltyCardLoadedState currentState = state as LoyaltyCardLoadedState;
    emit(LoyaltyCardLoadingState());
    try {
      await repository.delete(event.card);
      final List<LoyaltyCard> data = currentState.cards
        ..removeWhere((e) => e.id == event.card.id);
      emit(LoyaltyCardLoadedState(data));
    } catch (e) {
      emit(LoyaltyCardErrorState(e.toString()));
    }
  }

  void loadLoyaltyCards() => add(LoadLoyaltyCardsEvent());

  void addLoyaltyCard(LoyaltyCard card) => add(AddLoyaltyCardEvent(card));

  void updateLoyaltyCard(LoyaltyCard card) => add(UpdateLoyaltyCardEvent(card));

  void deleteLoyaltyCard(LoyaltyCard card) => add(DeleteLoyaltyCardEvent(card));
}
