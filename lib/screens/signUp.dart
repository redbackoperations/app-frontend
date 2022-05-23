// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // our form key
  final _formKey = GlobalKey<FormState>();
  //here we declare the field variables that will be used in the signup
  late var firstNameField;
  late var secondNameField;
  late var emailField;
  late var passwordField;
  late var userNameField;
  late var mobileField;
  late var emptyfollowers = '';
  late var emptyfollowing = '';
  late var emptyimg = '';

  //below are our text editing controllers for each field
  final firstNameEditingController = new TextEditingController();
  final secondNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();
  final userNameEditingController = new TextEditingController();
  final mobileNumberEditingController = new TextEditingController();

  //creating a http client that can use the different api requests
  var client = http.Client();

  //This function makes a post request to the server and signup endpoint and passes a
  //body of values taken from the signup form
  Future<void> postData() async {
    // var test = jsonEncode({
    //   "username": userNameEditingController.text,
    //   "firstname": firstNameEditingController.text,
    //   "lastname": secondNameEditingController.text,
    //   "email": emailEditingController.text,
    //   "password": passwordEditingController.text,
    //   "redbackCoins": 0,
    //   "telephone": int.parse(mobileNumberEditingController.text),
    //   "userLevel": 0,
    //   "followers": "",
    //   "following": "",
    //   //"__v": 0.toString(),
    //   "img": ""
    // });
    // print(test);
    try {
      var response = await client.post(Uri.parse('http://10.0.2.2:8080/signup'),
          headers: {"Content-Type": "application/json; charset=utf-8"},
          body: jsonEncode({
            "username": userNameEditingController.text,
            "firstname": firstNameEditingController.text,
            "lastname": secondNameEditingController.text,
            "email": emailEditingController.text,
            "password": passwordEditingController.text,
            "redbackCoins": 0,
            "telephone": int.parse(mobileNumberEditingController.text),
            "userLevel": 0,
            "followers": "",
            "following": "",
            "img": ""
          }));
      print(response.body);
      client.close();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    //first name field
    firstNameField = TextFormField(
        autofocus: false,
        controller: firstNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("First Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          fillColor: const Color(0xFFe87461),
          filled: true,
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //last name field
    secondNameField = TextFormField(
        autofocus: false,
        controller: secondNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Last Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          fillColor: const Color(0xFFe87461),
          filled: true,
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Last Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //email field
    emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          fillColor: const Color(0xFFe87461),
          filled: true,
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //password field
    passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: true,
        textInputAction: TextInputAction.next,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        decoration: InputDecoration(
          fillColor: const Color(0xFFe87461),
          filled: true,
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //confirm password field
    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        textInputAction: TextInputAction.done,
        obscureText: true,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "Password don't match";
          }
          return null;
        },
        decoration: InputDecoration(
          fillColor: const Color(0xFFe87461),
          filled: true,
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0x00e87461)),
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //username field
    userNameField = TextFormField(
        autofocus: false,
        controller: userNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("First Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          fillColor: const Color(0xFFe87461),
          filled: true,
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "User Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //phone number field
    mobileField = TextFormField(
        autofocus: false,
        controller: mobileNumberEditingController,
        keyboardType: TextInputType.number,
        validator: (value) {
          RegExp regex = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
          if (value!.isEmpty) {
            return ("Mobile number cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid number");
          }
          return null;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          fillColor: const Color(0xFFe87461),
          filled: true,
          prefixIcon: const Icon(Icons.phone),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Phone number",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //signup button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: const Color(0xFFe87461),
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          //calls the function to post data to database
          onPressed: postData,
          child: const Text(
            "Sign Up",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          )),
    );

    return Scaffold(
      //backgroundColor: Color(0xe87461),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(56, 14, 74, 1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFe87461)),
          onPressed: () {
            //passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: const Color.fromRGBO(56, 14, 74, 1),
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //Image.asset('assets/images/Logo.png'),
                    SizedBox(
                        height: 180,
                        //image logo
                        child: Image.asset(
                          'assets/images/BLogo.png',
                          fit: BoxFit.contain,
                        )),
                    const SizedBox(height: 45),
                    firstNameField,
                    const SizedBox(height: 20),
                    secondNameField,
                    const SizedBox(height: 20),
                    emailField,
                    const SizedBox(height: 20),
                    passwordField,
                    const SizedBox(height: 20),
                    confirmPasswordField,
                    const SizedBox(height: 20),
                    userNameField,
                    const SizedBox(height: 20),
                    mobileField,
                    const SizedBox(height: 20),
                    signUpButton,
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String text, String text2) {}
}
