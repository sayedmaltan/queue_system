
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../Shard/componets/constant.dart';



class StochasticResult extends StatelessWidget {
  late dynamic arrival;
  late dynamic service;
  late dynamic serversCount;
  late dynamic systemCapacity;
  late dynamic simulation;
  StochasticResult(
      {super.key,
        required this.arrival,
        required this.service,
        required this.serversCount,
        required this.systemCapacity,
        required this.simulation,
      });

  @override
  Widget build(BuildContext context) {
    module1=module(c:serversCount,k:systemCapacity);

    switch(module1){
      case 'M/M/1':
        generateArrivalTimeListMM1(arrival, simulation);
        generateServiceTimeList(service, simulation);
        generateServiceTimeBeginEndList(simulation);
        generateTable(simulation);
        break ;
      case 'M/M/1/K' :
        generateAllListsOfMM1K(arrival,service,simulation,systemCapacity);
        generateTable(simulation);
        break;
      case 'M/M/C' :
        generateAllListsOfMMC(arrival,service,simulation,serversCount);
        genrateTableMMC(simulation);
        break;
      case 'M/M/C/K':
        generateAllListsOfMM1K(arrival,service,simulation,systemCapacity);
        genrateTableMMC(simulation);
    }
    generateNoCustomer();
    maxInClock=maxNumber(listClock);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stochastic Result'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 60,
                ),
                //Text('$summation')
                Text(
                    '$module1',
              style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
        ),
                ),
                //             Text(
        //         ' no customers$noCustomer',
        //   style: const TextStyle(
        //   fontSize: 30,
        //   fontWeight: FontWeight.bold,
        // ),
        //     ),
        // //     Text(
        // //         'EVENT $eventType',
        // //   style: const TextStyle(
        // //   fontSize: 30,
        // //   fontWeight: FontWeight.bold,
        // // ),
        // //     ),
        //     Text(
        //         '  CUSTOMER $customerNumber',
        //   style: const TextStyle(
        //   fontSize: 30,
        //   fontWeight: FontWeight.bold,
        // ),
        //     ),
            // Text(
        //         ' no CUSTOMER $noCustomer',
        //   style: const TextStyle(
        //   fontSize: 30,
        //   fontWeight: FontWeight.bold,
        // ),
        //     ),
        //     Text(
        //         'CLOCK $listClock',
        //   style: const TextStyle(
        //   fontSize: 30,
        //   fontWeight: FontWeight.bold,
        // ),
        //     ),
        //     Text(
        //         'Draw ${getFlSpot()}',
        //   style: const TextStyle(
        //   fontSize: 30,
        //   fontWeight: FontWeight.bold,
        // ),
        //     ),
        //     Text(
        //         'B $randArrivalTimeList',
        //   style: const TextStyle(
        //   fontSize: 30,
        //   fontWeight: FontWeight.bold,
        // ),
        //     ),
        //     Text(
        //         'C $timeServiceBegin',
        //   style: const TextStyle(
        //   fontSize: 30,
        //   fontWeight: FontWeight.bold,
        // ),
        //     ),
        //     Text(
        //         'D $randServTimeList}',
        //   style: const TextStyle(
        //   fontSize: 30,
        //   fontWeight: FontWeight.bold,
        // ),
        //     ),
        //     Text(
        //         'E $timeServiceEnd}',
        //   style: const TextStyle(
        //   fontSize: 30,
        //   fontWeight: FontWeight.bold,
        // ),
        //     ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                    'L = ${result('L',arrival , service,serversCount,systemCapacity)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                    'Lq = ${result('Lq',arrival , service,serversCount,systemCapacity)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                    'W = ${result('W',arrival , service,serversCount,systemCapacity)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                    'Wq = ${result('Wq',arrival , service,serversCount,systemCapacity)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),

              ],
            ),
            Center(
              child: SingleChildScrollView(
                child: SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: LineChart(
                    LineChartData(
                      minX: 0,
                      maxX: maxInClock.toDouble(),
                      minY: 0,
                      maxY: yAxsis(systemCapacity,simulation).toDouble(),
                      backgroundColor:Colors.white ,
                      lineBarsData: [
                        LineChartBarData(
                          spots: getFlSpot(),
                          isCurved: false,
                          dotData: FlDotData(show: false),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'System Chart',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlueAccent
              ),
            ),
          ],
        ),
      ),
    );
  }
}


