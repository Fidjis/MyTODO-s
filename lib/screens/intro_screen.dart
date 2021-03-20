import 'package:flutter/material.dart';
import 'package:my_todo_s/helper/auth_service.dart';
import 'package:my_todo_s/screens/home_screen.dart';
import 'package:my_todo_s/screens/login_screen.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  var primaryColor = const Color(0xFF008080);
  var segundaryColor = Colors.white;
  var terciaryColor = const Color(0xFF20B2AA);
  bool isLoading = false;
  AuthService authService = new AuthService();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Theme.of(context).platform != TargetPlatform.android ? 
          Image.asset('assets/background_large.jpeg', fit: BoxFit.cover, height: double.infinity, width: double.infinity, alignment: Alignment.center,), //:
          // Image.asset('assets/background.jpeg'),
          Container(color: Colors.white70.withOpacity(0.5),),
          buildBackgroundAppName(),
          buildBackgroundAppNameShadow(),
          Positioned(
            bottom: 0.0, 
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              color: Colors.white,
              child: Row(
                mainAxisAlignment:  MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    }, 
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Registrar', style: TextStyle(color: primaryColor),),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: new LinearGradient(
                        colors: [
                          Colors.white10,
                          primaryColor,
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
                        color: primaryColor,
                        fontSize: 16.0,
                        fontFamily: "WorkSansMedium"),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: new LinearGradient(
                        colors: [
                          primaryColor,
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
                      primary: primaryColor, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      child: Text('Login', style: TextStyle(color: segundaryColor),),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
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
          color: primaryColor,
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

  signIn() async {
    //if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      //sing in normal
      //await authService.signInWithEmailAndPassword(emailEditingController.text, passwordEditingController.text)
      //singi google
      await authService.signIn()
        .then((result) async {
          if (result != null)  {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          } else {
            setState(() {
              isLoading = false;
              //show snackbar
            });
          }
        });
    //}
  }
}