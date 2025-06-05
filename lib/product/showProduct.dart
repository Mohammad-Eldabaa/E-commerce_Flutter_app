import 'package:final_project/card/cardData.dart';
import 'package:final_project/classes/getproducts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Showproduct extends StatefulWidget {
  final Product product;

  Showproduct({super.key, required this.product});

  @override
  State<Showproduct> createState() => _ShowproductState();
}

class _ShowproductState extends State<Showproduct> {
  void addProductToCart() {
    setState(() {
      PurchaseCard().addProduct(widget.product);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Product added to cart'),
        duration: Duration(milliseconds: 1000),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          product.name,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFA451),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.image,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.broken_image,
                    size: 200,
                    color: Color.fromARGB(255, 247, 191, 139),
                  );
                },
              ),
            ),
            SizedBox(height: 50),
            SizedBox(height: 20),
            Text(
              product.description,
              style: TextStyle(fontSize: 22, color: Color(0xff27214D)),
            ),
            SizedBox(height: 20),
            Text(
              product.price.toStringAsFixed(2),
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: Color(0xFFFFA451),
                  child: IconButton(
                    icon: Icon(Icons.remove),
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        if (product.stock > 1) {
                          product.stock--;
                        } else {
                          PurchaseCard().removeProduct(product);
                        }
                      });
                    },
                  ),
                ),
                Card(
                  color: Colors.white,
                  shadowColor: Colors.transparent,
                  margin: EdgeInsets.all(16),
                  child: Text(
                    product.stock.toString(),
                    style: TextStyle(fontSize: 32),
                  ),
                ),
                Card(
                  color: Color(0xFFFFA451),
                  child: IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        PurchaseCard().addProduct(widget.product);
                      });
                    },
                  ),
                ),
              ],
            ),
            Spacer(),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: addProductToCart,
                icon: Icon(Icons.add_shopping_cart, color: Colors.white),
                label: Text(
                  'Add to Cart',
                  style: GoogleFonts.aBeeZee(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFA451),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
