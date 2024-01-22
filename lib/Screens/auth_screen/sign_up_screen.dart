import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:country_pickers/country.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:word_fusion/Screens/auth_screen/sign_in_screen.dart';
import 'package:word_fusion/Screens/home_screen.dart';

import '../../Constants/colors.dart';
import '../../Constants/custom_page_route.dart';
import '../../Constants/text_const.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formField = GlobalKey<FormState>();

// Controllers to get values from text fields
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;

  final FirebaseAuth _fireStore = FirebaseAuth.instance;

  //String? selectedCountry;

  @override
  Widget build(BuildContext context) {
      /*SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.colorPrimary,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      ));*/
    return Scaffold(
      backgroundColor: AppColors.colorPrimary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.colorPrimary,
        elevation: 0,
      ),
      body: Center(
        child: Form(
          key: _formField,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: AppColors.colorBlack,
                      fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "Just a few quick things to get started",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.colorBlack,
                  ),
                ),
                SizedBox(height: 20.h),
                userNameTextFormFieldWidget(),
                SizedBox(height: 10.h),
                emailTextFormFieldWidget(),
                SizedBox(height: 10.h),
                passwordTextFormFieldWidget(),
                SizedBox(height: 10.h),
                countryDropdownWidget(),
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  child: Container(
                    height: 50.h,
                    width: double.maxFinite,
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: AppColors.colorSecondary,
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: Center(
                      child: Text(
                        "Create account",
                        style: TextStyle(
                          fontSize: 16.sp,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "Already have an account?",
                      style: TextStyle(
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, CustomPageRouteRightToLeft(builder: (context) => SignInScreen()));
                      },
                      child: Text(
                        "Log in",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.colorOptional,
                            fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
                /*Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ElevatedButton(
                      onPressed: () async {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                        // Create the user in Firebase Authentication
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

                        print('User created successfully!');
                      },
                      child: Text('SSSS'),
                    )


                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget userNameTextFormFieldWidget(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: TextFormField(
        cursorColor: AppColors.colorSecondary,
        keyboardType: TextInputType.emailAddress,
        controller: userNameController, // sets the controller for the text input field
        style: const TextStyle(
          color: AppColors.colorBlackLight,
          fontWeight: FontWeight.w500,
        ), // sets the text style for the text input field
        decoration: InputDecoration(
          hintText: 'Username', // sets the hint text for the text input field
          hintStyle: const TextStyle(
              color: AppColors.colorDisable,
              fontWeight: FontWeight.w400
          ),
          filled: true,
          fillColor: AppColors.colorWhite,
          prefixIcon: Icon(
            Icons.person_2_outlined,
            color: AppColors.colorBlackLight,
            size: 22.sp,
          ), // sets the prefix icon for the text input field
          contentPadding: const EdgeInsets.fromLTRB(5, -0, 15, -0), // sets the padding for the text input field content
          enabledBorder: OutlineInputBorder(
            // sets the border for the enabled state of the text input field
            borderRadius: BorderRadius.circular(22),
            borderSide: const BorderSide(
              color: AppColors.colorWhite,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            // sets the border for the focused state of the text input field
            borderRadius: BorderRadius.circular(22),
            borderSide: const BorderSide(
              color: AppColors.colorWhite,
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

  Widget emailTextFormFieldWidget(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: TextFormField(
        cursorColor: AppColors.colorSecondary,
        keyboardType: TextInputType.emailAddress,
        controller: emailController, // sets the controller for the text input field
        style: TextStyle(
          fontSize: 14.sp,
          color: AppColors.colorBlackLight,
          fontWeight: FontWeight.w500,
        ), // sets the text style for the text input field
        decoration: InputDecoration(
          hintText: 'Email', // sets the hint text for the text input field
          hintStyle: const TextStyle(
            color: AppColors.colorDisable,
            fontWeight: FontWeight.w400
          ),
          filled: true,
          fillColor: AppColors.colorWhite,
          prefixIcon: Icon(
            Icons.email_outlined,
            color: AppColors.colorBlackLight,
            size: 22.sp,
          ), // sets the prefix icon for the text input field
          contentPadding: const EdgeInsets.fromLTRB(5, -0, 15, -0), // sets the padding for the text input field content
          enabledBorder: OutlineInputBorder(
            // sets the border for the enabled state of the text input field
            borderRadius: BorderRadius.circular(22),
            borderSide: const BorderSide(
              color: AppColors.colorWhite,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            // sets the border for the focused state of the text input field
            borderRadius: BorderRadius.circular(22),
            borderSide: const BorderSide(
              color: AppColors.colorWhite,
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

  Widget passwordTextFormFieldWidget(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: TextFormField(
        cursorColor: AppColors.colorSecondary,
        keyboardType: TextInputType.emailAddress,
        controller: passwordController, // sets the controller for the text input field
        style: const TextStyle(
          color: AppColors.colorBlackLight,
          fontWeight: FontWeight.w500,
        ), // sets the text style for the text input field
        decoration: InputDecoration(
          hintText: 'Password', // sets the hint text for the text input field
          hintStyle: const TextStyle(
              color: AppColors.colorDisable,
              fontWeight: FontWeight.w400
          ),
          filled: true,
          fillColor: AppColors.colorWhite,
          prefixIcon: Icon(
            Icons.password_outlined,
            color: AppColors.colorBlackLight,
            size: 22.sp,
          ), // sets the prefix icon for the text input field
          contentPadding: const EdgeInsets.fromLTRB(5, -0, 15, -0), // sets the padding for the text input field content
          enabledBorder: OutlineInputBorder(
            // sets the border for the enabled state of the text input field
            borderRadius: BorderRadius.circular(22),
            borderSide: const BorderSide(
              color: AppColors.colorWhite,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            // sets the border for the focused state of the text input field
            borderRadius: BorderRadius.circular(22),
            borderSide: const BorderSide(
              color: AppColors.colorWhite,
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

  Map<String, dynamic>? selectedCountry;

  Widget countryDropdownWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: DropdownButtonFormField<Map<String, dynamic>>(
        value: selectedCountry,
        onChanged: (Map<String, dynamic>? newValue) {
          setState(() {
            selectedCountry = newValue;
            if (newValue != null) {
              print("Selected Country: ${newValue['fullName']}, Country Code: ${newValue['countryCode']}");
            }
          });
        },
        hint: const Text(
          'Select your country',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.colorDisable,
          ),
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.colorWhite,
          prefixIcon: const Icon(
            Icons.flag_outlined,
            color: AppColors.colorBlackLight,
          ),
          contentPadding: const EdgeInsets.fromLTRB(0, -0, 16, -0),
          // sets the padding for the text input field content
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: const BorderSide(
              color: AppColors.colorWhite,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: const BorderSide(
              color: AppColors.colorWhite,
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
        items: countryList.map<DropdownMenuItem<Map<String, dynamic>>>(
              (Map<String, dynamic> value) {
            return DropdownMenuItem<Map<String, dynamic>>(
              value: value,
              child: Text(
                  value["fullName"],
                style: TextStyle(
                  fontSize: 14.sp
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }



}
