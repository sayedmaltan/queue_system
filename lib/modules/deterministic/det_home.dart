import 'package:flutter/material.dart';

import '../../Shard/componets/components.dart';
import 'det_result.dart';


class Deterministic extends StatelessWidget {
  const Deterministic({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller=TextEditingController();
    TextEditingController controller1=TextEditingController();
    TextEditingController controller2=TextEditingController();
    TextEditingController controller3=TextEditingController();
    var formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Deterministic'),
        actions: const [
          Icon(
              Icons.indeterminate_check_box_outlined
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                SizedBox(
                  width: 300,
                  child: defaultFormField(

                    label: 'Arrival rate',
                    controller: controller,
                    type: TextInputType.number,
                    validate: (String value){
                      if(value.isEmpty){
                        return 'Enter Value';
                      }
                    },
                    radius: 15,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 300,
                  child: defaultFormField(
                    label: 'Service rate',
                    controller: controller1,
                    type: TextInputType.number,
                    validate: (String value){
                      if(value.isEmpty){
                        return 'Enter Value';
                      }
                    },
                    radius: 15,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 300,
                  child: defaultFormField(
                    label: 'Time',
                    controller: controller2,
                    type: TextInputType.number,
                    validate: (String value){
                      if(value.isEmpty){
                        return 'Enter Value';
                      }
                    },
                    radius: 15,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 300,
                  child: defaultFormField(
                    label: 'System capacity',
                    controller: controller3,
                    type: TextInputType.number,
                    validate: (String value){
                      if(value.isEmpty){
                        return 'Enter Value';
                      }
                    },
                    radius: 15,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultButton(
                  function: (){
                    if(formKey.currentState!.validate()){
                      navigateTo(context,DeterministicResult(arrival: controller.text,service: controller1.text,time: controller2.text,capacity: controller3.text,));
                      controller.text='';
                      controller1.text='';
                      controller2.text='';
                      controller3.text='';
                    }
                  },
                  text: 'Calculate',
                  radius: 15,
                  background: Colors.deepOrange,
                  width: 250,
                ),
              ],
            ),
          )
      ),
    );
  }
}
