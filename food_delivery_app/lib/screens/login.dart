import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery_app/screens/homepage.dart';
import 'package:food_delivery_app/screens/signup.dart';
import 'package:food_delivery_app/widget/haveaccountornot.dart';
import 'package:food_delivery_app/widget/mybutton.dart';
import 'package:food_delivery_app/widget/mypasswordtextformfield.dart';
import 'package:food_delivery_app/widget/mytextformfield.dart';
import 'package:food_delivery_app/widget/toptitle.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();

  bool isLoading = false;
  UserCredential? authResult;

  void submit() async {
    setState(() {
      isLoading = true;
    });

    try {
      authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => HomePage(),
        ),
      );
    } on PlatformException catch (e) {
      String message = "Please Check Internet";
      if (e.message != null) {
        message = e.message.toString();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );

      setState(() {
        isLoading = false;
      });
    }
  }

  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static RegExp regExp = RegExp(p);

  void validation() {
    if (email.text.isEmpty && password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Both Fields Are Empty"),
        ),
      );
    } else if (email.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email Is Empty"),
        ),
      );
    } else if (!regExp.hasMatch(email.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid Email"),
        ),
      );
    } else if (password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password Is Empty"),
        ),
      );
    } else if (password.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password Is Too Short"),
        ),
      );
    } else {
      submit();
    }
  }

  Widget _buildAllTextFormFieldPlace() {
    return Center(
      child: SizedBox(
        height: 300,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextFormField(
              title: "Email",
              controller: email,
            ),
            const SizedBox(
              height: 10,
            ),
            MyPasswordTextFormField(
              controller: password,
              title: "Password",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonPart() {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : MyButton(
            name: "Login",
            onPressed: validation,
          );
  }

  Widget _buildHaveAccountNotPart() {
    return HaveAccountOrNot(
      subTitle: "Sign Up",
      title: "Don't Have An Account?",
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => const SignUp(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffold,
      backgroundColor: const Color(0xfff8f8f8),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const TopTitle(
                subsTitle: "Welcome Back!",
                title: "Login",
              ),
              _buildAllTextFormFieldPlace(),
              _buildButtonPart(),
              const SizedBox(
                height: 10,
              ),
              _buildHaveAccountNotPart(),
            ],
          ),
        ),
      ),
    );
  }
}
