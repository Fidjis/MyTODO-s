import 'package:my_todo_s/services/database.dart';

class AuthService {

  Future createUserLogin(String email, String pass) async {
    await DatabaseMethods().createUser(email, email, pass);
  }

  Future signIn(String email, String pass) async {
    try {
      // return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  
  Future signOut() async {
    try {
      // return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
