import 'package:compox/services/AuthService.dart';
import '../../services/EmailService.dart' show sendMail;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/PartProvder.dart';
import '../widgets/CartItem.dart';

class CheckoutScreen extends StatefulWidget {
  static const routeName = "/checkout";
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    final userDetails = context.read<AuthenticationService>().userDetails;
    final cartList = Provider.of<PartProvider>(context).getCartList;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Checkout"),
        ),
        body: Stack(
          children: [
            Container(
              child: cartList.length == 0
                  ? Center(child: Text("There are no items in your checkout"))
                  : ListView(
                      children: cartList
                          .map((e) => CartItem(
                              name: e.name,
                              price: e.price,
                              quantity: e.quantity))
                          .toList(),
                    ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                      onPressed: () async {
                        await sendMail(userDetails.email);
                      },
                      child: Text(
                        "Checkout",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
