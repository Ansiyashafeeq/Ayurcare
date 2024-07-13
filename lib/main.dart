import 'package:ayur_centre/providers/login_provider.dart';
import 'package:ayur_centre/providers/patientlist_provider.dart';
import 'package:ayur_centre/screens/home_screen.dart';
import 'package:ayur_centre/screens/login_screen.dart';
import 'package:ayur_centre/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => LoginProvider()),
        ChangeNotifierProvider(create: (ctx) => PatientListProvider()),
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
