import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning/services/auth.dart';
import 'package:learning/views/signup.dart';
import 'package:learning/widget/widgets.dart';

class SingIn extends StatefulWidget {
  const SingIn({Key? key}) : super(key: key);

  @override
  State<SingIn> createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  AuthService authService = AuthService();
  bool isLoading = false;
  singIn() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await authService
          .signInEmailAndPass(emailEditingController.text.toString(),
              passwordEditingController.text.toString())
          .then((value) {
            if (value != null) {
               
            }
          });
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var hintEmail = 'Email';
    var hintPassword = 'Password';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: appBar(context),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formkey,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Spacer(),
                    TextFormField(
                      controller: emailEditingController,
                      decoration: InputDecoration(hintText: hintEmail),
                      validator: (value) =>
                          value!.isEmpty ? 'Enter Email' : null,
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: passwordEditingController,
                      decoration: InputDecoration(hintText: hintPassword),
                      validator: (value) =>
                          value!.isEmpty ? 'Enter Password' : null,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    GestureDetector(
                      onTap: () => singIn(),
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 15),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30)),
                        child: const Text(
                          "Sign In",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account? ',
                            style:
                                TextStyle(color: Colors.black87, fontSize: 17)),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => const SingUp())));
                          },
                          child: Container(
                            child: const Text('Sign Up',
                                style: TextStyle(
                                    color: Colors.black87,
                                    decoration: TextDecoration.underline,
                                    fontSize: 17)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
