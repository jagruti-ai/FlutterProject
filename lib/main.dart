import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterapp_task/HomePage.dart';
import 'package:flutterapp_task/SignUpPage.dart';
import 'package:flutterapp_task/loginpage.dart';
import 'package:flutterapp_task/productfilterpage.dart';
import 'package:flutterapp_task/productlistpage.dart';
//import 'package:flutterapp_task/productlistpage.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(apiKey: "AIzaSyCL-pSr2xVQ3GOtCa7AOCYiWxFPC8o597I", appId: "1:291027720258:android:7f771a100bd31ba77c75db", 
     projectId: "logintask-fc0f6", storageBucket: "logintask-fc0f6.appspot.com", messagingSenderId: '')
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => FirstScreen(),
//       '/': (context) => SignUpPage(),  //  Initial route is the signup page 
        '/login': (context) => LoginPage(), // Your login screen
       '/productpage': (context) => ProductListPage(),
       '/filterpage': (context) =>  ProductFilterPage(),
       '/signup': (context) => SignUpPage()
       

        }
     // home:SignUpPage()
      // HomePage()
      //const LoginPage()
      // HomePage()
      //const LoginPage(),
      //const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

