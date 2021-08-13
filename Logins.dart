import 'User.dart';

import 'Runner.dart';

class Logins {
  List logins = [];

  Map<String, User> savedlogins = {};

  User? findUser(String username) {
    User u = User(email: '', username: '', password: '');
    logins.forEach((us) {
      if (us.username == username) {
        u = us;
      }
    });
    return u;
  }

  void saveLogin(String key, User u) {
    if (!savedlogins.containsKey(key) && !savedlogins.containsValue(u)) {
      savedlogins[key] = u;
    }
  }

  void viewSavedLogins() {
    print(savedlogins.keys);
  }

  void addLogin(User u) {
    if (!logins.contains(u))
      logins.add(u);
    else
      print("User with given credentials already registered.");
  }

  void removeLogin(User u) {
    if (savedlogins.containsValue(u)) {
      savedlogins.remove(u);
    }
    if (logins.contains(u)) {
      logins.remove(u);
      print("Deleted account.");
    } else {
      print("No such account found.");
    }
  }

  void viewLogins(String admin) {
    logins.forEach((us) => print(us));
  }

  void updateLogin(User u, String? email, String? username, String? password) {
    if (email != null) u.e = email;
    if (username != null) u.u = username;
    if (password != null) u.p = password;
  }

  void checkLogin(String username, String password) {
    logins.forEach((us) {
      if (us.user == username && us.pass == password) {
        print("Successfuly logged in.");
        Runner.currentUser = username;
        Runner.currentPass = password;
        return;
      }
    });
    if (Runner.currentUser.isEmpty)
      print("No account found with that username or password.");
  }
}
