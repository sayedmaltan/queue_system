// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class DeterministicResult extends StatelessWidget {
  late dynamic arrival;
  late dynamic service;
  late dynamic time;
  late dynamic capacity;

  DeterministicResult(
      {super.key,
      required this.arrival,
      required this.service,
      required this.time,
      required this.capacity});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deterministic Result'),
        backgroundColor: Colors.black,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Text('$arrival'),
            Text('$service'),
            Text('$time'),
            Text('$capacity'),
          ],
        ),
      ),
    );
  }
}
