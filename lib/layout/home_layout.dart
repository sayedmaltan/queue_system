import 'package:flutter/material.dart';

import '../Shard/componets/components.dart';
import '../modules/deterministic/det_home.dart';
import '../modules/stochastic/sto_home.dart';


class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Queue System'),
        actions: const [

          Icon(
            Icons.queue
          ),
          SizedBox(
            width: 20,
          ),
        ],
        backgroundColor: Colors.black,
      ),

      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                'Chose System type',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            defaultButton(
              text: 'Deterministic',
              function: (){
                navigateTo(context,const Deterministic());
              },
              background: Colors.deepOrange,
              width: 250,
              radius: 15,
            ),
            const SizedBox(
              height: 20,
            ),
            defaultButton(
              text: 'Stochastic',
              function: (){
                navigateTo(context,const Stochastic());
              },
              background: Colors.deepOrange,
              width: 250,
              radius: 15,
            )
          ],
        ),
      ),
    );
  }
}
