import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:country_pickers/country.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:word_fusion/Screens/home_screen.dart';

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

  String? selectedCountry;
  List<String> countryList = ['Country 1', 'Country 2', 'Country 3']; // Add your actual country names here


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorPrimary,
      body: Form(
        key: _formField,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            nameTextFormField(),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TextFormField(
                cursorColor: AppColors.colorSecondary,
                keyboardType: TextInputType.emailAddress,
                controller: passwordController, // sets the controller for the text input field
                style: const TextStyle(
                  color: AppColors.colorSecondary,
                  fontWeight: FontWeight.bold,
                ), // sets the text style for the text input field
                decoration: InputDecoration(
                  hintText: 'Password', // sets the hint text for the text input field
                  hintStyle: const TextStyle(
                    color: AppColors.colorDisable,
                  ),
                  filled: true,
                  fillColor: AppColors.colorWhite,// sets the hint text style for the text input field
                  prefixIcon: const Icon(
                    Icons.password_outlined,
                    color: AppColors.colorSecondary,
                  ), // sets the prefix icon for the text input field
                  contentPadding: const EdgeInsets.fromLTRB(0, -0, 0, -0), // sets the padding for the text input field content
                  enabledBorder: OutlineInputBorder(
                    // sets the border for the enabled state of the text input field
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: AppColors.colorSecondary,
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
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TextFormField(
                cursorColor: AppColors.colorSecondary,
                keyboardType: TextInputType.emailAddress,
                controller: passwordController, // sets the controller for the text input field
                style: const TextStyle(
                  color: AppColors.colorSecondary,
                  fontWeight: FontWeight.bold,
                ), // sets the text style for the text input field
                decoration: InputDecoration(
                  hintText: 'Password', // sets the hint text for the text input field
                  hintStyle: const TextStyle(
                    color: AppColors.colorDisable,
                  ),
                  filled: true,
                  fillColor: AppColors.colorWhite,// sets the hint text style for the text input field
                  prefixIcon: const Icon(
                    Icons.password_outlined,
                    color: AppColors.colorSecondary,
                  ), // sets the prefix icon for the text input field
                  contentPadding: const EdgeInsets.fromLTRB(0, -0, 0, -0), // sets the padding for the text input field content
                  enabledBorder: OutlineInputBorder(
                    // sets the border for the enabled state of the text input field
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: AppColors.colorSecondary,
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
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: DropdownButtonFormField<String>(
                value: selectedCountry,
                onChanged: (String? newValue) {
                  // Handle country selection
                  // You can update the state or perform any other actions here
                  setState(() {
                    selectedCountry = newValue!;
                  });
                },
                hint: Text('Select your country'),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.colorWhite,
                  prefixIcon: const Icon(
                    Icons.flag,
                    color: AppColors.colorSecondary,
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(0, -0, 16, -0), // sets the padding for the text input field content
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: AppColors.colorSecondary,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: AppColors.colorSecondary,
                      width: 1,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.colorPrimary,
                      width: 1,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.colorPrimary,
                      width: 1,
                    ),
                  ),
                ),
                items: countryList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 10.h),
            //const RememberMeModel(),
            SizedBox(height: 20.h),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  onPressed: () async {
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
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


  Widget nameTextFormField(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: TextFormField(
        cursorColor: AppColors.colorSecondary,
        keyboardType: TextInputType.emailAddress,
        controller: emailController, // sets the controller for the text input field
        style: const TextStyle(
          color: AppColors.colorSecondary,
          fontWeight: FontWeight.bold,
        ), // sets the text style for the text input field
        decoration: InputDecoration(
          hintText: 'Email', // sets the hint text for the text input field
          hintStyle: const TextStyle(
            color: AppColors.colorDisable,
          ),
          filled: true,
          fillColor: AppColors.colorWhite,
          prefixIcon: const Icon(
            Icons.email_outlined,
            color: AppColors.colorSecondary,
          ), // sets the prefix icon for the text input field
          contentPadding: const EdgeInsets.fromLTRB(0, -0, 0, -0), // sets the padding for the text input field content
          enabledBorder: OutlineInputBorder(
            // sets the border for the enabled state of the text input field
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: AppColors.colorSecondary,
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
    );
  }
}
