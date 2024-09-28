import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_app/home_page.dart'; // Replace with your home screen file

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
bool _obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

   _signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        // User is logged in! Navigate to the next page.
        Navigator.pushReplacementNamed(context, '/productpage'); // Replace current route
      } else {
        // Show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid credentials'),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase errors (e.g., wrong credentials, user not found)
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      // Show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(
          content: Text('Wrong username or password'),
        ),
      );
    } catch (e) {
      // Catch other errors
      print('Error during login: ${e.toString()}');
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(
          content: Text('An error occurred'),
        ),
      );
    }
  }

  // Future<void> _signInWithEmailAndPassword() async {
  //   if (_formKey.currentState!.validate()) {
  //     try {
  //       // Show a progress indicator while signing in
  //       showDialog(
  //         context: context,
  //         barrierDismissible: false,
  //         builder: (BuildContext context) {
  //           return Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         },
  //       );

  //       await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: _emailController.text.trim(),
  //         password: _passwordController.text.trim(),
  //       );

  //       // Close the progress indicator
  //       Navigator.of(context).pop();

  //       // Navigate to the home screen
  //       Navigator.pushReplacementNamed(context, '/productpage');
  //     } catch (e) {
  //       print('Failed to sign in: ${e.toString()}');
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Failed to sign in. Please check your credentials.')),
  //       );
  //     } finally {
  //       // Close the progress indicator in case of an error
  //       Navigator.pushReplacementNamed(context, '/productpage');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(
        iconTheme: IconThemeData( color: Colors. white,),
        backgroundColor: const Color.fromARGB(255, 24, 111, 182),
        title: Text('Login',style: TextStyle(color: Colors.white),),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(                        
                controller: _emailController,
                decoration: InputDecoration(  
                   focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
            ),              
                   prefixIcon: Icon(Icons.mail_outline),
                  enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),),
                  labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              TextFormField(
                 obscureText: _obscureText,
                controller: _passwordController,
                //obscureText: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
            ),              
                   prefixIcon: Icon(Icons.password),
                  enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),),
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText; // Toggle visibility
                      });
                    },
                  )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              ElevatedButton(
                 style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: (){
                  if (_formKey.currentState!.validate()) {
                    _signInWithEmailAndPassword(
                        _emailController.text, _passwordController.text);
                  }
                },
                child: Text('Login',style: TextStyle(color: Colors.white),),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // Navigate to the sign-up page
                  Navigator.pushReplacementNamed(context, '/signup'); 
                },
                child: Text('Don\'t have an account? Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}