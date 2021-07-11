import 'package:crypto_app_project/domain/favourites_db.dart';

class FavoriteCoin {
  String email;
  String ids;
  FavoriteCoin({
    required this.ids,
    required this.email,
  });
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'ids': ids,
    };
  }
}
