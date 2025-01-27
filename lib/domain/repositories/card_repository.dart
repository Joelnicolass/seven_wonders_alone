import 'package:seven_wonders_alone/domain/entities/card.dart';

abstract class CardRepository {
  Future<List<GenericCard>> getLeaderCards();
  Future<List<GenericCard>> getActionCards();
  Future<List<GenericCard>> getActionBuildWonderCards();
  Future<List<GenericCard>> getActionSellCards();
}
