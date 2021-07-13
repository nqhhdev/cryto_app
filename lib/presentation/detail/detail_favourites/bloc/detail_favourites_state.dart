part of 'detail_favourites_bloc.dart';

abstract class DetailFavouritesState extends Equatable {
  const DetailFavouritesState();

  @override
  List<Object> get props => [];
}

class DetailFavouritesInitial extends DetailFavouritesState {}

class LoadingDetailFavouritesState extends DetailFavouritesState {}

// ignore: must_be_immutable
class LoadDetailFavouritesSuccessStatee extends DetailFavouritesState {
  List<Coin>? listcoin;
  List<Chart>? listChart;
  double? maxY;
  double? minY;

  LoadDetailFavouritesSuccessStatee({
    this.maxY,
    this.minY,
    this.listcoin,
    this.listChart,
  });
}

class LoadDetailFavouritesFailState extends DetailFavouritesState {}

class AddingFavoriteState extends DetailFavouritesState {}

class AddFavoriteSuccessState extends DetailFavouritesState {
  final String id;
  AddFavoriteSuccessState({
    required this.id,
  });
}

// ignore: must_be_immutable
class AddFavoriteFailState extends DetailFavouritesState {
  String? error;
  AddFavoriteFailState({this.error});
}
