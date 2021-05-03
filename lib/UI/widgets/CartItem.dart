import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String name;
  final int quantity;
  final int price;
  CartItem({required this.name, required this.price, required this.quantity});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Card(
          elevation: 6,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("Item name :"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(name),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("Price :"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("$price"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("Quantity :"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("$quantity"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
