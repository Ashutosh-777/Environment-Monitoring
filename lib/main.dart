import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iot/soil_quality.dart';
import 'package:iot/water_quality.dart';

import 'air_quality.dart';
import 'globals.dart';
import 'nav_bar.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int index = 0;
  final PageController _pageController = PageController();
  final tabs = [
    const AirQuality(),
    const WaterQuality(),
    const SoilQuality(),
  ];
  void changeIndex(int index) {
    setState(() {
      this.index = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final stream = positiveDataStream();
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Constants().primaryColor,
            title: const Center(child: Text('Environment Monitoring',
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.w400
              ),
            )),
          ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              this.index = index;
            });
          },
          children: tabs,
        ),
        bottomNavigationBar: BottomAppBar(
          notchMargin: 10.0,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            height: 70,
            color: Colors.transparent,
            child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              NavBarItem(
                assetImage: 'assets/air.png',
                title: "Air Quality",
                index: 0,
                onTap: changeIndex,
                isSelected: index == 0,
              ),
              NavBarItem(
                  assetImage: 'assets/water.png',
                  title: "Water Quality",
                  index: 1,
                  isSelected: index == 1,
                  onTap: changeIndex),
              NavBarItem(
                  assetImage: 'assets/soil.png',
                  title: "Soil Quality",
                  isSelected: index == 3,
                  index: 3,
                  onTap: changeIndex)
            ]),
          ),
        ),
      ),
    );
  }
  Stream<double> positiveDataStream() {
    return Stream.periodic(const Duration(milliseconds: 500), (_) {
      return Random().nextInt(3000).toDouble();
    }).asBroadcastStream();
  }
}

