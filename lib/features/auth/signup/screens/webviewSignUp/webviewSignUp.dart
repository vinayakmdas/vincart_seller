import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_seller/features/auth/login/screens/webviewlogin/webLogin.dart';
import 'package:ecommerce_seller/features/auth/signup/provider/signup_loading.dart';
import 'package:ecommerce_seller/features/auth/signup/screens/sub_screens/waiting_screem.dart';
import 'package:ecommerce_seller/features/auth/signup/widget/checkbox_provider.dart';
import 'package:ecommerce_seller/features/auth/signup/widget/custome_textformfield.dart';
import 'package:ecommerce_seller/features/auth/signup/widget/submit_button.dart';
import 'package:ecommerce_seller/theme/app_custome_colour.dart';
import 'package:ecommerce_seller/theme/apptext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WebViewSignUp extends StatelessWidget {
  const WebViewSignUp({super.key});

  Future<void> signup({
    required String sellerName,
    required String email,
    required String phone,
    required String password,
    required String businessRole,
    required String companyName,
    required String description,
    required String address,
  }) async {
    try {
      // ✅ Create Firebase Auth account
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;

      // ✅ Save seller data into Firestore
      await FirebaseFirestore.instance.collection("sellers").doc(uid).set({
        "uid": uid,
        "sellerName": sellerName,
        "email": email,
        "phone": phone,
        "password": password, // ⚠️ not recommended to save plain password
        "businessRole": businessRole,
        "companyName": companyName,
        "description": description,
        "address": address,
        "status": "pending", // default: waiting for admin approval
        "createdAt": FieldValue.serverTimestamp(),
      });

      debugPrint("✅ Signup successful! Waiting for admin approval.");
    } catch (e) {
      debugPrint("❌ Signup error: $e");
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    // controllers
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPassword = TextEditingController();
    final businessRoleController = TextEditingController();
    final companyNameController = TextEditingController();
    final descriptionController = TextEditingController();
    final addressController = TextEditingController();
    final formKey = GlobalKey<FormState>();
 
    // final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: AppColour.whitecolor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500), // ✅ fix layout width
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ✅ FIXED LOGO AND WELCOME TEXT SECTION
                    Center(
                      child: Column(
                        children: [
                          Image.asset(
                            "asset/logo_black.png",
                            height: screenheight * 0.42,
                            fit: BoxFit.contain,
                          ),
                          Transform.translate(
                            offset: const Offset(0, -90),

                            child:Text(
  "Get Start",
  textAlign: TextAlign.center,
  style: GoogleFonts.ptSerif(
    fontWeight: FontWeight.bold,
    fontSize: 36,
    color: Colors.black,
    letterSpacing: 0.5,
  ),
),


                          ),
                        ],
                      ),
                    ),
                    
                    // Reduced spacing between Welcome and Sign up
                    Transform.translate(
                      offset: const Offset(0, -70),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GradientText("Sign up", fontSize: 34),
                          const SizedBox(height: 25),

                          // SELLER NAME
                          CustomTextFormField(
                            prefixIcon: Icons.person,
                            hintText: "Seller Name ",
                            controller: nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Seller Name is required";
                              }
                              final nameRegex = RegExp(r'^[a-zA-Z ]+$');
                              if (!nameRegex.hasMatch(value)) {
                                return "Only letters are allowed";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // EMAIL
                          CustomTextFormField(
                            prefixIcon: Icons.email_outlined,
                            hintText: "Email ",
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Email is required";
                              }
                              if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$')
                                  .hasMatch(value)) {
                                return "Enter a valid email";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // PHONE
                          CustomTextFormField(
                            prefixIcon: Icons.call,
                            hintText: "Phone No ",
                            controller: phoneController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Mobile number is required";
                              }
                              if (value.length != 10) {
                                return "Mobile number must be 10 digits";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // PASSWORD
                          CustomTextFormField(
                            prefixIcon: Icons.lock,
                            hintText: "Password ",
                            controller: passwordController,
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
                          const SizedBox(height: 16),

                          // CONFIRM PASSWORD
                          CustomTextFormField(
                            prefixIcon: Icons.security_update_good_rounded,
                            hintText: "Confirm password ",
                            controller: confirmPassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Re-enter your password";
                              }
                              if (passwordController.text != confirmPassword.text) {
                                return "Passwords do not match";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // BUSINESS ROLE
                          CustomDropdownField(
                            hintText: "Business role",
                            controller: businessRoleController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Business role is required";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // COMPANY NAME
                          CustomTextFormField(
                            prefixIcon: Icons.format_shapes_outlined,
                            hintText: "Registered Company Name ",
                            controller: companyNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Company name is required";
                              }
                              if (!RegExp(r'^[a-zA-Z0-9 &,.-]+$').hasMatch(value)) {
                                return "Only letters, numbers, spaces, and &,.- are allowed";
                              }
                              if (value.length < 2) {
                                return "Company name must be at least 2 characters";
                              }
                              if (value.length > 100) {
                                return "Company name cannot exceed 100 characters";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // DESCRIPTION
                          CustomTextFormField(
                            prefixIcon: Icons.comment_sharp,
                            hintText: "Description about your product ",
                            controller: descriptionController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Description is required";
                              }
                              if (value.length < 10) {
                                return "Description must be at least 10 characters";
                              }
                              if (value.length > 500) {
                                return "Description cannot exceed 500 characters";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // ADDRESS
                          CustomTextFormField(
                            prefixIcon: Icons.details,
                            hintText: "Address ",
                            controller: addressController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Address is required";
                              }
                              if (value.length < 10) {
                                return "Address must be at least 10 characters";
                              }
                              if (value.length > 300) {
                                return "Address cannot exceed 300 characters";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 25),

                           Row(
                            children: [
                          CostomeCheckBox(),
Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    const Text("I agree to the "),
    TextButton(
      onPressed: () {
        // Navigate to Terms of Service
      },
      child: const Text("Terms of Service"),
    ),
    const Text(" and "),
    TextButton(
      onPressed: () {
        // Navigate to Privacy Policy
      },
      child: const Text("Privacy Policy"),
    ),
  ],
)
                              ],
                           ),
SizedBox(height: 17,),
                          // SUBMIT BUTTON
                          Center(
                            child: Consumer<SignupLoading>(
                              builder: (context, signupprovider, child) {
                                return Button.rectangleButton(
                                  onPressed: signupprovider.isloading
                                      ? null
                                      : () async {
                                          if (formKey.currentState!.validate()) {
                                            signupprovider.start();
                                            try {
                                              await signup(
                                                sellerName:
                                                    nameController.text.trim(),
                                                email: emailController.text.trim(),
                                                phone: phoneController.text.trim(),
                                                password:
                                                    passwordController.text.trim(),
                                                businessRole:
                                                    businessRoleController.text.trim(),
                                                companyName:
                                                    companyNameController.text.trim(),
                                                description:
                                                    descriptionController.text.trim(),
                                                address:
                                                    addressController.text.trim(),
                                              );
                                              signupprovider.stop();

                                              if (context.mounted) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        "Signup successful! Pending admin approval."),
                                                  ),
                                                );
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        const WaitingScreen(),
                                                  ),
                                                );
                                              }
                                            } catch (e) {
                                              signupprovider.stop();
                                              if (context.mounted) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content:
                                                        Text("Signup failed: $e"),
                                                  ),
                                                );
                                              }
                                            }
                                          }
                                        },
                                  child: signupprovider.isloading
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
                          ),


                          Divider()

                        ,  Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    
    Text("Already have account "),
    TextButton(onPressed: (){

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WebLoginScreen()));
    }, child: Text("Login in"))
  ],
)

                        ],
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}