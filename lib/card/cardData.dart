import 'package:final_project/classes/getproducts.dart';

class PurchaseCard {
  static final PurchaseCard _instance = PurchaseCard._internal();
  PurchaseCard._internal();
  factory PurchaseCard() => _instance;

  List<Product> _card = [];

  List<Product> get card => _card;

  void addProduct(Product product) {
    final index = _card.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      _card[index].stock++;
    } else {
      _card.add(product);
      _card[index].stock++;
    }
  }

  void clearCard() {
    _card.map((item) {
      item.stock = 0;
    });
    _card = [];
  }

  void removeProduct(Product) {
    _card.remove(Product);
  }

  double totalPrice() {
    double price = 0;

    _card.forEach((item) {
      price += (item.price * item.stock);
    });

    return price;
  }
}
