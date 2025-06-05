import 'dart:convert';
import 'dart:io';

import 'package:final_project/classes/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// import 'package:image_picker/image_picker.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, backgroundColor: Color(0xFFFFA451)),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(16), // ✅ Fixed here
        child: Column(
          children: [
            Registration(), // or Registration(),
          ],
        ),
      ),
    );
  }
}

class Registration extends StatefulWidget {
  Registration({super.key});

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  File? _avatar;

  Future<void> pickImage() async {
    // final pickedFile = await ImagePicker().pickImage(
    //   source: ImageSource.gallery,
    // );
    // if (pickedFile != null) {
    //   setState(() {
    //     _avatar = File(pickedFile.path);
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    UserRegister userRegister = UserRegister();

    void showSnakeBar(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), duration: Duration(seconds: 2)),
      );
    }

    void registerRequest() async {
      try {
        final url = Uri.parse("https://ib.jamalmoallart.com/api/v2/register");

        final response = await http.post(
          url,
          headers: {'Content-Type': "application/json"},
          body: jsonEncode({
            "first_name": userRegister.firstName,
            "last_name": "user",
            "phone": userRegister.phone,
            "address": userRegister.address,
            "email": userRegister.email,
            "password": userRegister.password,
          }),
        );

        final body = await jsonDecode(response.body);
        print("now $body");

        if (response.statusCode == 200) {
          showSnakeBar(body['message']);
          print('now Success: $body');
        } else {
          showSnakeBar(body['data']);
          print('now Failed: $body');
        }
      } catch (e) {
        print("now Exception: ${e.toString()}");
      }
    }

    void submit() {
      if (_formKey.currentState!.validate() ?? false) {
        registerRequest();
        print("now submit");
      }
    }

    return Expanded(
      child: ListView(
        children: [
          Center(
            child: Text(
              "Registration",
              style: TextStyle(
                color: Color(0xFFFFA451),
                fontSize: 48,
                shadows: [
                  Shadow(
                    offset: Offset(5, 5), // X, Y position
                    blurRadius: 4.0, // Softness of the shadow
                    color: Color.fromARGB(255, 226, 224, 224), // Shadow color
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
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Color.fromARGB(255, 239, 237, 237),
                        backgroundImage: _avatar != null
                            ? FileImage(_avatar!)
                            : null,
                        child: _avatar == null
                            ? Icon(
                                Icons.person,
                                size: 50,
                                color: Color(0xFFFFA451),
                              )
                            : null,
                      ),
                      CircleAvatar(
                        backgroundColor: Color(0xFFFFA451),
                        radius: 20,
                        child: IconButton(
                          onPressed: pickImage,
                          icon: Icon(
                            Icons.camera_alt,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                TextExample(
                  "mohammad",
                  "Your name.",
                  "Name",
                  TextInputType.name,
                ),
                SizedBox(height: 30),
                TextExample(
                  "mohammad123@gmail.com",
                  "Your email.",
                  "Email",
                  TextInputType.emailAddress,
                ),

                SizedBox(height: 30),
                TextExample(
                  "0101234567",
                  "Your phone.",
                  "Phone",
                  TextInputType.phone,
                ),

                SizedBox(height: 30),
                TextExample(
                  "************",
                  "Your Password.",
                  "Password",
                  TextInputType.visiblePassword,
                ),

                SizedBox(height: 30),
                TextExample(
                  "************",
                  "Confirm Password.",
                  "Password",
                  TextInputType.visiblePassword,
                ),
                SizedBox(height: 30),
                TextExample(
                  "Garbia,Tanta",
                  "Address",
                  "",
                  TextInputType.visiblePassword,
                ),
              ],
            ),
          ),

          SizedBox(height: 30),
          DatePickerDialogExample(),
          // DatePickerDialogExample(),
          // DatePickerDialog(
          //   firstDate: DateTime(2022, 2, 2),
          //   lastDate: DateTime(2025, 12, 31),
          // ),
          SizedBox(height: 40),
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
                    "Register",
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
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFA451),
                  ),
                  child: Text(
                    "Back to login",
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

  _TextViewEx({this.hint, this.label, this.viewName, this.textinputtype});

  @override
  Widget build(BuildContext context) {
    TextEditingController firstName = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController address = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    UserRegister userRegister = UserRegister();

    return TextFormField(
      controller: viewName == "Name"
          ? firstName
          : viewName == "Password"
          ? password
          : viewName == "Email"
          ? email
          : viewName == "Phone"
          ? phone
          : address,
      keyboardType: textinputtype,
      onChanged: (value) {
        viewName == "Name"
            ? userRegister.firstName = value
            : viewName == "Password"
            ? userRegister.password = value
            : viewName == "Email"
            ? userRegister.email = value
            : viewName == "Phone"
            ? userRegister.phone = value
            : userRegister.address = value;
      },
      obscureText: viewName == "Password",
      decoration: InputDecoration(
        border: InputBorder.none, // Removes underline
        fillColor: Colors.white,
        filled: true,
        hintText: hint,
        label: Text(label.toString()),
        prefixIcon: viewName == "Name"
            ? Icon(Icons.person)
            : viewName == "Password"
            ? Icon(Icons.lock)
            : viewName == "Email"
            ? Icon(Icons.email)
            : viewName == "Phone"
            ? Icon(Icons.phone)
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
          case "Name":
            if (value.length < 4) {
              return "name must contain at least 4 character.";
            }
            break;
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
          case "Phone":
            if (value.length != 11) {
              return "{Please enter valid phone number.";
            }
            break;
        }

        return null;
      },
    );
  }
}

//// ----------date input

// DatePickerDialog

class DatePickerDialogExample extends StatefulWidget {
  DatePickerDialogExample({super.key});

  @override
  _DatePickerDialogExampleState createState() =>
      _DatePickerDialogExampleState();
}

class _DatePickerDialogExampleState extends State<DatePickerDialogExample> {
  TextEditingController dateController = TextEditingController();

  DateTime? _selectedDate;
  TextInputType? textinputtype;

  Future<void> _openDatePickerDialog() async {
    final DateTime? pickedDate = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          initialDate: _selectedDate ?? DateTime.now(),
          firstDate: DateTime(1980),
          lastDate: DateTime.now(),
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        dateController.text = pickedDate.toString().substring(0, 10);
      });
    }
  }

  //******************************************************************* */
  @override
  Widget build(BuildContext context) {
    // final dateText = _selectedDate == null
    //     ? 'No date selected'
    //     : 'Selected: ${_selectedDate!.toLocal()}'.split(' ')[0];

    return TextFormField(
      controller: dateController,
      decoration: InputDecoration(
        border: InputBorder.none, // Removes underline
        fillColor: Colors.white,
        filled: true,
        suffixIcon: IconButton(
          onPressed: () {
            _openDatePickerDialog();
          },
          icon: Icon(Icons.data_exploration, color: Color(0xFFFFA451)),
        ),
        // hintText: "you date birth",
        label: Text("Enter you date"),
        prefixIcon: Icon(Icons.date_range),
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
          return "Please enter your Date....";
        }
        return null;
      },
    );
  }
}
