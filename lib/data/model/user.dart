import 'dart:convert';

class User {
  final String id;
  final String? email;
  final String? username;
  final String? photoUrl;

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  const User({
    required this.id,
    this.email,
    this.username,
    this.photoUrl,
  });

  User copyWith({
    String? id,
    String? email,
    String? username,
    String? photoUrl,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({
      'id': id
    });
    if (email != null) {
      result.addAll({
        'email': email
      });
    }
    if (username != null) {
      result.addAll({
        'username': username
      });
    }
    if (photoUrl != null) {
      result.addAll({
        'photoUrl': photoUrl
      });
    }

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, email: $email, username: $username, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.id == id && other.email == email && other.username == username && other.photoUrl == photoUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^ email.hashCode ^ username.hashCode ^ photoUrl.hashCode;
  }
}
