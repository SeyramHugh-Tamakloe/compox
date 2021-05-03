import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/PartProvder.dart';

class PartDetailsScreen extends StatelessWidget {
  static const routeName = "/details";
  @override
  Widget build(BuildContext context) {
    final name = ModalRoute.of(context)!.settings.arguments as String;
    final details = Provider.of<PartProvider>(context).getPartDetails(name);
    print(details.name);
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Part Details"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Image.asset(details.imagePath),
              width: double.infinity,
            ),
            Text(
              details.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(details.type,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10,
            ),
            Text(details.desc, style: TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
