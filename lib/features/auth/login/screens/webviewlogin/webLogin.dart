import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_seller/features/auth/login/widget/login%20loading.dart';
// import 'package:ecommerce_seller/features/auth/login/provider/obsecure_provider.dart';
import 'package:ecommerce_seller/features/auth/signup/screens/webviewSignUp/webviewSignUp.dart';
import 'package:ecommerce_seller/features/auth/signup/widget/custome_textformfield.dart';
import 'package:ecommerce_seller/features/auth/signup/widget/submit_button.dart';
import 'package:ecommerce_seller/features/drawer/screen/drawerScreen.dart';
import 'package:ecommerce_seller/theme/apptext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:provider/provider.dart';

class WebLoginScreen extends StatelessWidget {
  WebLoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // final obsecureProvder = Provider.of<ObscureControlling>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 400, right: 400),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center, // centers all children
                    children: [
                      // 🖼 Logo image
                      Image.asset(
                        "asset/logo_black.png",
                        height: screenHeight * 0.35,
                        fit: BoxFit.contain,
                      ),

                      // 👋 Welcome text (centered on top of the image)
                      Positioned(
                        bottom: 17, // slight move below image center
                        left: 0,
                        right: 0,
                        child: Text(
                          "Welcome Back",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 33,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [GradientText("Log In", fontSize: 34)],
                  ),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    prefixIcon: Icons.email_outlined,
                    hintText: "Enter your email",
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      }
                      if (!RegExp(
                        r'^[\w\.-]+@[\w\.-]+\.\w+$',
                      ).hasMatch(value)) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    prefixIcon: Icons.password,
                    hintText: "Password",
                    controller: passwordController,
                    isObscure: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter your password";
                      }
                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebViewSignUp(),
                            ),
                          );
                        },
                        child: Text("signUp"),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot password",
                          style: TextStyle(color: Colors.pink),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Consumer<LoadingProvider>(
                    builder: (context, loadingProvider, child) {
                      return Button.rectangleButton(
                        onPressed: loadingProvider.isloading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  loadingProvider.start();

                                  bool loginSuccess = await login(
                                    emailController,
                                    passwordController,
                                    context,
                                  );

                                  loadingProvider.stop();

                                  if (!context.mounted) return;

                                  if (loginSuccess) {
                                    // ^ shared preference
                                    sharedpreferectdata(emailController, passwordController);
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen(),
                                      ),
                                    );
                                  }
                                }
                              },
                        child: loadingProvider.isloading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                "Submit",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      );
                    },
                  ),

                  SizedBox(height: 20),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Not a member ?"),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Sign  Up",
                          style: TextStyle(color: Colors.pink),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  // ^shared preference funciton

  sharedpreferectdata(
    TextEditingController emailController,
    TextEditingController passwordController,
  ) async {
    final email = emailController.text.toString();
    final password = passwordController.text.toString();

    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("email", email);
    await pref.setString("password", password);
  }

  Future<bool> login(
    TextEditingController email,
    TextEditingController password,
    BuildContext context,
  ) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: email.text.trim(),
            password: password.text.trim(),
          );

      final user = userCredential.user;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login failed. Try again.")),
        );
        return false;
      }

      DocumentSnapshot sellerDoc = await FirebaseFirestore.instance
          .collection("sellers")
          .doc(user.uid)
          .get();

      if (!sellerDoc.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Seller record not found.")),
        );
        return false;
      }

      final data = sellerDoc.data() as Map<String, dynamic>;
      final status = data["status"] ?? "pending";

      if (status == "approved") {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Login successful!")));
        return true;
      } else if (status == "pending") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Your account is still pending approval."),
          ),
        );
        await FirebaseAuth.instance.signOut();
        return false;
      } else if (status == "blocked") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Your account has been blocked.")),
        );
        await FirebaseAuth.instance.signOut();
        return false;
      }
      return false;
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
      return false;
    }
  }
}
