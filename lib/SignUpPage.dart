import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();


  bool _passwordVisible1 = false; // For the first password field
  bool _passwordVisible2 = false; 
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signUpWithEmailAndPassword() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }

      try {
         showDialog(
          context: context,
          barrierDismissible: false, // Prevent dismissing by tapping outside
          builder: (BuildContext context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        );
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        // Optionally, send a verification email:
        // await FirebaseAuth.instance.currentUser!.sendEmailVerification();
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Verification email sent')),
        // );

        // Navigate to the home screen or another appropriate screen
              Navigator.of(context).pop();
        // Show success dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Signup Successful'),
              content: Text('You have successfully signed up!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); 
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );

      } catch (e) {
        print('Failed to sign up: ${e.toString()}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to sign up. Please check your credentials.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        title: Text('Sign Up',style: TextStyle(color: Colors.white)),
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
                   prefixIcon: Icon(Icons.email),
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
              SizedBox(height: 16),
              TextFormField(
                obscureText: !_passwordVisible1,
                controller: _passwordController,
               // obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                   focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
            ),              
                   prefixIcon: Icon(Icons.password),
                  enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),),
                suffixIcon: IconButton(
      onPressed: () {
        setState(() {
          _passwordVisible1 = !_passwordVisible1; // Toggle visibility
        });
      },
      icon: Icon(
        _passwordVisible1 ? Icons.visibility : Icons.visibility_off,
      ),
    ),
    ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                obscureText: !_passwordVisible2,
                controller: _confirmPasswordController,
               
                decoration: InputDecoration(
                   focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
            ),              
                   prefixIcon: Icon(Icons.password),
                  enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),),
                  labelText: 'Confirm Password',
                suffixIcon: IconButton(
      onPressed: () {
        setState(() {
          _passwordVisible2 = !_passwordVisible2; // Toggle visibility
        });
      },
      icon: Icon(
        _passwordVisible2 ? Icons.visibility : Icons.visibility_off,
      ),
    ),
    ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  setState(() {
                });

                  return null;
                },
              ),
              SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: _signUpWithEmailAndPassword,
                child: Text('Sign Up', style: TextStyle(color: Colors.white),),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                   FirebaseAuth.instance.signOut().then((_){
                  // Navigate to the login page
                  Navigator.pushReplacementNamed(context, '/login');  
                });
                },
                child: Text('Already have an account? Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


