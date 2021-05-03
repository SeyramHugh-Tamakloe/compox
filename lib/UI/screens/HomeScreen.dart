import 'package:compox/UI/screens/SignInScreen.dart';
import 'package:compox/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import '../../Provider/PartProvder.dart';
import '../screens/CheckoutScreen.dart';
import '../widgets/All.dart';
import '../widgets/Fender.dart';
import '../widgets/Headlight.dart';
import '../widgets/TailLights.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<void> _appData;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _appData = _getAppData();
  }

  Future<void> _getAppData() async {
    return Provider.of<PartProvider>(context, listen: false).getPartsData();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = true;

    // final cartLen = Provider.of<PartProvider>(context).getCartListLength;
    return FutureBuilder(
      future: _appData,
      builder: (context, dataSnapShot) {
        if (dataSnapShot.connectionState == ConnectionState.waiting) {
          return SafeArea(
              child: Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.black,
            )),
          ));
        }
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              actions: [
                Consumer<PartProvider>(
                  builder: (ctx, data, i) => Badge(
                    badgeContent: Text("${data.getCartListLength}"),
                    padding: EdgeInsets.all(5),
                    position: BadgePosition.topEnd(top: 2, end: 1),
                    child: IconButton(
                        icon: Icon(Icons.shopping_cart_outlined),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(CheckoutScreen.routeName);
                        }),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      context.read<AuthenticationService>().logOut();
                      Navigator.of(context)
                          .pushReplacementNamed(SignInScreen.routeName);
                    })
              ],
              centerTitle: true,
              title: SizedBox(
                height: 30,
                width: 200,
                child: Image.asset("assets/images/logo.png"),
              ),
              bottom: TabBar(
                indicatorColor: Colors.black,
                labelPadding: EdgeInsets.all(3),
                tabs: [
                  Tab(
                      child: Text(
                    "All",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  )),
                  Tab(
                      child: Text(
                    "Headlights",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  )),
                  Tab(
                      child: Text(
                    "Tail Lights",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  )),
                  Tab(
                      child: Text(
                    "Fender",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ))
                ],
              ),
            ),
            body: TabBarView(
              children: [
                All(),
                Headlight(),
                TailLights(),
                Fender(),
              ],
            ),
          ),
        );
      },
    );
  }
}
