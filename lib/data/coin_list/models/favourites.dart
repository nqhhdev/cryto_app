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
