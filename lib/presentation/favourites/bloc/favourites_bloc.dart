import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_app_project/data/coin_list/models/coin_response.dart';
import 'package:crypto_app_project/domain/coin_usecase/usecases/coin_usecase.dart';

import 'package:equatable/equatable.dart';

import 'package:crypto_app_project/data/coin_list/models/favourites.dart';

import 'package:crypto_app_project/domain/favourites_db.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc(this.coinUseCase) : super(FavoriteInitial());
  CoinUseCase coinUseCase;
  List<Coin> listFinal = [];
  FavoriteDatabase databaseCoin = FavoriteDatabase();
  static const _key = '83217b9222f6dcd6b9cd647f9fcac354357d13d4';
  @override
  Stream<FavouritesState> mapEventToState(
    FavouritesEvent event,
  ) async* {
    if (event is LoadFavoriteEvent) {
      listFinal.clear();
      yield FavoriteLoadingState();
      FavoriteDatabase db = FavoriteDatabase();
      await db.openDB();
      List<FavoriteCoin> listFavorite = await db.getCoinByEmail(event.email);
      if (listFavorite.isEmpty) {
        yield FavoriteIsEmptyState();
      } else {
        try {
          yield FavoriteLoadingState();
          final response = await coinUseCase.getTickers(_key);
          List<Coin> listCoin = response;
          for (int i = 0; i < listFavorite.length; i++) {
            for (int j = 0; j < listCoin.length; j++) {
              if (listFavorite.elementAt(i).ids == listCoin.elementAt(j).id) {
                listFinal.add(listCoin.elementAt(j));
                break;
              }
            }
          }
          yield FavoriteLoadingSuccessState(listCoin: listFinal);
        } catch (e) {
          yield FavoriteLoadingFailState();
        }
      }
    } else if (event is DeleteFavoriteEvent) {
      FavoriteDatabase db = FavoriteDatabase();
      await db.openDB();
      await db.deleteFavorite(event.email, event.id);
      yield DeleteFavoriteSuccessState(id: event.id);
    }
  }
}
