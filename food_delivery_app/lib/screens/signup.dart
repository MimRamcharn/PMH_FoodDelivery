import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery_app/screens/homepage.dart';
import 'package:food_delivery_app/screens/login.dart';
import 'package:food_delivery_app/widget/haveaccountornot.dart';
import 'package:food_delivery_app/widget/mybutton.dart';
import 'package:food_delivery_app/widget/mypasswordtextformfield.dart';
import 'package:food_delivery_app/widget/mytextformfield.dart';
import 'package:food_delivery_app/widget/toptitle.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isMale = false;

  final TextEditingController email = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController password = TextEditingController();
  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static RegExp regExp = RegExp(p);
  bool isLoading = false;
  late UserCredential authResult;
  void submit() async {
    setState(() {
      isLoading = true;
    });
    try {
      authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
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
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
    await FirebaseFirestore.instance
        .collection("UserData")
        .doc(authResult.user!.uid)
        .set({
      "UserName": fullName.text,
      "UserEmail": email.text,
      "UserId": authResult.user!.uid,
      "UserNumber": phoneNumber.text,
      "UserAddress": address.text,
      "UserGender": isMale == true ? "Male" : "Female"
    });
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => HomePage(),
      ),
    );
    setState(() {
      isLoading = false;
    });
  }

  void validation() {
    if (email.text.isEmpty &&
        password.text.isEmpty &&
        fullName.text.isEmpty &&
        address.text.isEmpty &&
        phoneNumber.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("All Fields Are Empty"),
        ),
      );
    } else if (fullName.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Full Name Is Empty"),
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
    } else if (phoneNumber.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Phone Number Is Empty"),
        ),
      );
    } else if (phoneNumber.text.length < 11) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Phone Number Must Be 11 digits"),
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

  final GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();

  Widget _buildAllTextFormField() {
    return SizedBox(
      height: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MyTextFormField(
            controller: fullName,
            title: "FullName",
          ),
          MyTextFormField(
            controller: email,
            title: "Email",
          ),
          MyTextFormField(
            controller: phoneNumber,
            title: "Phone Number",
          ),
          MyTextFormField(
            controller: address,
            title: "Address",
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isMale = !isMale;
              });
            },
            child: Container(
              height: 60,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: const Color(0xfff5d8e4),
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                isMale == false ? "Female" : "Male",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ),
          MyPasswordTextFormField(
            controller: password,
            title: "Password",
          ),
        ],
      ),
    );
  }

  Widget _buildButtonPart() {
    return isLoading == false
        ? MyButton(
            name: "Sign Up",
            onPressed: () {
              validation();
            },
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget _buildHaveAccountOrNotPart() {
    return HaveAccountOrNot(
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => const Login(),
          ),
        );
      },
      subTitle: "Login",
      title: "Already Have An Account?",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const TopTitle(
                  title: "SignUp",
                  subsTitle: "Create an Account",
                ),
                _buildAllTextFormField(),
                _buildButtonPart(),
                _buildHaveAccountOrNotPart(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
