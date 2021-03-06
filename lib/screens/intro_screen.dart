import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_todo_s/helper/auth_service.dart';
import 'package:my_todo_s/helper/consts.dart';
import 'package:my_todo_s/helper/helper_functions.dart';
import 'package:my_todo_s/screens/home_screen.dart';
import 'package:my_todo_s/screens/login_screen.dart';
import 'package:my_todo_s/stores/principal_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  AuthService authService = new AuthService();
  final store = PrincipalSt();

  @override
  void initState() {
    super.initState();
    getLoggedInState();
  }

  getLoggedInState() async {
    store.setIsLoading(true);
    await HelperFunctions.getUserLoggedInSharedPreference().then((value){
      store.setLogged(value);

      Future.delayed(const Duration(milliseconds: 3000), () async {
        store.setIsLoading(false);
        if(value){
          Consts.userEmail = await HelperFunctions.getUserEmailSharedPreference();
          Consts.userID = await HelperFunctions.getUserIdSharedPreference();
          Consts.userName = await HelperFunctions.getUserNameSharedPreference();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Theme.of(context).platform != TargetPlatform.android ? 
          Image.asset('assets/background_large.jpeg', fit: BoxFit.cover, height: double.infinity, width: double.infinity, alignment: Alignment.center,), //:
          // Image.asset('assets/background.jpeg'),
          Container(color: Colors.white70.withOpacity(0.5),),
          buildBackgroundAppName(),
          buildBackgroundAppNameShadow(),
          _buildBottom(),
          // FloatingActionButton(onPressed: () async {
          //   bool user = await DatabaseMethods().createTask("d4b95036-9d63-4356-814a-3a20768b10ce", "teste 1");
          //   print(user);
          // })
        ],
      ),
    ));
  }

  Positioned _buildBottom() {
    return Positioned(
      bottom: 0.0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: store.isLoading ? Center(child: CircularProgressIndicator()) : Row(
          mainAxisAlignment:  MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(true)));
              }, 
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Registrar', style: TextStyle(color: Consts.primaryColor),),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: new LinearGradient(
                  colors: [
                    Colors.white10,
                    Consts.primaryColor,
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
              ),
              width: 50.0,
              height: 1.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Text(
                "Ou",
                style: TextStyle(
                  color: Consts.primaryColor,
                  fontSize: 16.0,
                  fontFamily: "WorkSansMedium"),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: new LinearGradient(
                  colors: [
                    Consts.primaryColor,
                    Colors.white10,
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
              ),
              width: 50.0,
              height: 1.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Consts.primaryColor, // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: () {
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(false)));
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                child: Text('Login', style: TextStyle(color: Consts.segundaryColor),),
              ),
            )
          ],
        ),
      ),
    );
  }
  Padding buildBackgroundAppName() {
    return Padding(
      //padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 15.0, ),
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0, ),
      child: Text(
        "MyTODO's",
        style: TextStyle(
          color: Consts.primaryColor,
          fontSize: 50,
          fontFamily: "Lobster",
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Padding buildBackgroundAppNameShadow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0,),
      child: Text(
        "MyTODO's",
        style: TextStyle(
          color: Colors.white,
          fontSize: 50,
          fontFamily: "Lobster",
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}