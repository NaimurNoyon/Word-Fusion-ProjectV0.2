import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:word_fusion/Screens/home_screen.dart';
import 'Screens/puzzle_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try{
    // Initialize Firebase first before other services
    await Firebase.initializeApp();
    print("Firebase initialize successfully");
  } catch(error){
    print("Can't initialize firebase");
    print("$error");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child){
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Word Fusion',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: /*const AlphabetDragAndDrop(coinAmount: 10,),*/
              const HomeScreen()
          );
        }
    );
  }
}

