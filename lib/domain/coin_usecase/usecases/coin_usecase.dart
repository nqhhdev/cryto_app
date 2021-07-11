import 'package:crypto_app_project/data/coin_list/models/char_data.dart';
import 'package:crypto_app_project/data/coin_list/models/coin_response.dart';
import 'package:crypto_app_project/domain/coin_usecase/repositories/coin_repository.dart';

class CoinUseCase {
  final CoinRepository repository;
  CoinUseCase({
    required this.repository,
  });

  Future<List<Coin>> getTickers(String key) => repository.getTicker(key);
  Future<List<Coin>> getCoin(String key, String id) =>
      repository.getCoin(key, id);
  Future<List<Chart>> getChart(String key, String id) =>
      repository.getChart(key, id);
}
