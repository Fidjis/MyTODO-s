import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_todo_s/helper/auth_service.dart';
import 'package:my_todo_s/helper/consts.dart';
import 'package:my_todo_s/helper/helper_functions.dart';
import 'package:my_todo_s/screens/home_screen.dart';
import 'package:my_todo_s/stores/principal_store.dart';

class LoginScreen extends StatefulWidget {

  final bool newAcc;

  LoginScreen(this.newAcc);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool newAcc;
  bool _obscureTextLogin = true;
  bool visibleSenha2 = false;
  double heightNewAcc = 0;

  final store = PrincipalSt();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController01 = new TextEditingController();
  TextEditingController loginPasswordController02 = new TextEditingController();

  @override
  void initState() {
    newAcc = widget.newAcc;
    if(!newAcc){
      heightNewAcc = 0;
      visibleSenha2 = false;
    } else {
      heightNewAcc = 90;
      visibleSenha2 = true;
    }
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

  _buildBody() {
    return Observer(
      builder: (_) =>Scaffold(
        backgroundColor: Colors.transparent,
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 25.0),
                child: FloatingActionButton(mini: true, backgroundColor: Consts.primaryColor, onPressed: (){
                  Navigator.of(context).pop();
                }, 
                child: Icon(Icons.keyboard_arrow_left_outlined),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 15.0),
                child: Text(
                  newAcc? 'Register' : 'Login',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight .bold,
                    color: Consts.primaryColor
                  )
                ),
              ),
              SizedBox(height:50),
              Center(child:_buildSignIn()),
            ],
          ),
        ),
      ),
    ));
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  Widget _buildSignIn() {
    return Container(
      //padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                height: 280,
                child: Center(
                  child: Card(
                    elevation: 6.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: AnimatedContainer(
                      duration: new Duration(milliseconds: 650),
                      width: 300.0,
                      //height: newAcc? 270.0 : 190.0,
                      height: heightNewAcc != 0 ? 270.0 : 190.0,
                      child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                              child: TextField(
                                controller: loginEmailController,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    Icons.email,
                                    color: Colors.black54,
                                    size: 22.0,
                                  ),
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                    fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                                ),
                              ),
                            ),
                            Container(
                              width: 250.0,
                              height: 1.0,
                              color: Colors.grey[400],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                              child: TextField(
                                controller: loginPasswordController01,
                                obscureText: _obscureTextLogin,
                                style: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    Icons.lock,
                                    size: 22.0,
                                    color: Colors.black54,
                                  ),
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                    fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                                  suffixIcon: GestureDetector(
                                    onTap: _toggleLogin,
                                    child: Icon(
                                      _obscureTextLogin
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                      size: 15.0,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //confirmar senha
                            AnimatedContainer(
                              duration: new Duration(milliseconds: 700),
                              height: heightNewAcc,
                              onEnd: (){
                                setState(() {
                                  if(!newAcc)
                                    visibleSenha2 = true;
                                  newAcc = !newAcc;
                                });
                              },
                              child: Visibility(
                                visible: visibleSenha2,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      width: 250.0,
                                      height: 1.0,
                                      color: Colors.grey[400],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                                      child: TextField(
                                        controller: loginPasswordController02,
                                        obscureText: _obscureTextLogin,
                                        style: TextStyle(
                                          fontFamily: "WorkSansSemiBold",
                                          fontSize: 16.0,
                                          color: Colors.black),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          icon: Icon(
                                            Icons.lock,
                                            size: 22.0,
                                            color: Colors.black54,
                                          ),
                                          hintText: "Confirm Password",
                                          hintStyle: TextStyle(
                                            fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                                          suffixIcon: GestureDetector(
                                            onTap: _toggleLogin,
                                            child: Icon(
                                              _obscureTextLogin
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                              size: 15.0,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: FloatingActionButton.extended(
              onPressed: (){
                if(!store.isLoading){//evitar duplo click
                  
                    store.setIsLoading(true);
                    if(loginPasswordController01.text.length > 4 && RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(loginEmailController.text)){
                      if(newAcc){
                        if(loginPasswordController01.text == loginPasswordController02.text) {
                          AuthService().createUserLogin(loginEmailController.text, loginPasswordController01.text).then((sucess) {
                            if(sucess) 
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                            else
                              HelperFunctions.showInSnackBar("Error!", _scaffoldKey, context, Consts.terciaryColor);
                            store.setIsLoading(false);
                          });
                        }else{
                          HelperFunctions.showInSnackBar("Password not match!", _scaffoldKey, context, Consts.terciaryColor);
                          store.setIsLoading(false);
                        }
                      }
                      else{
                        AuthService().signIn(loginEmailController.text, loginPasswordController01.text).then((sucess) {
                          if(sucess) 
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                          else
                            HelperFunctions.showInSnackBar("Incorrect credentials", _scaffoldKey, context, Consts.terciaryColor);
                          store.setIsLoading(false);
                        });
                      }
                    }else{
                      HelperFunctions.showInSnackBar("Fill in all the fields!", _scaffoldKey, context, Consts.terciaryColor);
                      store.setIsLoading(false);
                    }
                  
                }
              },
              heroTag: "login",
              label: store.isLoading ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Consts.segundaryColor),) : Text("Login", style: TextStyle(color: Colors.white)),
              backgroundColor: Consts.primaryColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: TextButton(
              onPressed: () {
                HelperFunctions.showInSnackBar("Wait for updates!", _scaffoldKey, context, Consts.terciaryColor);
              },
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Consts.terciaryColor,
                  fontSize: 16.0,
                  fontFamily: "WorkSansMedium"),
              )
            ),
          ),
        ],
      ),
    );
  }
}