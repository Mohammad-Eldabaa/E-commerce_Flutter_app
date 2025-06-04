import 'package:final_project/card/cardData.dart';
import 'package:final_project/category/categoryData.dart';
import 'package:final_project/classes/getproducts.dart';
import 'package:final_project/product/showProduct.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Recomendation extends StatefulWidget {
  const Recomendation({super.key});

  @override
  _RecomendationState createState() => _RecomendationState();
}

class _RecomendationState extends State<Recomendation> {
  List<Product> allProduct = [];
  void getdata() async {
    List<Product> data = await fetchAllProducts();
    // print(data.length);

    setState(() {
      allProduct = data;
    });
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PurchaseCard purchaseCard = PurchaseCard();

    void showSnakeBar(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), duration: Duration(seconds: 2)),
      );
    }

    return SizedBox(
      height: 220,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: allProduct.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 8,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Showproduct(product: allProduct[index]),
                ),
              );
            },
            child: SizedBox(
              width: 180,
              child: Card(
                elevation: 4,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      allProduct[index].image,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.broken_image,
                          size: 100,
                          color: Color.fromARGB(255, 247, 191, 139),
                        );
                      },
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 8),
                    Text(
                      allProduct[index].name,
                      style: GoogleFonts.aBeeZee(
                        fontSize: 16,
                        color: Color(0xFFFFA451),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.attach_money, color: Color(0xFFFFA451)),
                            Text(
                              allProduct[index].price.toString(),

                              style: TextStyle(
                                color: Color(0xFFFFA451),
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 48,
                          width: 48,
                          child: Card(
                            color: Color(0xFFFFF2E7),
                            child: IconButton(
                              onPressed: () {
                                purchaseCard.addProduct(allProduct[index]);
                                showSnakeBar("Product added succesfully");
                              },
                              iconSize: 24,
                              icon: Icon(Icons.add, color: Color(0xFFFFA451)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
