import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:join_me/bottomNavigationBar/customBottomNavigationBar.dart';
import 'package:join_me/domain/user.dart';
import 'package:join_me/event_list/event_list_view.dart';
import 'package:join_me/map/google_map.dart';
import 'package:join_me/screens/auth/auth_page.dart';
import 'package:join_me/screens/landing.dart';
import 'package:join_me/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AuthUser?>.value(
      value: AuthService().currentUser,
      initialData: null,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LandingPage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedItem = 0;
  final List<Widget> widgetMenuList = [
    MapSample(),
    EventListView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomBottomNavigationBar(
        onChange: (val) {
          setState(() {
            _selectedItem = val;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: widgetMenuList[_selectedItem],
    );
  }
}
