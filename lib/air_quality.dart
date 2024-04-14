import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'data_item.dart';
import 'globals.dart';
import 'model.dart';

class AirQuality extends StatefulWidget {
  const AirQuality({super.key});

  @override
  State<AirQuality> createState() => _AirQualityState();
}

class _AirQualityState extends State<AirQuality> {
  ChartSeriesController<Reading, int>? temperatureController;
  ChartSeriesController<Reading, int>? humidityController;
  ChartSeriesController<Reading, int>? gasController;
  int count = 19;
  int tempCount = 0;
  List<Reading> chartData = <Reading>[
    Reading(0, 42),
    Reading(1, 47),
    Reading(2, 33),
    Reading(3, 49),
    Reading(4, 54),
    Reading(5, 41),
    Reading(6, 58),
    Reading(7, 51),
    Reading(8, 98),
    Reading(9, 41),
    Reading(10, 53),
    Reading(11, 72),
    Reading(12, 86),
    Reading(13, 52),
    Reading(14, 94),
    Reading(15, 92),
    Reading(16, 86),
    Reading(17, 72),
    Reading(18, 94),
  ];
  List<Reading> tempData = <Reading>[];
  List<Reading> humidData = <Reading>[];
  List<Reading> gasSensorData = <Reading>[];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white30,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 430,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Constants().primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(.1),
                        offset: const Offset(0, 25),
                        blurRadius: 3,
                        spreadRadius: -10,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      const Text(
                        'Air Quality',
                        style: TextStyle(fontSize: 32, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        'assets/greenAir.png',
                        width: 150,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 24,
                        ),
                        child: Divider(
                          color: Colors.white,
                        ),
                      ),
                      // Text('Good Air Quality',
                      //   style: TextStyle(
                      //     fontSize: 42,
                      //     fontWeight: FontWeight.bold,
                      //     foreground: Paint()
                      //       ..shader = Constants().shader,
                      //   ),
                      // ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DataItem(
                              value: 20,
                              unit: '',
                              imageUrl: 'assets/thermometer.png',
                            ),
                            DataItem(
                              value: 62,
                              unit: '%',
                              imageUrl: 'assets/humidity.png',
                            ),
                            DataItem(
                              value: 750,
                              unit: ' PPM',
                              imageUrl: 'assets/mq135.png',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                height: size.height * 0.15,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Constants().primaryColor,
                ),
                child: const Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            'Guwahati',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Present AQI Index: 153',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Unhealthy',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              SizedBox(
                  width: double.infinity,
                  height: 350,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      SfCartesianChart(
                          title: const ChartTitle(
                              text: 'Temperature',
                              textStyle: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold)),
                          plotAreaBorderWidth: 0,
                          primaryXAxis: const NumericAxis(
                            majorGridLines: MajorGridLines(width: 0),
                          ),
                          primaryYAxis: const NumericAxis(
                              axisLine: AxisLine(width: 0),
                              majorTickLines: MajorTickLines(size: 0)),
                          series: <LineSeries<Reading, int>>[
                            LineSeries<Reading, int>(
                              onRendererCreated:
                                  (ChartSeriesController<Reading, int>
                                      controller) {
                                temperatureController = controller;
                              },
                              dataSource: chartData,
                              color: const Color.fromRGBO(192, 108, 132, 1),
                              xValueMapper: (Reading sales, _) => sales.index,
                              yValueMapper: (Reading sales, _) => sales.val,
                              animationDuration: 0,
                            )
                          ]),
                      SfCartesianChart(
                          title: const ChartTitle(
                              text: 'Humidity',
                              textStyle: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold)),
                          plotAreaBorderWidth: 0,
                          primaryXAxis: const NumericAxis(
                              majorGridLines: MajorGridLines(width: 0)),
                          primaryYAxis: const NumericAxis(
                              maximum: 100,
                              axisLine: AxisLine(width: 0),
                              majorTickLines: MajorTickLines(size: 0)),
                          series: <LineSeries<Reading, int>>[
                            LineSeries<Reading, int>(
                              onRendererCreated:
                                  (ChartSeriesController<Reading, int>
                                      controller) {
                                humidityController = controller;
                              },
                              dataSource: chartData,
                              color: const Color.fromRGBO(192, 108, 132, 1),
                              xValueMapper: (Reading sales, _) => sales.index,
                              yValueMapper: (Reading sales, _) => sales.val,
                              animationDuration: 0,
                            )
                          ]),
                      SfCartesianChart(
                          title: const ChartTitle(
                              text: 'Gas Sensor',
                              textStyle: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold)),
                          plotAreaBorderWidth: 0,
                          primaryXAxis: const NumericAxis(
                              majorGridLines: MajorGridLines(width: 0)),
                          primaryYAxis: const NumericAxis(
                              axisLine: AxisLine(width: 0),
                              majorTickLines: MajorTickLines(size: 0)),
                          series: <LineSeries<Reading, int>>[
                            LineSeries<Reading, int>(
                              onRendererCreated:
                                  (ChartSeriesController<Reading, int>
                                      controller) {
                                gasController = controller;
                              },
                              dataSource: chartData,
                              color: const Color.fromRGBO(192, 108, 132, 1),
                              xValueMapper: (Reading sales, _) => sales.index,
                              yValueMapper: (Reading sales, _) => sales.val,
                              animationDuration: 0,
                            )
                          ]),
                    ],
                  )),
              // Display a real-time graph of positive data as points
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Reading {
  Reading(this.index, this.val);
  final int index;
  final num val;
}
