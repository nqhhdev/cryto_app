import 'package:crypto_app_project/data/coin_list/api/coin_api.dart';
import 'package:crypto_app_project/data/coin_list/models/char_data.dart';
import 'package:crypto_app_project/data/coin_list/models/coin_response.dart';
import 'package:crypto_app_project/domain/coin_usecase/repositories/coin_repository.dart';

class CoinRepositoryImpl extends CoinRepository {
  CoinAPI coinAPI;
  CoinRepositoryImpl({
    required this.coinAPI,
  });

  @override
  Future<List<Coin>> getTicker(String key) async {
    final response = await coinAPI.getTicker(key, 1, 50, "1h,1d,7d");
    print(response.first.toJson().toString());
    return response;
  }

  @override
  Future<List<Coin>> getCoin(String key, String id) async {
    final response = await coinAPI.getCoin(key, id, "1h,1d,7d");
    return response;
  }

  Future<List<Chart>> getChart(String key, String id) async {
    final response =
        await coinAPI.getChart(key, id, "2021-06-01T00%3A00%3A00Z");
    return response;
  }
}
