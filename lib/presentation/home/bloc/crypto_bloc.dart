import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_app_project/data/coin_list/models/coin_response.dart';
import 'package:crypto_app_project/domain/coin_usecase/usecases/coin_usecase.dart';

import 'package:equatable/equatable.dart';

part 'crypto_event.dart';
part 'crypto_state.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  CryptoBloc(this.coinUseCase) : super(SearchInitial());
  CoinUseCase coinUseCase;

  static const _key = '83217b9222f6dcd6b9cd647f9fcac354357d13d4';
  List<Coin> listRetrofit = [];
  @override
  Stream<CryptoState> mapEventToState(
    CryptoEvent event,
  ) async* {
    if (event is LoadSearchEvent) {
      yield SearchLoadingState();
      print('Call API');

      try {
        final response = await coinUseCase.getTickers(_key);
        listRetrofit = response;
        yield SearchSuccessState(listcurrency: listRetrofit);
      } catch (e) {
        yield SearchFailState();
      }
    } else if (event is OnSearchEvent) {
      print('Search');
      List<Coin> listS = [];
      String query = event.query.toString();
      listS = listRetrofit
          .where((element) =>
              element.id!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      yield SearchResult(listcurrency: listS);
      if (listS.isNotEmpty) {
        yield SearchSuccessState(listcurrency: listS);
        print('done');
      } else if (listS.isEmpty) {
        print('Null');
        yield SearchFailureState();
      }
    }
    if (event is SortRankEvent) {
      print('boolean : ${event.isAscending}');
      print('befor sort : ${event.listcurrency.first.rank}');
      if (event.isAscending == true) {
        event.listcurrency.sort((productA, productB) =>
            int.parse(productB.rank!).compareTo(int.parse(productA.rank!)));
      } else {
        event.listcurrency.sort((productA, productB) =>
            int.parse(productA.rank!).compareTo(int.parse(productB.rank!)));
        yield SearchSuccessState(listcurrency: event.listcurrency);
      }

      print('after sort : ${event.listcurrency.first.rank}');
    } else if (event is SortNameEvent) {
      print('hhh');
      print('boolean : ${event.isAscending}');
      print('befor sort : ${event.listcurrency.first.name}');
      if (event.isAscending == true) {
        event.listcurrency.sort(
            (productA, productB) => productB.name!.compareTo(productA.name!));
      } else {
        event.listcurrency.sort(
            (productA, productB) => productA.name!.compareTo(productB.name!));
      }
      print('hhh');
      print('after sort : ${event.listcurrency.first.name}');
      yield SearchSuccessState(listcurrency: event.listcurrency);
    } else if (event is SortPriceEvent) {
      print('boolean : ${event.isAscending}');
      print('befor sort : ${event.listcurrency.first.price}');
      if (event.isAscending == true) {
        event.listcurrency.sort((productA, productB) =>
            double.parse(productB.price!)
                .compareTo(double.parse(productA.price!)));
      } else {
        event.listcurrency.sort((productA, productB) =>
            double.parse(productA.price!)
                .compareTo(double.parse(productB.price!)));
      }
      print('hi');
      print('after sort : ${event.listcurrency.first.price}');
      yield SearchSuccessState(listcurrency: event.listcurrency);
    }
  }
}
