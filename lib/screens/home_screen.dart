import 'package:flutter/material.dart';
import 'package:my_todo_s/helper/auth_service.dart';
import 'package:my_todo_s/helper/consts.dart';
import 'package:my_todo_s/helper/helper_functions.dart';
import 'package:my_todo_s/screens/intro_screen.dart';
import 'package:my_todo_s/services/database.dart';
import 'package:my_todo_s/stores/principal_store.dart';
import 'package:my_todo_s/widgets/checkbox_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController newTaskEditingController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final store = PrincipalSt();

  List<dynamic> tasksDone = new List.filled(0, 0);
  List<dynamic> tasksToDo = new List.filled(0, 0);

  @override
  void initState() {
    getTasksToDo();
    getTasksDone();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if (screenWidth < 600.0) { //smartphones
      return _buildBody(); 
    }
    else if (screenWidth < 800.0) { //tablet
      return _buildPersonalSizeScreen(screenWidth, screenHeight, 0.08, 0.1, 0.08, 0.1);
    }
    else if (screenWidth < 1200.0) { //navegador e Desktop
      return _buildPersonalSizeScreen(screenWidth, screenHeight, 0.1, 0.1, 0.1, 0.1);
    }
    else if (screenWidth < 1500.0) { //navegador e Desktop
      return _buildPersonalSizeScreen(screenWidth, screenHeight, 0.15, 0.1, 0.15, 0.1);
    }
    else if (screenWidth < 1800.0) { //navegador e Desktop
      return _buildPersonalSizeScreen(screenWidth, screenHeight, 0.22, 0.1, 0.22, 0.1);
    }
    else { //navegador e Desktop
      return _buildPersonalSizeScreen(screenWidth, screenHeight, 0.3, 0.1, 0.3, 0.1);
    }
  }

  Stack _buildPersonalSizeScreen(double screenWidth, double screenHeight, double l, double t, double r, double b) {
    return Stack(
      children: [
        Image.asset('assets/background_large.jpeg', fit: BoxFit.cover, height: double.infinity, width: double.infinity, alignment: Alignment.center,),
        Container(
          margin: EdgeInsets.fromLTRB(screenWidth * l, screenHeight * t, screenWidth * r, screenHeight * b),
          child: Container(margin: EdgeInsets.all(20), padding: EdgeInsets.all(20), child: Card(elevation: 9, shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30.0),),child: _buildBody(),)),
        ),
      ],
    );
  }

  Scaffold _buildBody() {
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
                      color: Consts.primaryColor
                    )
                  ),
                  FloatingActionButton(
                    mini: true, 
                    backgroundColor: Consts.primaryColor, 
                    onPressed: () {
                      AuthService().signOut().then((value){
                        if(value){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => IntroScreen()));
                        }
                      });
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
        color: Consts.primaryColor
      )
    ),
    store.isLoadingTaskToDo ?
    Flexible(child: Center(child: CircularProgressIndicator(),)) :
    Flexible(
      child: ListView.builder(
        itemCount: tasksToDo.length,
        itemBuilder: (context,index){
          return CheckboxWidget(checkedValue: tasksToDo[index]["done"], text: tasksToDo[index]["description"], id: tasksToDo[index]["id"]);
        })
    )
  ],);

  getTasksToDo() async {
    DatabaseMethods().getTasks(Consts.userID, false).then((snapshots) {
      snapshots.listen((data) {
        store.setiIsLoadingTaskToDo(false);
        setState(() {
          tasksToDo = data['data']["tasks"];
          print(data['data']["tasks"]);
        });
      }).onError((err) {
        print(err);
        store.setiIsLoadingTaskToDo(false);
      });
    });
  }
  
  getTasksDone() async {
    DatabaseMethods().getTasks(Consts.userID, true).then((snapshots) {
      snapshots.listen((data) {
        store.setIsLoadingTaskDone(false);
        setState(() {
          //tasksToDo = data['data']["tasks"];
          tasksDone = data['data']["tasks"];
          print(data['data']["tasks"]);
        });
      }).onError((err) {
        print(err);
        store.setIsLoadingTaskDone(false);
      });
    });
  }

  Column _buildMyTasksComplete() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    SizedBox(height: 5.0,),
    Text(
      'DONE',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Consts.primaryColor
      )
    ),
    store.isLoadingTaskDone ?
    Flexible(child: Center(child: CircularProgressIndicator(),)) :
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
        HelperFunctions.showInSnackBar("Task Added!", _scaffoldKey, context, Consts.terciaryColor);
      else
        HelperFunctions.showInSnackBar("Error!", _scaffoldKey, context, Consts.terciaryColor);
    }
    else
      HelperFunctions.showInSnackBar("Fill in all fields!", _scaffoldKey, context, Consts.terciaryColor);

    newTaskEditingController.text = "";
  }

  _buildNewTaskWidget() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: newTaskEditingController,
            decoration: InputDecoration(
              hintText: "New Task...",
              hintStyle: TextStyle(color: Consts.segundaryColor),
              //prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
              filled: true,
              fillColor: Consts.terciaryColor,
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
                side: BorderSide(width: 2, color: Consts.terciaryColor),
            ),
            onPressed: () {
              addNewTask();
            },
            child: Icon(
              Icons.add,
              color: Consts.terciaryColor,
            ),
          ),
        ),
      ],
    );
  }
}