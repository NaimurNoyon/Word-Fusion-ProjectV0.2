import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Constants/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formField = GlobalKey<FormState>();

// Controllers to get values from text fields
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool loading = false;

  final FirebaseAuth _fireStore = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorPrimary,
      body: Form(
        key: _formField,
        child: Column(
          children: [
            Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 30.sp,
                color: AppColors.colorBlack,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Just a few quick things to get started",
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.colorBlack,
              ),
            ),
            TextFormField(

              cursorColor: AppColors.colorSecondary,
              keyboardType: TextInputType.emailAddress,
              controller: emailController, // sets the controller for the text input field
              style: const TextStyle(
                  color: AppColors.colorBlack,
              ), // sets the text style for the text input field
              decoration: InputDecoration(
                hintText: 'Email', // sets the hint text for the text input field
                hintStyle: const TextStyle(
                    color: AppColors.colorDisable,
                ),
                fillColor: ,// sets the hint text style for the text input field
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: AppColors.colorBlack,
                ), // sets the prefix icon for the text input field
                contentPadding: const EdgeInsets.fromLTRB(0, -10, 0, -10), // sets the padding for the text input field content
                enabledBorder: OutlineInputBorder(
                  // sets the border for the enabled state of the text input field
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: AppColors.colorWhite,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  // sets the border for the focused state of the text input field
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: AppColors.colorSecondary,
                    width: 1,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  // sets the border for the error state of the text input field
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.colorPrimary,
                    width: 1,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  // sets the border for the focused error state of the text input field
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.colorPrimary,
                    width: 1,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors
                      .colorPrimary, // sets the background color of the container
                  borderRadius: BorderRadius.circular(
                      8), // sets the border radius of the container
                ),
                width: 308.w, // sets the width of the container
                child: TextFormField(
                  cursorColor: AppColors.colorSecondary,
                  //obscureText: obscureText,
                  // Assign a controller to the text field for reading the entered text
                  controller: passwordController,
                  // Add validation for the entered text
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Password";
                    } else if (passwordController.text.length < 6) {
                      return "Password length should be more than 6 characters";
                    }
                  },
                  style: const TextStyle(
                      color: AppColors
                          .colorWhite), // sets the text style for the text input field
                  decoration: InputDecoration(
                    hintText:
                    'Password', // sets the hint text for the text input field
                    hintStyle: const TextStyle(
                        color: AppColors
                            .colorPrimary), // sets the hint text style for the text input field
                    prefixIcon: const Icon(
                      Icons.lock_rounded,
                      color: AppColors.colorPrimary,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        // When the visibility toggle icon is tapped, toggle the value of obscureText
                        /*setState(() {
                          obscureText = !obscureText;
                        });*/
                      },
                      child: /*obscureText
                          ? */const Icon(Icons.visibility_off,
                          color: AppColors.colorPrimary, size: 20)
                          /*: const Icon(Icons.visibility,
                          color: AppColors.colorSecondary,
                          size: 20)*/,
                    ), // sets the prefix icon for the text input field
                    contentPadding: const EdgeInsets.fromLTRB(
                        10,
                        16,
                        -16,
                        16), // sets the padding for the text input field content
                    enabledBorder: OutlineInputBorder(
                      // sets the border for the enabled state of the text input field
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: AppColors.colorPrimary,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      // sets the border for the focused state of the text input field
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: AppColors.colorSecondary,
                        width: 1,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      // sets the border for the error state of the text input field
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: AppColors.colorPrimary,
                        width: 1,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      // sets the border for the focused error state of the text input field
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: AppColors.colorPrimary,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            //const RememberMeModel(),
            SizedBox(height: 20.h),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  onPressed: () async {
                    /*// Create the user in Firebase Authentication
                    UserCredential userCredential =
                        await _fireStore.createUserWithEmailAndPassword(
                      email: emailController.text.toString(),
                      password: passwordController.text.toString(),
                    );

                    // Get the user's UID
                    String uid = userCredential.user!.uid;

                    // Check if a document with the user's UID already exists
                    DocumentSnapshot userDoc = await FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .get();

                    if (userDoc.exists) {
                      print('User document already exists!');
                    } else {
                      // Create a new document in Firestore with the user's UID
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(uid)
                          .set({
                        'uid': uid,
                        'email': '',
                        'first_name': '',
                        'photoUrl': '',
                        'country':'',
                      });
                      print('User document created successfully!');
                    }

                    setState(() {
                      loading = false;
                    });

                    print('User created successfully!');*/
                  },
                  child: Text('SSSS'),
                )


            ),
          ],
        ),
      ),
    );
  }
}
