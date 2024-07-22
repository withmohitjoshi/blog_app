import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    required super.name,
  });

  factory UserModel.fromJSON(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
    );
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }
}
