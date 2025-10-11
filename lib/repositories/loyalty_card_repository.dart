import 'package:fidely_app/models/loyalty_card.dart';
import 'package:fidely_app/models/requests/loyalty_card_request.dart';
import 'package:fidely_app/models/sort_mode.dart';
import 'package:fidely_app/services/loyalty_card_service.dart';

class LoyaltyCardRepository {
  final LoyaltyCardService service;

  LoyaltyCardRepository(this.service);

  Future<List<LoyaltyCard>> get(SortMode mode) async {
    try {
      final List<Map<String, dynamic>> data = await service.get(mode);
      return data.map((e) => LoyaltyCard.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<LoyaltyCard> insert(LoyaltyCardInsertRequest request) async {
    try {
      final int id = await service.create(request);
      return LoyaltyCard(
        id: id,
        title: request.title,
        code: request.code,
        type: request.type,
        owner: request.owner,
        color: request.color,
        note: request.note,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<LoyaltyCard> update(LoyaltyCard card) async {
    try {
      await service.update(card);
      return card;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete(LoyaltyCard card) async {
    try {
      await service.delete(card);
    } catch (e) {
      rethrow;
    }
  }
}
