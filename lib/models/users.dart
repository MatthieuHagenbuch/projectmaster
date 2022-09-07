class User {
  String? email;
  String? uId;
  String? role;

  ///Constructor
  User({this.email, this.uId, this.role = 'user'});

  @override
  String toString() {
    return "email: $email, uId: $uId, role: $role";
  }

  factory User.fromJson(Map<String, dynamic> json) => _eventFromJson(json);

  Map<String, dynamic> toJson() => _eventToJson(this);
}

User _eventFromJson(Map<String, dynamic> json) {
  return User(
    email: (json['email'] as String),
    uId: (json['uId'] as String),
    role: (json['role'] as String),
  );
}

Map<String, dynamic> _eventToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'uId': instance.uId,
      'role': instance.role,
    };
