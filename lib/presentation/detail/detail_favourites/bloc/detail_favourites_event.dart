part of 'detail_favourites_bloc.dart';

abstract class DetailFavouritesEvent extends Equatable {
  const DetailFavouritesEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class LoadDetailFavouritesEvent extends DetailFavouritesEvent {
  String id;
  LoadDetailFavouritesEvent({
    required this.id,
  });
}

// ignore: must_be_immutable
class AddFavoriteEvent extends DetailFavouritesEvent {
  String id;
  String email;
  AddFavoriteEvent({
    required this.id,
    required this.email,
  });
}
