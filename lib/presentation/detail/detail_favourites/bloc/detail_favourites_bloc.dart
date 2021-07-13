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
  List<Chart>? listChart;
  double maxY = 0;
  // double minY = 0;
  var favorite = [];
  static const _key = '83217b9222f6dcd6b9cd647f9fcac354357d13d4';
  double up(double n) {
    double x;
    double upN;
    if (n / 10000 > 1) {
      x = 200;
      upN = n + (x - n % x);
      return upN;
    } else if (n / 1000 > 1) {
      x = 20;
      upN = n + (x - n % x);
      return upN;
    } else if (n / 100 > 1) {
      x = 2;
      upN = n + (x - n % x);
      return upN;
    } else if (n / 10 > 1) {
      x = 0.2;
      upN = n + (x - n % x);
      return upN;
    } else if (n / 10 < 0.01) {
      x = 0.1;
      upN = n + (x - n % x);
      return upN;
    } else if (n / 10 < 0.1) {
      x = 0.2;
      upN = n + (x - n % x);
      return upN;
    } else if (n / 10 < 1) {
      x = 0.02;
      upN = n + (x - n % x);
      return upN;
    }
    return upN = 0;
  }

  double down(double n) {
    double x;
    double downN;
    if (n / 10000 > 1) {
      x = 200;
      downN = n - (x - n % x);
      return downN;
    } else if (n / 1000 > 1) {
      x = 20;
      downN = n - (x - n % x);
      return downN;
    } else if (n / 100 > 1) {
      x = 2;
      downN = n - (x - n % x);
      return downN;
    } else if (n / 10 > 1) {
      x = 0.2;
      downN = n - (x - n % x);
      return downN;
    } else if (n / 10 < 0.01) {
      x = 0.1;
      downN = n - (x - n % x);
      return downN;
    } else if (n / 10 < 0.1) {
      x = 0.2;
      downN = n - (x - n % x);
      return downN;
    } else if (n / 10 < 1) {
      x = 0.02;
      downN = n - (x - n % x);
      return downN;
    }
    return downN = 0;
  }

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
        final responseChart = await coinUseCase.getChart(_key, event.id);
        listChart = responseChart;
        print(responseChart);
        responseChart.forEach(
          (element) {
            element.prices.forEach((prices) {
              print("time stamp : $prices");
            });
          },
        );
        responseChart.elementAt(0).prices.forEach((element) {
          if (double.parse(element) > maxY) {
            maxY = double.parse(element);
          }
        });
        maxY = up(maxY);
        print(maxY);
        double minY = double.parse(
            responseChart.elementAt(0).prices.elementAt(0).toString());
        responseChart.elementAt(0).prices.forEach((element) {
          if (double.parse(element) < minY) {
            minY = double.parse(element);
          }
        });
        minY = down(minY);
        print(minY);
        yield LoadDetailFavouritesSuccessStatee(
            listcoin: listcoinS, listChart: listChart, maxY: maxY, minY: minY);
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
