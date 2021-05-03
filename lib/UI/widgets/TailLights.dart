import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/PartProvder.dart';
import './partItem.dart';

class TailLights extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<PartProvider>(context).tailList;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 1.5),
        crossAxisCount: 2,
        children: data
            .map((item) => PartItem(
                name: item.name, price: item.price, imagePath: item.imagePath))
            .toList(),
      ),
    );
  }
}
