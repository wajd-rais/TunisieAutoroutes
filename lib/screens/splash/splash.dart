import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:tunisie_autoroutes/NavBar/NavBar.dart';
import 'package:tunisie_autoroutes/providers/locationProvider.dart';
import 'package:tunisie_autoroutes/screens/login-register/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
    @override
  void initState() {
    Timer(
        Duration(
          seconds: 2,
        ), () async {
      final locationData =
      Provider.of<LocationProvider>(context, listen: false);
      LocationPermission permission;
      permission = await Geolocator.requestPermission();
      await locationData.getCurrentPosition();
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          Navigator.of(context).push(PageRouteBuilder(
              transitionDuration: Duration.zero,
              pageBuilder: (context, animation, secondaryAnimation) =>
                  loginScreen()));
        } else {
            Navigator.of(context).push(PageRouteBuilder(
              transitionDuration: Duration.zero,
              pageBuilder: (context, animation, secondaryAnimation) =>
                  navBar()));
        }
      });
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            "assets/images/Tunisie_autouroutes.png",
            width: MediaQuery.of(context).size.width * 0.9,
          ),
          SizedBox(
            height: 20,
          ),
         
        ]),
      ),
    );
  }
}