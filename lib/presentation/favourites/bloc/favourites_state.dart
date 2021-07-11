part of 'favourites_bloc.dart';

abstract class FavouritesState extends Equatable {
  const FavouritesState();

  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavouritesState {}

class FavoriteLoadingState extends FavouritesState {}

class FavoriteLoadingFailState extends FavouritesState {}

// ignore: must_be_immutable
class FavoriteLoadingSuccessState extends FavouritesState {
  List<Coin> listCoin;
  // List<Coin> listcurrency;
  FavoriteLoadingSuccessState({
    required this.listCoin,
    // required this.listcurrency,
  });
}

class FavoriteIsEmptyState extends FavouritesState {}

// ignore: must_be_immutable
class DeleteFavoriteSuccessState extends FavouritesState {
  String? id;
  DeleteFavoriteSuccessState({
    required this.id,
  });
}

class DeleteFavoriteFailState extends FavouritesState {}
