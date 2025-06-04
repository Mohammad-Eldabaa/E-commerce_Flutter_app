import 'dart:convert';
import 'dart:io';

import 'package:final_project/auth/registration.dart';
import 'package:final_project/classes/user.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  void saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  @override
  Widget build(BuildContext context) {
    UserLogin userLogin = UserLogin();
    void showSnakeBar(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), duration: Duration(seconds: 2)),
      );
    }

    // post request
    void sendData() async {
      try {
        final url = Uri.parse('https://ib.jamalmoallart.com/api/v2/login');

        final response = await http.post(
          url,
          headers: {'Content-Type': "application/json"},
          body: jsonEncode({
            'email': userLogin.getEmail,
            'password': userLogin.getPassword,
          }),
        );

        if (response.statusCode == 200) {
          final body = jsonDecode(response.body);
          UserData userData = UserData();
          userData.setUserData = body['data'];
          saveToken(body['data']['token']);
          showSnakeBar(body['message']);
          Navigator.pushReplacementNamed(context, '/homescreen');
        } else {
          final body = jsonDecode(response.body);
          print('now Failed with status: $response');
          showSnakeBar(body['message']);
        }
      } catch (e) {
        print("now error appera;");
        print(e.toString());
      }
    }

    // submit function
    void submit() {
      if (_formKey.currentState!.validate() ?? false) {
        sendData();
      }
    }

    return Expanded(
      child: ListView(
        children: [
          SizedBox(height: 150),
          Center(
            child: Text(
              "Login Page",
              style: TextStyle(
                color: Color(0xFFFFA451),
                fontSize: 48,
                shadows: [
                  Shadow(
                    offset: Offset(5, 5), // X, Y position
                    blurRadius: 4.0, // Softness of the shadow
                    color: const Color.fromARGB(
                      255,
                      226,
                      224,
                      224,
                    ), // Shadow color
                  ),
                ],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 30),
                TextExample(
                  "mohammad123@gmail.com",
                  "Your email.",
                  "Email",
                  TextInputType.emailAddress,
                ),

                SizedBox(height: 30),
                TextExample(
                  "************",
                  "Your Password.",
                  "Password",
                  TextInputType.visiblePassword,
                ),
              ],
            ),
          ),

          SizedBox(height: 60),
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFA451),
                  ),
                  child: Text(
                    "Log in",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/registration');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFA451),
                  ),
                  child: Text(
                    "Registration",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//------------------------------------------------------------------
class TextExample extends StatefulWidget {
  String? hint;
  String? label;
  String? viewName;
  TextInputType? textinputtype;
  TextExample(
    this.hint,
    this.label,
    this.viewName,
    this.textinputtype, {
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _TextViewEx createState() => _TextViewEx(
    hint: hint,
    label: label,
    viewName: viewName,
    textinputtype: textinputtype,
  );
}

class _TextViewEx extends State<TextExample> {
  String? hint;
  String? label;
  String? viewName;
  TextInputType? textinputtype;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  _TextViewEx({this.hint, this.label, this.viewName, this.textinputtype});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: viewName == "Email" ? email : password,
      onChanged: (value) {
        UserLogin userLogin = UserLogin();
        setState(() {
          viewName == "Email"
              ? userLogin.setEmail = value
              : userLogin.setPassword = value;
        });
      },
      keyboardType: textinputtype,
      obscureText: viewName == "Password",
      decoration: InputDecoration(
        border: InputBorder.none, // Removes underline
        fillColor: Colors.white,
        filled: true,
        hintText: hint,
        label: Text(label.toString()),
        prefixIcon: viewName == "Password"
            ? Icon(Icons.lock)
            : viewName == "Email"
            ? Icon(Icons.email)
            : Icon(Icons.text_fields),
        prefixIconColor: Color(0xFFFFA451),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Color(0xFFFFA451), width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Color(0xFFFFA451), width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your $viewName ....";
        }

        switch (viewName) {
          case "Password":
            if (value.length < 6) {
              return "Password must contain at least 6 character.";
            }
            break;
          case "Email":
            if (!RegExp(r"^[^@]+@[^@]+\.[^@]+").hasMatch(value)) {
              return "Please enter a valid email. ..";
            }
            break;
        }

        return null;
      },
    );
  }
}
