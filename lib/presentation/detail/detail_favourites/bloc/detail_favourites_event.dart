part of 'detail_favourites_bloc.dart';

abstract class DetailFavouritesEvent extends Equatable {
  const DetailFavouritesEvent();

  @override
  List<Object> get props => [];
}

class LoadDetailFavouritesEvent extends DetailFavouritesEvent {
  String id;
  LoadDetailFavouritesEvent({
    required this.id,
  });
}

class AddFavoriteEvent extends DetailFavouritesEvent {
  String id;
  String email;
  AddFavoriteEvent({
    required this.id,
    required this.email,
  });
}
