import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {

  final String title;
  final Color color;
  final Function onPressed;

  const RoundedButton(this.title, this.color, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Material(
        elevation: 5,
        color:color,
        borderRadius: BorderRadius.circular(30),
        child: MaterialButton(
          minWidth: 200,
          height: 50,
          onPressed: onPressed(),
          //     () {
          //   // Navigator.pushNamed(context, RegistrationScreen.id);
          // },
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1,
              fontFamily: 'SourceSansPro',
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
