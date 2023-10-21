import 'package:flutter/material.dart';
import '../utils/const.dart';
import '../utils/function.dart';
import 'register.dart';

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  // Create controllers for the text fields
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.darkGreen,
        title: Text('FYP Atiqah'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Your logo or image
                Image.asset('assets/icons/logo.png', width: 150, height: 150),
                SizedBox(height: 20),

                // Email Text Field
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                        color: Colors.black
                    ),
                    labelText: 'Email',
                  ),
                ),
                SizedBox(height: 10),

                // Password Text Field
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: Colors.black
                    ),
                    labelText: 'Password',
                  ),
                  obscureText: true, // Hide the password
                ),
                SizedBox(height: 20),

                // Login Button
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   ElevatedButton(
                     style: ElevatedButton.styleFrom(primary: Constants.darkGreen,),
                     onPressed: () async{
                       // Handle login logic here
                       final email = emailController.text;
                       final password = passwordController.text;

                       var data = {
                         "email": email,
                         "password": password
                       };
                       print("xxxxxxxxx");
                       print(data);
                       print("xxxxxxx");
                       await logInAccess(context,"login",data);

                       // Validate and process login

                       // For demonstration purposes, we'll just print the values
                       print('Email: $email');
                       print('Password: $password');
                     },
                     child: Text('Login',style: TextStyle(fontWeight: FontWeight.bold),),
                   ),
                   ElevatedButton(
                     style: ElevatedButton.styleFrom(primary: Constants.darkGreen,),
                     onPressed: () {
                       Navigator.push(
                           context,
                           MaterialPageRoute(
                               builder: (context) =>
                                 RegisterPage()));

                     },
                     child: Text('Register',style: TextStyle(fontWeight: FontWeight.bold),),
                   ),
                 ],
               ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
