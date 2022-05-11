import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning/services/auth.dart';
import 'package:learning/views/singin.dart';
import 'package:learning/widget/widgets.dart';

class SingUp extends StatefulWidget {
  const SingUp({Key? key}) : super(key: key);

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  AuthService authService = AuthService();
  bool isLoading = false;
  singUp() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await authService.SignUpWithEmailAndPassword(
              emailEditingController.text, passwordEditingController.text)
          .then(
        (value) {
          print("value is $value");
        },
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var hintName = 'name';
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
                    const Spacer(),
                    TextFormField(
                      controller: nameEditingController,
                      decoration: InputDecoration(hintText: hintName),
                      validator: (value) =>
                          value!.isEmpty ? 'Enter name' : null,
                    ),
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
                      onTap: () async {
                        await singUp();
                      },
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
                        const Text('Already have an account? ',
                            style:
                                TextStyle(color: Colors.black87, fontSize: 17)),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => const SingIn())));
                          },
                          child: Container(
                            child: const Text('Sign In',
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
