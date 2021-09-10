import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat_app/screens/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'register_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final  _auth = FirebaseAuth.instance;
  String email = '';
  String password='';
  bool showSpinner = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.only(top: 30, bottom: 30, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Hero(
                  tag: 'logo',
                  child: Center(
                    child: Image.asset('images/Flash.jpg'),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          //textAlign: TextAlign.center,
                          onChanged: (value){
                            email=value;
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), hintText: 'Enter your email'),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        flex: 1,
                        child: TextField(
                          obscureText: true,
                          onChanged: (value){
                            password = value;
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter your password'),
                        ),
                      ),
                    ],
                  ),
                ),
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
                    onPressed: () async{
                     setState(() {
                       showSpinner = true;
                     });
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                    try{
                      future: Firebase.initializeApp();
                      final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                      if(newUser != null){
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    }catch(e){
                      print(e);
                    }

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
        ),
      ),
    );
  }
}
