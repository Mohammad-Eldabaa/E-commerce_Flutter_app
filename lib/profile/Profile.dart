import 'package:final_project/classes/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = "";
  String address = "";
  String email = "";
  String phone = "";
  @override
  void initState() {
    super.initState();
    setState(() {
      UserData userData = UserData();
      name = userData.name();
      address = userData.address;
      email = userData.email;
      phone = userData.phone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: GoogleFonts.aBeeZee(
            fontSize: 24,
            color: Color(0xFFFFA451),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=2'),
            ),
            SizedBox(height: 20),
            Text(
              name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Icon(Icons.email_outlined, color: Color(0xFFFFA451)),
                SizedBox(width: 10),
                Text(email, style: TextStyle(fontSize: 18)),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.phone, color: Color(0xFFFFA451)),
                SizedBox(width: 10),
                Text(phone, style: TextStyle(fontSize: 18)),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.home, color: Color(0xFFFFA451)),
                SizedBox(width: 10),
                Expanded(child: Text(address, style: TextStyle(fontSize: 18))),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFA451),
              ),
              child: Text(
                "Log out",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
