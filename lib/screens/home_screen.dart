import 'package:flutter/material.dart';
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
                  FloatingActionButton(mini: true, backgroundColor: primaryColor, onPressed: (){Navigator.of(context).pop();}, child: Icon(Icons.logout),),
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
        // physics: NeverScrollableScrollPhysics(),
        // shrinkWrap: true,
        itemCount:18,
        itemBuilder: (context,index){
          return  CheckboxWidget(checkedValue: false, text: 'Dever de casa',);
        })
    )
  ],);

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
        itemCount:18,
        itemBuilder: (context,index){
          return CheckboxWidget(checkedValue: true, text: 'Dever de casa',);
        })
    )
    
  ],);

  addNewTask() {
    if(newTaskEditingController.text.isNotEmpty){
      
    }
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