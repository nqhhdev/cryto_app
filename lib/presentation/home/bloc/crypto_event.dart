part of 'crypto_bloc.dart';

abstract class CryptoEvent extends Equatable {
  const CryptoEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class OnSearchEvent extends CryptoEvent {
  String query;

  OnSearchEvent({required this.query});
}

// ignore: must_be_immutable
class LoadSearchEvent extends CryptoEvent {
  String? api;
  String? id;
  LoadSearchEvent({this.api, this.id});
}

class SortRankEvent extends CryptoEvent {
  final bool isAscending;
  final List<Coin> listcurrency;

  const SortRankEvent(this.isAscending, this.listcurrency);
}

class SortNameEvent extends CryptoEvent {
  final bool isAscending;
  final List<Coin> listcurrency;

  const SortNameEvent(this.isAscending, this.listcurrency);
}

class SortPriceEvent extends CryptoEvent {
  final bool isAscending;
  final List<Coin> listcurrency;

  const SortPriceEvent(this.isAscending, this.listcurrency);
}
