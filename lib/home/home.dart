import 'package:final_project/card/CartPage.dart';
import 'package:final_project/home/Search.dart';
import 'package:final_project/category/categoryData.dart';
import 'package:final_project/home/recomendation.dart';
import 'package:final_project/profile/Profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 0,
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage()),
                  );
                },
                icon: Icon(
                  Icons.local_grocery_store_rounded,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
            },
            icon: Icon(Icons.person, size: 32, color: Colors.white),
          ),
        ],

        //-----------------------------------------------------------------------
        title: Text(
          "Hello Mohamamd",
          style: GoogleFonts.aBeeZee(
            fontWeight: FontWeight.bold,
            color: Color(0xFF27214D),
          ),
        ),
        backgroundColor: Color(0xFFFFA451),
      ),
      body: Container(
        color: Color.fromARGB(255, 245, 243, 241),
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(16),
        child: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          SizedBox(height: 12),
          SeachInput(),

          SizedBox(height: 32),
          Center(
            child: Text(
              "Recomendation",
              style: GoogleFonts.aBeeZee(
                fontSize: 28,
                color: Color(0xff27214D),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 16),
          Recomendation(),
          SizedBox(height: 32),
          Center(
            child: Text(
              "Category",
              style: GoogleFonts.aBeeZee(
                fontSize: 28,
                color: Color(0xff27214D),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          CategorySection(),
        ],
      ),
    );
  }
}

//--------------------------------------------------------------------------------------
//// Search Input text.....
class SeachInput extends StatefulWidget {
  SeachInput({super.key});

  @override
  _TextViewEx createState() => _TextViewEx();
}

class _TextViewEx extends State<SeachInput> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: TextFormField(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchBox()),
          );
        },
        onChanged: (value) {},
        controller: search,
        decoration: InputDecoration(
          border: InputBorder.none, // Removes underline
          fillColor: Color.fromARGB(255, 237, 233, 226),
          filled: true,
          hint: Text(
            "Search for product...",
            style: GoogleFonts.aBeeZee(fontSize: 14, color: Color(0xff86869E)),
          ),
          prefixIcon: Icon(Icons.search),
          prefixIconColor: Color(0xff86869E),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Color(0xFFFFA451), width: 2.0),
          ),
        ),
      ),
    );
  }
}

//--------------------------------------------------------------------------------------
//// Category Section .....
class CategorySection extends StatefulWidget {
  CategorySection({super.key});

  @override
  _CategoryItems createState() => _CategoryItems();
}

class _CategoryItems extends State<CategorySection> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          SizedBox(height: 16),

          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                child: Card(
                  color: Colors.white,
                  shadowColor: Color.fromARGB(255, 213, 207, 207),
                  elevation: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        categoryImages[index],
                        width: double.infinity,
                        height: 120,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 8),
                      Text(
                        categoryNames[index],
                        style: GoogleFonts.aBeeZee(
                          fontSize: 18,
                          color: Color(0xFFFFA451),

                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  clickedCategory = index;
                  Navigator.pushNamed(context, '/categoryshow');
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
