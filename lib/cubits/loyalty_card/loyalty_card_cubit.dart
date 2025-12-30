import 'package:equatable/equatable.dart';
import 'package:fidely_app/blocs/loyalty_card/loyalty_card_bloc.dart';
import 'package:fidely_app/models/loyalty_card.dart';
import 'package:fidely_app/models/requests/loyalty_card_request.dart';
import 'package:fidely_app/repositories/loyalty_card_repository.dart';
import 'package:fidely_app/services/photo_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "loyalty_card_cubit_state.dart";

class LoyaltyCardCubit extends Cubit<LoyaltyCardCubitState> {
  final LoyaltyCardRepository repository;
  final LoyaltyCardBloc bloc;
  final PhotoService photoService;

  LoyaltyCardCubit({
    required this.repository,
    required this.bloc,
    required this.photoService,
  }) : super(LoyaltyCardCubitInitialState());

  void addLoyaltyCard(LoyaltyCardInsertRequest request) async {
    try {
      final LoyaltyCard data = await repository.insert(request);
      bloc.addLoyaltyCard(data);
      emit(LoyaltyCardCubitAddSuccessState(data));
    } catch (e) {
      emit(LoyaltyCardCubitErrorState(e.toString()));
    }
  }

  void updateLoyaltyCard(LoyaltyCard card) async {
    try {
      final LoyaltyCard data = await repository.update(card);
      bloc.updateLoyaltyCard(data);
      emit(LoyaltyCardCubitUpdateSuccessState(data));
    } catch (e) {
      emit(LoyaltyCardCubitErrorState(e.toString()));
    }
  }

  void deleteLoyaltyCard(LoyaltyCard card) async {
    try {
      await repository.delete(card);
      await photoService.delete(card.id, PhotoType.front);
      await photoService.delete(card.id, PhotoType.rear);
      bloc.deleteLoyaltyCard(card);
      emit(LoyaltyCardCubitDeleteSuccessState(card));
    } catch (e) {
      emit(LoyaltyCardCubitErrorState(e.toString()));
    }
  }
}
