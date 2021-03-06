import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_presensi_uajy/src/data/remote/auth_service.dart';
import 'package:flutter_presensi_uajy/src/screen/home/home_screen.dart';
import 'package:flutter_presensi_uajy/src/screen/login/login_validator.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with LoginValidator {
  final formKey = GlobalKey<FormState>();

  String formEmail = "";
  String formPassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(0.0, 20.0),
            end: const Alignment(0.0, 0.0),
            colors: [
              Colors.deepPurple,
              Colors.purple,
            ],
          ),
        ),
        child: Center(
          child: Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 10,
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 20,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          // enabled: !viewModel.isLoading,
                          // key: viewModel.formEmailKey,
                          validator: validateEmail,
                          onChanged: (value) => formEmail = value,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                            labelText: "Email",
                            hintText: "Enter valid Email",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          // enabled: !viewModel.isLoading,
                          // key: viewModel.formPasswordKey,
                          obscureText: true,
                          validator: validatePassword,
                          onChanged: (value) => formPassword = value,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(),
                            labelText: "Password",
                            hintText: "Enter Password",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              //TODO aksi login
                              if (formKey.currentState.validate()) {
                                print(formEmail);
                                print(formPassword);

                                final authService = AuthService();

                                authService.login(
                                  email: formEmail,
                                  password: formPassword,
                                );

                                FirebaseAuth.instance
                                    .authStateChanges()
                                    .listen((User user) {
                                  if (user == null) {
                                    print("logout");
                                  } else {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => HomeScreen(),
                                      ),
                                    );
                                  }
                                });
                              }
                            },
                            icon: const Icon(Icons.login),
                            label: Text("Login"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: FlatButton(
                            onPressed: () {
                              //TODO aksi buka halaman register
                            },
                            child: const Text("Register"),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
