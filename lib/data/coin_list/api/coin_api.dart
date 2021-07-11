import 'package:crypto_app_project/data/coin_list/models/char_data.dart';
import 'package:crypto_app_project/data/coin_list/models/coin_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'coin_api.g.dart';

@RestApi(baseUrl: "https://api.nomics.com/v1")
abstract class CoinAPI {
  factory CoinAPI(Dio dio) = _CoinAPI;

  @GET("/currencies/ticker")
  Future<List<Coin>> getTicker(
      @Query("key") String key,
      @Query("page") int page,
      @Query("per-page") int perPage,
      @Query("interval") String intervarl);
  @GET("/currencies/ticker")
  Future<List<Coin>> getCoin(@Query("key") String key, @Query("ids") String ids,
      @Query("interval") String intervarl);
  @GET("/currencies/sparkline")
  Future<List<Chart>> getChart(@Query("key") String key, @Query("ids") String ids,
      @Query("start") String start);
}
