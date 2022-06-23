import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:outings/screens/calendar.dart';
import 'package:outings/screens/createTaskScreen.dart';
import 'package:outings/screens/home.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:outings/screens/logIn.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:outings/utils.dart';

import 'screens/signUp.dart';





void main() async {
  AwesomeNotifications().initialize(
    null, 
    [
      NotificationChannel(channelKey: 'Its time', channelName: 'Its time notification' , 
      channelDescription: 'Notification that shows when its time for the task to be done', 
      enableVibration: true, 
      defaultColor: ColorList[Random().nextInt(ColorList.length)],
      ), 
      
    ]);

   

  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final currentUser =  FirebaseAuth.instance.currentUser;
  
  await initializeDateFormatting().then((_){ //underscore means context
    if(currentUser == null){
     return runApp(const MyApp());
    }else{
      return runApp(MaterialApp(home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        'home': (_)=> HomeScreen(), 
        'logIn': (_)=> LogInScreen(), 
        'signUp': (_)=> SignUpScreen(),
        'calendar': (_)=> CalendarScreen(), 
        
      }));
    }
    }
  );
  
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      initialRoute: 'logIn', 
      routes: {
        'home': (_)=> HomeScreen(), 
        'logIn': (_)=> LogInScreen(), 
        'signUp': (_)=> SignUpScreen(),
        'calendar': (_)=> CalendarScreen(), 
        
      }
          );
  }
}

