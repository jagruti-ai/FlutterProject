import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp_task/SignUpPage.dart';
import 'package:flutterapp_task/loginpage.dart';



class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 172, 205, 241),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Icon(Icons.person,size: 100,),
             SizedBox(height: 50,),
            // Add any other elements like title or logo here
             Text(
              'Welcome to our App!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            
 SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Navigate to login screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:  Colors.blue, // Background color
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Login', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to signup screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
                
              },
              
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Background color
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Signup', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 16),
              TextButton(
                onPressed: () {
                   FirebaseAuth.instance.signOut().then((_){
                  // Navigate to the login page
                  Navigator.pushReplacementNamed(context, '/login');  
                });
                },
                child: Text('Already have an account? Login'),
              ),
          ],
        ),
      ),
    );
  }
}

// // Placeholder screens for Login and Signup
// class LoginScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Login Screen')),
//       body: Center(
//         child: Text('Login Screen Content'),
//       ),
//     );
//   }
// }

// class SignupScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Signup Screen')),
//       body: Center(
//         child: Text('Signup Screen Content'),
//       ),
//     );
//   }
// }