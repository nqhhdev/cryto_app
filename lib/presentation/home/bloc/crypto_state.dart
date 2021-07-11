part of 'crypto_bloc.dart';

abstract class CryptoState extends Equatable {
  const CryptoState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends CryptoState {}

// ignore: must_be_immutable
class SearchSuccessState extends CryptoState {
  List<Coin> listcurrency;
  SearchSuccessState({required this.listcurrency});
}

class SearchLoadingState extends CryptoState {}

class SearchFailState extends CryptoState {}

// ignore: must_be_immutable
class SearchResult extends CryptoState {
  List<Coin> listcurrency;
  SearchResult({
    required this.listcurrency,
  });
}

class SearchFailureState extends CryptoState {}

class SortIdState extends CryptoState {
  final List<Coin> sortList;
  const SortIdState(this.sortList);
}

class SortRankState extends CryptoState {
  final List<Coin> sortList;
  const SortRankState(this.sortList);
}

class SortPriceState extends CryptoState {
  final List<Coin> sortList;
  const SortPriceState(this.sortList);
}

class SortNameState extends CryptoState {
  final List<Coin> sortList;
  const SortNameState(this.sortList);
}
