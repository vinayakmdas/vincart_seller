
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_seller/features/auth/signup/widget/custome_textformfield.dart';
import 'package:ecommerce_seller/theme/app_custome_colour.dart';
import 'package:ecommerce_seller/theme/apptext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      rethrow; // throw error back so UI can show it
    }
  }

  @override
  Widget build(BuildContext context) {
    // controllers
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPassword = TextEditingController();
    TextEditingController businessRoleController = TextEditingController();
    TextEditingController companyNameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController addressController = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Row(
        children: [
          Expanded(child: Container(color: AppColour.whitecolor)),
          Expanded(
            child: Container(
              color: AppColour.whitecolor,
              child: Padding(
                padding: const EdgeInsets.only(left: 35, top: 108, right: 35),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GradientText("Sign up", fontSize: 34),
                        const SizedBox(height: 25),

                        //^ SELLER NAME
                        CustomTextFormField(
                          hintText: "Seller Name :",
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

                 //^EMAIL
                        CustomTextFormField(
                          hintText: "Email :",
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

                       //^PHONE
                        CustomTextFormField(
                          hintText: "Phone No :",
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

                        //^PASSWORD
                        CustomTextFormField(
                          hintText: "Password :",
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

                        //^ CONFORM PASSWROD
                        CustomTextFormField(
                          hintText: "Confirm password :",
                          controller: confirmPassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Re-enter your password";
                            }
                            if (passwordController.text !=
                                confirmPassword.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        //^ BUSSINESS ROLE
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

                       //^COMPANY NAME
                        CustomTextFormField(
                          hintText: "Registered Company Name :",
                          controller: companyNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Company name is required";
                            }
                            if (!RegExp(r'^[a-zA-Z0-9 &,.-]+$')
                                .hasMatch(value)) {
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
//^DESCRIPITON
                        // Description
                        CustomTextFormField(
                          hintText: "Description about your product :",
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
//^ADRESSS
                        // Address
                        CustomTextFormField(
                          hintText: "Address :",
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

                        //^SUBMIT BUTTON
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Button.rectangleButton("Submit", () async {
                            //   if (_formKey.currentState!.validate()) {
                            //     try {
                            //       await signup(
                            //         sellerName: nameController.text.trim(),
                            //         email: emailController.text.trim(),
                            //         phone: phoneController.text.trim(),
                            //         password: passwordController.text.trim(),
                            //         businessRole:
                            //             businessRoleController.text.trim(),
                            //         companyName:
                            //             companyNameController.text.trim(),
                            //         description:
                            //             descriptionController.text.trim(),
                            //         address: addressController.text.trim(),
                            //       );

                            //       if (context.mounted) {
                            //         ScaffoldMessenger.of(context).showSnackBar(
                            //           const SnackBar(
                            //               content: Text(
                            //                   "Signup successful! Pending admin approval.")),
                            //         );

                            //         Navigator.pushReplacement(
                            //           context,
                            //           MaterialPageRoute(
                            //             builder: (_) =>
                            //                 const WaitingScreen(),
                            //           ),
                            //         );
                            //       }
                            //     } catch (e) {
                            //       if (context.mounted) {
                            //         ScaffoldMessenger.of(context).showSnackBar(
                            //           SnackBar(
                            //               content: Text("Signup failed: $e")),
                            //         );
                            //       }
                            //     }
                            //   }
                            // }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

