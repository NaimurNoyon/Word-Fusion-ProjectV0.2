import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child:isDark ? Lottie.asset(
                'assets/lottie/background_night.json',
                fit: BoxFit.cover
            ) : Lottie.asset(
                'assets/lottie/background_day.json',
                fit: BoxFit.cover
            ),
          ),
          Positioned(
            top: 40,
            right: 16,
            child: Switch(
              activeColor: Colors.white,
              activeTrackColor: Colors.black,
              inactiveThumbColor: Colors.black,
              inactiveTrackColor: Colors.white,
              value: isDark,
              onChanged: (value) {
                setState(() {
                  isDark = value;
                });
              },
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:isDark? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Current Rank", style: TextStyle(color: isDark? Colors.black : Colors.white),),
                      Text("1",style: TextStyle(fontSize: 50, color: isDark? Colors.black : Colors.white),)
                    ],
                  ),
                ),
                const SizedBox(height: 300)
              ],
            ),
          )
        ],
      ),
    );
  }
}