part of 'favourites_bloc.dart';

abstract class FavouritesEvent extends Equatable {
  const FavouritesEvent();

  @override
  List<Object> get props => [];
}

class LoadFavoriteEvent extends FavouritesEvent {
  final String email;
  LoadFavoriteEvent({
    required this.email,
  });
}

// ignore: must_be_immutable
class DeleteFavoriteEvent extends FavouritesEvent {
  final String email;
  final String id;
  DeleteFavoriteEvent({
    required this.email,
    required this.id,
  });
}
