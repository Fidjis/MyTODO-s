import 'package:my_todo_s/helper/consts.dart';
import 'package:my_todo_s/helper/helper_functions.dart';
import 'package:my_todo_s/models/user_model.dart';
import 'package:my_todo_s/services/database.dart';
import 'package:my_todo_s/stores/principal_store.dart';

class AuthService {

  final store = PrincipalSt();

  Future<bool> createUserLogin(String email, String pass) async {
    User user = await DatabaseMethods().createUser(email, email, pass);
    if(user != null){
      

      Consts.userEmail = user.name;
      Consts.userID = user.id;
      Consts.userName = user.user_name;
      await HelperFunctions.saveUserEmailSharedPreference(user.name);
      await HelperFunctions.saveUserNameSharedPreference(user.user_name);
      await HelperFunctions.saveUserIdSharedPreference(user.id.toString());
      await HelperFunctions.saveUserLoggedInSharedPreference(true);

      store.setLogged(true);
      return true;
    }else 
      return false;
  }

  Future<bool> signIn(String email, String pass) async {
    User user = await DatabaseMethods().singIn(email, pass);
    if(user != null){
      if(user.password == pass){

        Consts.userEmail = user.name;
        Consts.userID = user.id;
        Consts.userName = user.user_name;
        await HelperFunctions.saveUserEmailSharedPreference(user.name);
        await HelperFunctions.saveUserNameSharedPreference(user.user_name);
        await HelperFunctions.saveUserIdSharedPreference(user.id.toString());
        await HelperFunctions.saveUserLoggedInSharedPreference(true);

        store.setLogged(true);
        
        return true;
      }
      return false;
    }else 
      return false;
  }
  
  Future<bool> signOut() async {
    return  await HelperFunctions.removeInfoSharedPreference();
  }
}
