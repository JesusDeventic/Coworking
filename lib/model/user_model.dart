/// Modelo de usuario devuelto por la API de Filmoly (WordPress).
class FilmolyUser {
  int id;
  String username;
  String email;
  String displayName;
  String dateFormat;
  String weekStart;

  FilmolyUser({
    this.id = 0,
    this.username = '',
    this.email = '',
    this.displayName = '',
    this.dateFormat = 'dd/MM/yyyy',
    this.weekStart = 'monday',
  });

  bool get isEmpty => id == 0 && username.isEmpty;

  factory FilmolyUser.fromJson(Map<String, dynamic> json) {
    return FilmolyUser(
      id: (json['id'] as num?)?.toInt() ?? 0,
      username: (json['username'] as String?) ?? '',
      email: (json['email'] as String?) ?? '',
      displayName: (json['display_name'] as String?) ?? '',
      dateFormat: (json['date_format'] as String?) ?? 'dd/MM/yyyy',
      weekStart: (json['start_day_week'] as String?) ?? 'monday',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'display_name': displayName,
        'date_format': dateFormat,
        'start_day_week': weekStart,
      };
}
