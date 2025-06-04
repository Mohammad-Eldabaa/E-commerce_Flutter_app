import 'package:final_project/card/cardData.dart';
import 'package:final_project/classes/getproducts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  PurchaseCard cart = PurchaseCard();

  void _increment(Product product) {
    setState(() {
      product.stock++;
    });
  }

  void _decrement(Product product) {
    setState(() {
      if (product.stock > 1) {
        product.stock--;
      } else {
        cart.removeProduct(product);
      }
    });
  }

  void _remove(Product product) {
    setState(() => cart.removeProduct(product));
  }

  void _placeOrder() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("The payment done!"),
        content: Text("Thank you for your purchase."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => cart.clearCard());
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    PurchaseCard cart = PurchaseCard();

    final products = cart.card;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart",
          style: GoogleFonts.aBeeZee(
            fontWeight: FontWeight.bold,
            color: Color(0xFF27214D),
          ),
        ),
      ),
      body: products.isEmpty
          ? Center(
              child: Text(
                "Your cart is empty",
                style: GoogleFonts.aBeeZee(
                  fontSize: 32,
                  color: Color(0xFFFFA451),
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ListTile(
                        leading: Image.network(
                          product.image,
                          width: 50,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.broken_image,
                              size: 50,
                              color: Color.fromARGB(255, 247, 191, 139),
                            );
                          },
                        ),
                        title: Text(product.name),
                        subtitle: Text("\$${product.price} x "),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              color: Color(0xFFFFA451),
                              onPressed: () => _decrement(product),
                            ),
                            Text(
                              product.stock.toString(),
                              style: TextStyle(fontSize: 16),
                            ), //{product.quantity}
                            IconButton(
                              icon: Icon(Icons.add),
                              color: Color(0xFFFFA451),
                              onPressed: () => _increment(product),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () => _remove(product),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Text(
                          "Total: \$${cart.totalPrice()}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _placeOrder();
                          },
                          icon: const Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                          ),
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
