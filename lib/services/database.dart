import 'dart:async';
import 'dart:convert';

import 'package:hasura_connect/hasura_connect.dart';
import 'package:my_todo_s/models/user_model.dart';

class DatabaseMethods {

  String queryGetUsers = "query MyQuery {users {id name}}";

  Future<User> createUser(String email, String user_name, String pass) async {
    HasuraConnect conexao = await HasuraConnect("https://desafio-flutter.herokuapp.com/v1/graphql", headers: {'x-hasura-admin-secret': "J!Bz2n"});
    
    String query = """"
      mutation MyMutation {
        insert_users(objects: {name: "${email}", password: "${pass}", user_name: "${user_name}"}) {
          returning {
            id,
            name,
            email
          }
        }
      }
    """;
    
    bool isConnected = conexao.isConnected;
    var snapshot = await conexao.query(query);
    print(snapshot.toString());
    
    final responseJson = jsonDecode(snapshot.body);
    return User.fromJson(responseJson);
  }
}





