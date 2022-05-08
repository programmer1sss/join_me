import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:join_me/services/auth.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({Key? key}) : super(key: key);

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  bool showLogin = true;
  late String _email;
  late String _password;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        _logo(),
        SizedBox(
          height: 100,
        ),
        // _form('Login', (() {})),
        showLogin ? Register() : Login()
      ]),
    );
  }

  void _signInButtonAction() async {
    _email = _emailController.text;
    _password = _passwordController.text;

    if (_email.isEmpty || _password.isEmpty) return;
    dynamic user = await _authService.signInWithEmailAndPassword(
        _email.trim(), _password.trim());
    if (user == null)
      Fluttertoast.showToast(
          msg: "Can't SignIn you! Please check your email/password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    else {
      _emailController.clear();
      _passwordController.clear();
    }
  }

  Column Login() {
    return Column(
      children: <Widget>[
        _form('REGISTER', _registerButtonAction),
        Padding(
          padding: EdgeInsets.all(10),
          child: GestureDetector(
              child: Text('Already registered? Login!',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(146, 122, 244, 1),
                  )),
              onTap: () {
                setState(() {
                  showLogin = true;
                });
              }),
        )
      ],
    );
  }

  void _registerButtonAction() async {
    _email = _emailController.text;
    _password = _passwordController.text;

    if (_email.isEmpty || _password.isEmpty) return;

    dynamic user = await _authService.registerWithEmailAndPassword(
        _email.trim(), _password.trim());
    if (user == null)
      Fluttertoast.showToast(
          msg: "Can't Register you! Please check your email/password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    else {
      _emailController.clear();
      _passwordController.clear();
    }
  }

  Column Register() {
    return Column(
      children: <Widget>[
        _form('LOGIN', _signInButtonAction),
        Padding(
          padding: EdgeInsets.all(10),
          child: GestureDetector(
              child: Text('Not registered yet? Register!',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(146, 122, 244, 1),
                  )),
              onTap: () {
                setState(() {
                  showLogin = false;
                });
              }),
        )
      ],
    );
  }

  Widget _logo() {
    return Padding(
      padding: EdgeInsets.only(top: 100),
      child: Container(
        child: Align(
          child: Text(
            'JOIN ME',
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(146, 122, 244, 1),
            ),
          ),
        ),
      ),
    );
  }

  Widget _button(String text, void func()) {
    return TextButton(
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(color: Color.fromRGBO(146, 122, 244, 1), width: 3),
          ),
        ),
      ),
      onPressed: () {
        func();
      },
    );
  }

  Widget _form(String label, void func()) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 20, top: 10),
            child: Container(
              child:
                  _input(Icon(Icons.email), "EMAIL", _emailController, false),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Container(
                child: _input(
                    Icon(Icons.lock), "PASSWORD", _passwordController, true),
              )),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: _button(label, func),
            ),
          )
        ],
      ),
    );
  }
}

Widget _input(
    Icon icon, String hint, TextEditingController controller, bool obscure) {
  return Container(
    padding: EdgeInsets.only(left: 20, right: 20),
    child: TextField(
      controller: controller,
      obscureText: obscure,
      style: TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        hintStyle: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
        hintText: hint,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.black, width: 3)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.black, width: 1)),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: IconTheme(
              data: IconThemeData(
                color: Colors.black,
              ),
              child: icon),
        ),
      ),
    ),
  );
}
