import 'dart:async';
import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:crypto_app_project/data/coin_list/models/char_data.dart';
import 'package:crypto_app_project/data/coin_list/models/coin_response.dart';
import 'package:crypto_app_project/data/coin_list/models/favourites.dart';

import 'package:crypto_app_project/domain/coin_usecase/usecases/coin_usecase.dart';
import 'package:crypto_app_project/domain/favourites_db.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'detail_favourites_event.dart';
part 'detail_favourites_state.dart';

class DetailFavouritesBloc
    extends Bloc<DetailFavouritesEvent, DetailFavouritesState> {
  DetailFavouritesBloc(this.coinUseCase) : super(DetailFavouritesInitial());
  CoinUseCase coinUseCase;
  List<Coin>? listcoinS;
  // List<Chart>? listChart;
  var favorite = [];
  static const _key = '83217b9222f6dcd6b9cd647f9fcac354357d13d4';
  @override
  Stream<DetailFavouritesState> mapEventToState(
    DetailFavouritesEvent event,
  ) async* {
    if (event is LoadDetailFavouritesEvent) {
      yield LoadingDetailFavouritesState();
      try {
        print('call api');
        final response = await coinUseCase.getCoin(_key, event.id);
        listcoinS = response;
        print(response);
        // final responseChart = await coinUseCase.getChart(_key, event.id);
        // listChart = responseChart;
        // print(responseChart);
        yield LoadDetailFavouritesSuccessStatee(listcoin: listcoinS);
      } catch (e) {
        yield LoadDetailFavouritesFailState();
      }
    } else if (event is AddFavoriteEvent) {
      FavoriteDatabase db = FavoriteDatabase();
      await db.openDB();
      var coin = FavoriteCoin(
        ids: event.id,
        email: FirebaseAuth.instance.currentUser!.email.toString(),
      );
      print(coin.ids);
      bool isExist = await db.checkExist(event.email, event.id);
      if (isExist) {
        print(isExist);
        yield AddFavoriteFailState();
      } else {
        yield AddingFavoriteState();
        await db.insertFavorite(coin);
        yield AddFavoriteSuccessState(id: event.id);
      }
    }
    yield LoadDetailFavouritesSuccessStatee(listcoin: listcoinS);
  }
}
