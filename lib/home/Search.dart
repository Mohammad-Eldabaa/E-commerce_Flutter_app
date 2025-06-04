import 'package:final_project/classes/getproducts.dart';
import 'package:final_project/product/showProduct.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({super.key});

  @override
  _TextViewEx createState() => _TextViewEx();
}

class _TextViewEx extends State<SearchBox> {
  TextEditingController search = TextEditingController();
  List<Product> allProduct = [];

  @override
  void initState() {
    super.initState();
    getdata();
  }

  void getdata() async {
    List<Product> data = await fetchAllProducts();
    setState(() {
      allProduct = data;
    });
  }

  List<Product> searchedProduct(String data) {
    return allProduct
        .where((item) => item.name.toLowerCase().contains(data.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Product> results = searchedProduct(search.text);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: search,
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {});
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final product = results[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Showproduct(product: product),
                      ),
                    );
                  },
                  leading: Image.network(
                    product.image,
                    width: 50,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Color.fromARGB(255, 247, 191, 139),
                      );
                    },
                  ),
                  title: Text(product.name),
                  subtitle: Text("\$${product.price}"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
