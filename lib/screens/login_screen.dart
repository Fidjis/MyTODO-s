import 'package:flutter/material.dart';
import 'package:my_todo_s/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool newAcc = false;
  bool _obscureTextLogin = true;
  bool visibleSenha2 = false;
  double heightNewAcc = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController01 = new TextEditingController();
  TextEditingController loginPasswordController02 = new TextEditingController();

  var primaryColor = const Color(0xFF008080);
  var segundaryColor = Colors.white;
  var terciaryColor = const Color(0xFF20B2AA);

  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: FloatingActionButton(mini: true, backgroundColor: primaryColor, onPressed: (){Navigator.of(context).pop();}, child: Icon(Icons.keyboard_arrow_left_outlined), ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text(
                newAcc? 'Register' : 'Login',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight .bold,
                  color: primaryColor
                )
              ),
            ),
            _buildSignIn(),
          ],
        ),
      ),
    );
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
                    elevation: 2.0,
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
                                  hintText: "Senha",
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
                                          hintText: "Confirmar Senha",
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
                setState(() {
                  
                  if(newAcc){
                    heightNewAcc = 0;
                    visibleSenha2 = false;
                  } else {
                    heightNewAcc = 90;
                    //newAcount = false;
                  }
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  // if(newAcc)
                  //   createUserLogin();
                  // else
                  //   login();
                });
              },
                heroTag: "login",
              label: Text("Login", style: TextStyle(color: Colors.white)),
              backgroundColor: primaryColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: TextButton(
              onPressed: () {
                showInSnackBar("Aguarde as atualizações");
              },
              child: Text(
                "Esqueceu a senha?",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: terciaryColor,
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