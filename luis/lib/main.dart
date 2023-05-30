import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luis/home.dart';
import 'createAccount.dart';
import 'login.dart';
import 'profile.dart';
import 'list.dart';

void main(){
  int _currentIndex = 0;
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: login(),
      initialRoute: "/",
    routes: {
        "/home": (context) => home(),
        "/login": (context) => login(),
        "/list": (context) => list(),
        "/profile": (context) => profile(),
    },

  )
  );
}