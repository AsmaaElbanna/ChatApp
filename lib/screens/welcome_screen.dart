import 'package:flash_chat_app/rounded_button.dart';
import 'package:flash_chat_app/screens/login_screen.dart';
import 'package:flash_chat_app/screens/registration_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.only(top: 30, bottom: 30, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Hero(
                      tag: 'logo',
                      child: Image.asset('images/Flash.jpg'),

                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Flash Chat_',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Material(
                  elevation: 5,
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(30),
                  child: MaterialButton(
                    minWidth: 200,
                    height: 50,
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1,
                        fontFamily: 'SourceSansPro',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              // RoundedButton('Register', Colors.amberAccent, (){
              // Navigator.pushNamed(context, RegistrationScreen.id);
              // }),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Material(
                  elevation: 5,
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(30),
                  child: MaterialButton(
                    minWidth: 200,
                    height: 50,
                    onPressed: () {
                      Navigator.pushNamed(context, RegistrationScreen.id);
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1,
                        fontFamily: 'SourceSansPro',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

/*
 Card(
                color: Colors.lightBlue,
                margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: ListTile(
                  title:
                  Text(
                    'login',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1,
                      fontFamily: 'SourceSansPro',
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
 */
