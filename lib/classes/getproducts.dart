import 'dart:convert';

import 'package:http/http.dart' as http;

class Product {
  int _id;
  String _name;
  String _category;
  String _description;
  double _price;
  double _discount;
  String _image;
  int _stock = 0;

  Product({
    required int id,
    required String name,
    required String category,
    required String description,
    required double price,
    required double discount,
    required String image,
  }) : _id = id,
       _name = name,
       _category = category,
       _description = description,
       _price = price,
       _discount = discount,
       _image = image;

  // Getters
  int get id => _id;
  int get stock => _stock;
  String get name => _name;
  String get category => _category;
  String get description => _description;
  double get price => _price;
  double get discount => _discount;
  String get image => _image;

  // Setters
  set id(int value) => _id = value;
  set stock(int value) => _stock = value;
  set name(String value) => _name = value;
  set category(String value) => _category = value;
  set description(String value) => _description = value;
  set price(double value) => _price = value;
  set discount(double value) => _discount = value;
  set image(String value) => _image = value;
}

/////////////////////////////////////////////////////////////////////////////////////////////

Future<List<Product>> fetchProductsByCategory(String category) async {
  final url = Uri.parse(
    "https://ib.jamalmoallart.com/api/v1/products/category/$category",
  );

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);

      List<Product> products = jsonList.map((item) {
        return Product(
          id: item['id'],
          name: item['name'],
          category: item['category'],
          description: item['description'],
          price: (item['price'] as num).toDouble(),
          discount: (item['discount'] as num).toDouble(),
          image: item['image'],
        );
      }).toList();

      return products;
    } else {
      throw Exception("Failed to load products: ${response.statusCode}");
    }
  } catch (e) {
    print("Error fetching products: $e");
    return [];
  }
}

//////////////////////////////////////////////////////////////////////////////////////
List<Product> allCategoryProduct = [];
void getCategoyrWithName(String category) async {
  allCategoryProduct = await fetchProductsByCategory(category);
}
//////////////////////////////////////////////////////////////////////////////////////

Future<List<Product>> fetchAllProducts() async {
  final url = Uri.parse("https://ib.jamalmoallart.com/api/v1/all/products");

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);

      List<Product> products = jsonList.map((item) {
        return Product(
          id: item['id'],
          name: item['name'],
          category: item['category'],
          description: item['description'],
          price: (item['price'] as num).toDouble(),
          discount: (item['discount'] as num).toDouble(),
          image: item['image'],
        );
      }).toList();

      return products;
    } else {
      throw Exception("Failed to load products: ${response.statusCode}");
    }
  } catch (e) {
    print("Error fetching products: $e");
    return [];
  }
}

////////////////////////////////////////////////////////////////////////////////////
List<Product> allProduct = [];
void getAllProducts(String category) async {
  allCategoryProduct = await fetchProductsByCategory(category);
}

//////////////////////////////////////////////////////////////////////////////////////
