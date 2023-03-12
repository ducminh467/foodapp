class User {
  final String email, name, password;
  final int define;
  User({required this.email, required this.name, required this.password, required this.define});
}

User currentUser = User(email: "email", name: "name", password: "password", define: 1);