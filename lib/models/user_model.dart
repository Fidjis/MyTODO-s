class User {
  final String id;
  final String name;
  final DateTime created_at;
  final DateTime updated_at;
  final String user_name;
  final String password;

  User({this.id, this.name, this.created_at, this.updated_at, this.user_name, this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      user_name: json['user_name'],
      password: json['password'],
    );
  }
}