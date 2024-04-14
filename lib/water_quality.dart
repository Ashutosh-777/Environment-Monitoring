import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'data_item.dart';
import 'globals.dart';
class WaterQuality extends StatefulWidget {
  const WaterQuality({super.key});

  @override
  State<WaterQuality> createState() => _WaterQualityState();
}

class _WaterQualityState extends State<WaterQuality> {

  ChartSeriesController<ChartData, int>? waterTempController;
  ChartSeriesController<ChartData, int>? tdsController;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final stream = positiveDataStream();
    int count = 19;
    List<ChartData> chartData = <ChartData>[
      ChartData(0, 42),
      ChartData(1, 47),
      ChartData(2, 33),
      ChartData(3, 49),
      ChartData(4, 54),
      ChartData(5, 41),
      ChartData(6, 58),
      ChartData(7, 51),
      ChartData(8, 98),
      ChartData(9, 41),
      ChartData(10, 53),
      ChartData(11, 72),
      ChartData(12, 86),
      ChartData(13, 52),
      ChartData(14, 94),
      ChartData(15, 92),
      ChartData(16, 86),
      ChartData(17, 72),
      ChartData(18, 94),
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 24,),
              GestureDetector(
                // onTap: (){
                //   chartData.add(ChartData(count, 240+count));
                //   if (chartData.length == 20) {
                //     chartData.removeAt(0);
                //     _chartSeriesController?.updateDataSource(
                //       addedDataIndexes: <int>[chartData.length - 1],
                //       removedDataIndexes: <int>[0],
                //     );
                //   } else {
                //     _chartSeriesController?.updateDataSource(
                //       addedDataIndexes: <int>[chartData.length - 1],
                //     );
                //   }
                //   count = count + 1;
                // },
                child: Container(
                  height: 405,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Constants().primaryColor,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 12,),
                      const Text('Water Quality',
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.white
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Image.asset('assets/goodwater.png',
                        width: 150,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12,),
                        child: Divider(color: Colors.white,),
                      ),
                      const Expanded(child: SizedBox()),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 66,vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DataItem(
                              value: 20,
                              unit: ' C',
                              imageUrl: 'assets/water-temperature.png',
                            ),
                            DataItem(
                              value: 62,
                              unit: 'ppm',
                              imageUrl: 'assets/water-quality.png',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                            text: 'Total Dissolved Solid',
                              textStyle: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                          plotAreaBorderWidth: 0,
                          primaryXAxis:
                          const NumericAxis(majorGridLines: MajorGridLines(width: 0)),
                          primaryYAxis: const NumericAxis(
                              axisLine: AxisLine(width: 0),
                              majorTickLines: MajorTickLines(size: 0)),
                          series: <LineSeries<ChartData, int>>[
                            LineSeries<ChartData, int>(
                              onRendererCreated:
                                  (ChartSeriesController<ChartData, int> controller) {
                                tdsController = controller;
                              },
                              dataSource: chartData,
                              color: const Color.fromRGBO(192, 108, 132, 1),
                              xValueMapper: (ChartData sales, _) => sales.index,
                              yValueMapper: (ChartData sales, _) => sales.val,
                              animationDuration: 0,
                            )
                          ]),
                      SfCartesianChart(
                          title: const ChartTitle(
                            text: 'Water Temperature',
                              textStyle: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                          plotAreaBorderWidth: 0,
                          primaryXAxis:
                          const NumericAxis(majorGridLines: MajorGridLines(width: 0)),
                          primaryYAxis: const NumericAxis(
                              axisLine: AxisLine(width: 0),
                              majorTickLines: MajorTickLines(size: 0)),
                          series: <LineSeries<ChartData, int>>[
                            LineSeries<ChartData, int>(
                              onRendererCreated:
                                  (ChartSeriesController<ChartData, int> controller) {
                                waterTempController = controller;
                              },
                              dataSource: chartData,
                              color: const Color.fromRGBO(192, 108, 132, 1),
                              xValueMapper: (ChartData sales, _) => sales.index,
                              yValueMapper: (ChartData sales, _) => sales.val,
                              animationDuration: 0,
                            )
                          ]
                      ),],
                  )
              ),
              // Display a real-time graph of positive data as points
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );

  }
  Stream<double> positiveDataStream() {
    return Stream.periodic(const Duration(milliseconds: 500), (_) {
      return Random().nextInt(3000).toDouble();
    }).asBroadcastStream();
  }
}
class ChartData {
  ChartData(this.index, this.val);
  final int index;
  final num val;
}