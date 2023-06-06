import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var fkey = GlobalKey<FormState>();
  bool isLoginPage = false;
  submit(String email, String password, String username) async {
    var auth = FirebaseAuth.instance;
    var authResult;
    if (isLoginPage) {
      try {
        authResult = await auth.signInWithEmailAndPassword(
            email: email, password: password);
      } catch (e) {
        print(e);
      }
    } else {
      authResult = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String uid = auth.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .set({'username': username, 'email': email});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Form(
        key: fkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            !isLoginPage
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: userNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter username";
                        }
                      },
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: "Username",
                          filled: true,
                          fillColor: Colors.blueGrey,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.all(10)),
                    ),
                  )
                : SizedBox(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter email";
                  }
                  if (!value!.contains("@")) {
                    return "Enter valid email";
                  }
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    hintText: "Email",
                    filled: true,
                    fillColor: Colors.blueGrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.all(10)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter password";
                  }
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    hintText: "Password",
                    filled: true,
                    fillColor: Colors.blueGrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.all(10)),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (fkey.currentState!.validate()) {
                    submit(
                        emailController.text.toString(),
                        passwordController.text.toString(),
                        userNameController.text.toString());
                  }
                },
                child: isLoginPage ? Text("Login") : Text("Sign Up")),
            TextButton(
                onPressed: () {
                  if (isLoginPage) {
                    setState(() {
                      isLoginPage = false;
                    });
                  } else if (!isLoginPage) {
                    setState(() {});
                    isLoginPage = true;
                  }
                },
                child: isLoginPage
                    ? const Text("Not a user?")
                    : const Text("Already a User?"))
          ],
        ),
      ),
    );
  }
}
