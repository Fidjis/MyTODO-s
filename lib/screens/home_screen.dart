import 'package:flutter/material.dart';
import 'package:my_todo_s/helper/auth_service.dart';
import 'package:my_todo_s/helper/consts.dart';
import 'package:my_todo_s/models/task_model.dart';
import 'package:my_todo_s/screens/intro_screen.dart';
import 'package:my_todo_s/services/database.dart';
import 'package:my_todo_s/widgets/checkbox_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  var primaryColor = const Color(0xFF008080);
  var segundaryColor = Colors.white;
  var terciaryColor = const Color(0xFF20B2AA);
  TextEditingController newTaskEditingController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    getTasksToDo();
    getTasksDone();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 10.0, left: 10.0, right: 10.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'To-do list',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight .bold,
                      color: primaryColor
                    )
                  ),
                  FloatingActionButton(mini: true, backgroundColor: primaryColor, onPressed: () async {
                    if(await AuthService().signOut())
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => IntroScreen()));
                    }, 
                    child: Icon(Icons.logout),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 20, bottom: 20), child: _buildNewTaskWidget(),),
              Expanded(flex:6, child: _buildMyTasksToDo()),
              Expanded(flex:4, child: _buildMyTasksComplete())
            ],
          ),
        ),
      ),
    );
  }

  Column _buildMyTasksToDo() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(
      'TASKS',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: primaryColor
      )
    ),
    Flexible(
      child: ListView.builder(
        itemCount: tasksToDo.length,
        itemBuilder: (context,index){
          return CheckboxWidget(checkedValue: tasksToDo[index]["done"], text: tasksToDo[index]["description"], id: tasksToDo[index]["id"]);
        })
    )
  ],);

  List<dynamic> tasksToDo = new List<dynamic>();
  getTasksToDo() async {
    DatabaseMethods().getTasks(Consts.userID, false).then((snapshots) {
      snapshots.listen((data) {
        setState(() {
          tasksToDo = data['data']["tasks"];
          print(data['data']["tasks"]);
        });
      }).onError((err) {
        print(err);
      });
    });
  }
  List<dynamic> tasksDone = new List<dynamic>();
  getTasksDone() async {
    DatabaseMethods().getTasks(Consts.userID, true).then((snapshots) {
      snapshots.listen((data) {
        setState(() {
          //tasksToDo = data['data']["tasks"];
          tasksDone = data['data']["tasks"];
          print(data['data']["tasks"]);
        });
      }).onError((err) {
        print(err);
      });
    });
  }

  Column _buildMyTasksComplete() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(
      'DONE',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: primaryColor
      )
    ),
    Flexible(
      child: ListView.builder(
        // physics: NeverScrollableScrollPhysics(),
        // shrinkWrap: true,
        itemCount: tasksDone.length,
        itemBuilder: (context,index){
          return CheckboxWidget(checkedValue: tasksDone[index]["done"], text: tasksDone[index]["description"], id: tasksDone[index]["id"]);
        })
    )
  ],);

  addNewTask() async {
    if(newTaskEditingController.text.isNotEmpty){
      bool result = await DatabaseMethods().createTask(Consts.userID, newTaskEditingController.text);
      if(result)
        showInSnackBar("Task Added!");
      else
        showInSnackBar("Error!");
    }
    else
      showInSnackBar("Fill in all fields!");
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: terciaryColor,
      duration: Duration(seconds: 3),
    ));
  }

  _buildNewTaskWidget() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: newTaskEditingController,
            decoration: InputDecoration(
              hintText: "New Task...",
              hintStyle: TextStyle(color: segundaryColor),
              //prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
              filled: true,
              fillColor: terciaryColor,
              contentPadding: EdgeInsets.all(8),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                      color: Colors.grey.shade100
                  )
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                side: BorderSide(width: 2, color: terciaryColor),
            ),
            onPressed: () {
              addNewTask();
            },
            child: Icon(
              Icons.add,
              color: terciaryColor,
            ),
          ),
        ),
      ],
    );
  }
}