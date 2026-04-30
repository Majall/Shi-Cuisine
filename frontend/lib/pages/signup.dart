import 'package:flutter/material.dart';
import 'package:sri_cuisine/pages/login.dart';
import 'package:sri_cuisine/services/UserApi.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formfield = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Sign up"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFF2E4),
              Color(0xFFFFE5D3),
              Color(0xFFFFD4B8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text(
                "Create your account",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formfield,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "images/whiteLogo.jpg",
                          height: 120,
                          width: 160,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          controller: usernameController,
                          decoration: const InputDecoration(
                            labelText: "User Name",
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (value) {
                            bool userNameValid =
                                RegExp(r'^[a-z A-Z]+$').hasMatch(value!);

                            if (value.isEmpty) {
                              return "Enter user name";
                            } else if (!userNameValid) {
                              return "Enter valid user name";
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: "Email Address",
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (value) {
                            bool emailValid = RegExp(
                                    r'^([a-zA-Z0-9_\.-]+)@([a-zA-Z0-9_\.-]+)\.([a-zA-Z]{2,6})$')
                                .hasMatch(value!);

                            if (value.isEmpty) {
                              return "Enter email address";
                            } else if (!emailValid) {
                              return "Enter valid email address!";
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: passController,
                          obscureText: passToggle,
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: const Icon(Icons.lock),
                            suffix: InkWell(
                              onTap: () {
                                setState(() {
                                  passToggle = !passToggle;
                                });
                              },
                              child: Icon(passToggle
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                          ),
                          validator: (value) {
                            bool passwordValid = RegExp(
                                    r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$')
                                .hasMatch(value!);

                            if (value.isEmpty) {
                              return "Enter Password";
                            } else if (!passwordValid) {
                              return "Minimum 8 characters | one uppercase letter\none lowercase letter | one number";
                            }
                          },
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () async {
                              if (_formfield.currentState!.validate()) {
                                await UserApi.createUser(
                                  context: context,
                                  userName: usernameController.text.trim(),
                                  email: emailController.text.trim(),
                                  password: passController.text.trim(),
                                );
                              }
                            },
                            child: const Text("Sign up"),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an Account?"),
                            GestureDetector(
                              child: Text(
                                " Log in",
                                style: TextStyle(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext) =>
                                            LoginPage()));
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
