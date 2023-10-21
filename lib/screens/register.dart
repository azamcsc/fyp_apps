import 'package:flutter/material.dart';
import '../utils/const.dart';
import '../utils/function.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Create controllers for the text fields
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();



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
        title: Text('REGISTER'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Your logo or image
              //  Image.asset('assets/icons/logo.png', width: 150, height: 150),
                SizedBox(height: 20),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                        color: Colors.black
                    ),
                    labelText: 'Name',
                  ),
                ),
                SizedBox(height: 10),
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
                        final name = nameController.text;
                        final password = passwordController.text;
                        var data = {
                          "email": email,
                          "name": name,
                          "password": password,
                        };
                        // Validate and process login
                        await signUpAccess(context,"register",data);
                        // For demonstration purposes, we'll just print the values
                        print('Email: $email');
                        print('Password: $password');
                      },
                      child: Text('Submit',style: TextStyle(fontWeight: FontWeight.bold),),
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
