import 'package:compox/UI/screens/HomeScreen.dart';
import 'package:compox/UI/screens/SignInScreen.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:splashscreen/splashscreen.dart';
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_core/firebase_core.dart';
import './Provider/PartProvder.dart';
import './UI/screens/SignUpScreen.dart';
import './UI/screens/CheckoutScreen.dart';
import './UI/screens/PartDetailsScreen.dart';
import './services/AuthService.dart';
import 'utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApps());
}

class MyApps extends StatefulWidget {
  @override
  _MyAppsState createState() => new _MyAppsState();
}

class _MyAppsState extends State<MyApps> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(
          seconds: 5,
          navigateAfterSeconds: MyApp(),
          image: Image.asset("assets/images/logo.png"),
          backgroundColor: Colors.white,
          styleTextUnderTheLoader: new TextStyle(),
          photoSize: 100.0,
          onClick: () => print("Flutter Egypt"),
          loaderColor: Colors.black),
    );
  }
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User initialData = null as User;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance)),
        StreamProvider<User>(
          create: (ctx) => ctx.read<AuthenticationService>().authState,
          initialData: initialData,
        ),
        ChangeNotifierProvider(create: (ctx) => PartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: "Montserrat",
          primarySwatch: white,
        ),
        home: Authenticate(),
        routes: {
          // "/": (ctx) => Authenticate(),
          SignUpScreen.routeName: (ctx) => SignUpScreen(),
          CheckoutScreen.routeName: (ctx) => CheckoutScreen(),
          PartDetailsScreen.routeName: (ctx) => PartDetailsScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          SignInScreen.routeName: (ctx) => SignInScreen()
        },
      ),
    );
  }
}

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();
    print(user);
    if (user != null) {
      return HomeScreen();
    }

    return SignInScreen();
  }
}
