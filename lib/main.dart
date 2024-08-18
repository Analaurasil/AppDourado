//import 'package:dealmaster/cadastro.dart';
//import 'package:dealmaster/login.dart';
import 'package:flutter/material.dart';
import 'package:dealmaster/formcontrato.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Color.fromRGBO(255, 151, 76, 1),
      scaffoldBackgroundColor: Colors.white,

      appBarTheme: AppBarTheme(
        color:  Color.fromRGBO(255, 151, 76, 1),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          //fontFamily: 
        ),
        iconTheme: IconThemeData(color: Colors.white),
        ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.0),
          borderSide: BorderSide(
            color: Color.fromRGBO(255, 151, 76, 1),
            width: 2.0,
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.0),
          borderSide: BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          ),
          backgroundColor: Color.fromRGBO(255, 151, 76, 1),
          foregroundColor: Colors.white,
          //padding: EdgeInsets.all(10),
          fixedSize: Size(200, 50),
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )
        )
        //styleFrom({Color? foregroundColor, Color? backgroundColor, Color? disabledForegroundColor, Color? disabledBackgroundColor, Color? shadowColor, Color? surfaceTintColor, Color? iconColor, Color? disabledIconColor, Color? overlayColor, double? elevation, TextStyle? textStyle, EdgeInsetsGeometry? padding, Size? minimumSize, Size? fixedSize, Size? maximumSize, BorderSide? side, OutlinedBorder? shape, MouseCursor? enabledMouseCursor, MouseCursor? disabledMouseCursor, VisualDensity? visualDensity, MaterialTapTargetSize? tapTargetSize, Duration? animationDuration, bool? enableFeedback,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black
        )
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.all(Color.fromRGBO(255, 151, 76, 1)),
        overlayColor: WidgetStateProperty.all(Color.fromRGBO(255, 151, 76, 0.7)),
        splashRadius: 10.0,
      )
    ),
    home: FormContrato()
  ));
}

