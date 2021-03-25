import 'dart:async';
import 'dart:convert';

import 'package:hasura_connect/hasura_connect.dart';
import 'package:my_todo_s/models/task_model.dart';
import 'package:my_todo_s/models/user_model.dart';

class DatabaseMethods {

  final http = "https://desafio-flutter.herokuapp.com/v1/graphql";
  final headers = {'x-hasura-admin-secret': "J!Bz2n"};

  Future<User> createUser(String email, String user_name, String pass) async {
    bool emailDisponivel = await verificarDisponibilidadeEmail(email);
    if(!emailDisponivel) return null;

    HasuraConnect conexao = await HasuraConnect(http, headers: headers);

    String query = """
        mutation MyMutation {
          insert_users(objects: {name: "${email}", password: "${pass}", user_name: "${user_name}"}) {
            returning {
                id
                name
                user_name
              }
            }
          }
        """;

    // bool isConnected = conexao.isConnected;
    // var snapshot = await conexao.query(query);
    // final responseJson = jsonDecode(snapshot.body);
    // return User.fromJson(responseJson);

    bool isConnected = conexao.isConnected;
    var snapshot = await conexao.mutation(query);
    // print(snapshot['data']["users"][0].toString());
    print(snapshot['data']["insert_users"]["returning"].toString());
    
    final responseJson = snapshot['data']["insert_users"]["returning"][0];
    return User.fromJson(responseJson);
  }

  Future<User> singIn(String email, String pass) async {
    HasuraConnect conexao = await HasuraConnect(http, headers: headers);

    String query = """
        query MyQuery {
            users(where: {name: {_eq: "${email.trim()}"}}) {
              id
              name
              user_name
              password
            }
          }
        """;

    bool isConnected = conexao.isConnected;
    var snapshot = await conexao.query(query);
    // print(snapshot['data']["users"][0].toString());
    //print(snapshot['data']["users"][0].toString());
    
    final responseJson = snapshot['data']["users"][0];
    return User.fromJson(responseJson);
  }

  Future<bool> verificarDisponibilidadeEmail(String email) async {
    HasuraConnect conexao = await HasuraConnect(http, headers: headers);

    String query = """
        query MyQuery {
            users(where: {name: {_eq: "${email.trim()}"}}) {
              id
            }
          }
        """;

    bool isConnected = conexao.isConnected;
    var snapshot = await conexao.query(query);
    
    final List<dynamic> responseJson = snapshot['data']["users"];
    if (responseJson.length == 0) return true;
    else return false;
  }

  Future<Stream> getTasks(String idUser, bool done) async {
    HasuraConnect conexao = await HasuraConnect(http, headers: headers);

    String query = """
        subscription {
          tasks(where: {done: {_eq: ${done}}, user_id: {_eq: "${idUser}"}}) {
            created_at
            description
            done
            id
            user_id
          }
        }
        """;

    bool isConnected = conexao.isConnected;
    var snapshot = await conexao.subscription(query);

    return snapshot;
  }

  Future<bool> createTask(String userId, String description) async {
    HasuraConnect conexao = await HasuraConnect(http, headers: headers);

    String query = """
        mutation MyMutation {
          insert_tasks(objects: {description: "${description}", done: false, user_id: "${userId}"}) {
            returning {
              id
            }
          }
        }
        """;

    bool isConnected = conexao.isConnected;
    var snapshot = await conexao.mutation(query);
    print(snapshot['data']["insert_tasks"]["returning"].toString());
    
    final responseJson = snapshot['data']["insert_tasks"]["returning"][0];
    Task task =  Task.fromJson(responseJson);

    if(task.id != null) return true;
    else return false;
  }

  Future<bool> updateTask(String taskId, bool done) async {
    HasuraConnect conexao = await HasuraConnect(http, headers: headers);

    String query = """
        mutation MyMutation {
          update_tasks_by_pk(pk_columns: {id: "${taskId}"}, _set: {done: ${done}}) {
            id
          }
        }
        """;

    bool isConnected = conexao.isConnected;
    var snapshot = await conexao.mutation(query);

    final responseJson = snapshot['data']["update_tasks_by_pk"];
    Task task =  Task.fromJson(responseJson);

    if(task.id != null) return true;
    else return false;
  }

  Future<bool> deleteTask(String taskId) async {
    HasuraConnect conexao = await HasuraConnect(http, headers: headers);

    String query = """
        mutation MyMutation {
          delete_tasks(where: {id: {_eq: "${taskId}"}}) {
            returning {
              id
            }
          }
        }
        """;

    bool isConnected = conexao.isConnected;
    var snapshot = await conexao.mutation(query);

    final responseJson = snapshot['data']["delete_tasks"]["returning"][0];
    Task task =  Task.fromJson(responseJson);

    if(task.id != null) return true;
    else return false;
  }
}





