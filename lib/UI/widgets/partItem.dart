import 'package:compox/main.dart';
import 'package:compox/model.dart';
import 'package:compox/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/PartProvder.dart';
import '../screens/PartDetailsScreen.dart';

class PartItem extends StatelessWidget {
  final String name;
  final int price;
  final String imagePath;
  PartItem({required this.name, required this.price, required this.imagePath});
  @override
  Widget build(BuildContext context) {
    final addToCart = Provider.of<PartProvider>(context);
    final useremail = context.read<AuthenticationService>().userDetails.email;
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(PartDetailsScreen.routeName, arguments: name);
      },
      child: Container(
        child: Card(
          elevation: 5,
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
              Text(name),
              Text("\$$price"),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  onPressed: () {
                    addToCart.addToCart(
                        Cart(name: name, price: price, quantity: 1), useremail);
                  },
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
