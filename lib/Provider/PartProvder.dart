import 'package:flutter/cupertino.dart';
import '../services/AuthService.dart';
import '../services/httpService.dart';
import '.././model.dart';

class PartProvider with ChangeNotifier {
  List<Part> _partsList = [];

  PartsService _partsService = new PartsService();

  List<Cart> _cartItems = [];

  Part getPartDetails(String name) {
    return _partsList.firstWhere((element) => element.name == name);
  }

  List<Part> get allPartsList {
    return [..._partsList];
  }

  List<Cart> get getCartList {
    return [..._cartItems];
  }

  int get getCartListLength {
    return _cartItems.length;
  }

  List<Part> get headList {
    return _partsList.where((element) => element.type == "Headlight").toList();
  }

  List<Part> get tailList {
    return _partsList.where((element) => element.type == "Taillight").toList();
    ;
  }

  List<Part> get fenderList {
    return _partsList.where((element) => element.type == "Fender").toList();
  }

  Future<void> addToCart(Cart item, String userEmail) async {
    _cartItems.add(item);

    // Map data = {
    //   [userEmail]: {..._cartItems}
    // };

    // _partsService.addToCarts(userEmail, data);

    notifyListeners();
    print(_cartItems);
  }

  Future<void> getPartsData() async {
    try {
      final data = await _partsService.getAllParts();
      final convertedData = data as List<dynamic>;
      convertedData.removeAt(0);

      convertedData.forEach((partItem) {
        _partsList.add(Part(
            name: partItem["name"],
            price: partItem["price"],
            desc: partItem["desc"],
            type: partItem["type"],
            imagePath: partItem["imagePath"]));
      });
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
