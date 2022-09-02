class User {
  String name;
  String role;

  ///Constructor
  User({this.name = "", this.role = ""});

  @override
  String toString() {
    return "name: $name, role: $role";
  }
}
