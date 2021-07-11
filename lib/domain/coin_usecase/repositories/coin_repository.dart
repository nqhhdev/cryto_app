import 'package:crypto_app_project/data/coin_list/models/char_data.dart';
import 'package:crypto_app_project/data/coin_list/models/coin_response.dart';

abstract class CoinRepository {
  Future<List<Coin>> getTicker(String key);
  Future<List<Coin>> getCoin(String key, String id);
  Future<List<Chart>> getChart(String key, String id);
}
