class User {
  String username;
  String password;
  String email;

  User({required this.username, required this.password, required this.email});

  String get user => username;
  String get pass => password;
  String get mail => email;

  void set u(us) => username = us;
  void set p(pass) => password = pass;
  void set e(em) => email = em;

  void viewInfo(String password) {
    if (this.password == password) {
      print(toString());
    } else {
      print("Incorrect password");
    }
  }

  @override
  String toString() {
    return "$email \n$username \n$password";
  }
}
