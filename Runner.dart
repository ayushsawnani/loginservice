import 'dart:io';

import 'Logins.dart';
import 'User.dart';

class Runner {
  static String currentUser = "";
  static String currentPass = "";

  String secretkey = "abc123";
  List commands = [
    '/help',
    '/logout',
    '/delete',
    '/view',
    '/viewlogin',
    '/save',
    '/viewsaved',
    '/update email',
    '/update password',
    '/update username'
  ];
  Runner() {
    Logins logins = new Logins();
    print("Welcome to Login Page!");
    while (true) {
      if (!loggedIn()) {
        print(
            "You have not logged in yet. Would u like to /login or /register? ");
        String? loginOrRegister = stdin.readLineSync();
        if (loginOrRegister == '/login') {
          print("Do you want to use a saved login (y/n)?");
          String saved = stdin.readLineSync()!;

          if (saved == 'y') {
            logins.viewSavedLogins();
            if (logins.savedlogins.length > 0) {
              print("Choose the login you would like to use.");
              String key = stdin.readLineSync()!;
              if (logins.savedlogins.containsKey(key)) {
                logins.checkLogin(logins.savedlogins[key]!.user,
                    logins.savedlogins[key]!.pass);
              } else {
                print("That key does not exist.");
              }
            } else {
              print("There are no saved keys.");
            }
          } else {
            print("Username: ");
            String? user = stdin.readLineSync();
            print("Password: ");
            String? pass = stdin.readLineSync();
            logins.checkLogin(user!, pass!);
          }
        } else if (loginOrRegister == '/register') {
          print("Email: ");
          String email = stdin.readLineSync()!;
          print("Username: ");
          String user = stdin.readLineSync()!;
          print("Password: ");
          String pass = stdin.readLineSync()!;
          User u = User(username: user, email: email, password: pass);
          logins.addLogin(u);
          currentUser = user;
          currentPass = pass;
        }
      } else {
        print("Logged in as $currentUser");
        String options = stdin.readLineSync()!;
        chooseOption(logins, options);
      }
    }
  }

  bool loggedIn() {
    if (currentUser.isEmpty) return false;
    return true;
  }

  void logout() {
    currentUser = "";
    currentPass = "";
  }

  void chooseOption(Logins logins, String options) {
    switch (options) {
      case '/help':
        commands.forEach((cmd) => print(cmd));
        break;
      case '/logout':
        logout();
        break;
      case '/delete':
        logins.removeLogin(logins.findUser(currentUser)!);
        logout();
        break;
      case '/view':
        print("Please enter your password for security purposes.");
        String passwordcheck = stdin.readLineSync()!;
        User temp = logins.findUser(currentUser)!;
        temp.viewInfo(passwordcheck);
        break;
      case '/viewlogin':
        print("$currentUser");
        break;
      case '/save':
        print("What should the saved login be called?");
        String key = stdin.readLineSync()!;
        logins.saveLogin(key, logins.findUser(currentUser)!);
        break;
      case '/viewsaved':
        logins.viewSavedLogins();
        break;
      case '/update email':
        print("New email: ");
        String newemail = stdin.readLineSync()!;
        logins.updateLogin(logins.findUser(currentUser)!, newemail, null, null);
        break;
      case '/update password':
        print("New password: ");
        String newpass = stdin.readLineSync()!;
        logins.updateLogin(logins.findUser(currentUser)!, null, null, newpass);
        currentPass = newpass;
        break;
      case '/update username':
        print("New username: ");
        String newusername = stdin.readLineSync()!;
        logins.updateLogin(
            logins.findUser(currentUser)!, null, newusername, null);

        currentUser = newusername;
        break;
      case '/view logins':
        print("Key: ");
        String key = stdin.readLineSync()!;
        if (key == secretkey)
          logins.viewLogins(secretkey);
        else
          print("Invalid key.");

        break;
      default:
        print(
            "Invalid command. $options isn't recognized as a command for Login Page");
    }
  }
}

void main() {
  new Runner();
}
