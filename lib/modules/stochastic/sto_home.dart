import 'package:flutter/material.dart';
import 'package:queu_project/modules/stochastic/sto_result.dart';

import '../../Shard/componets/components.dart';


class Stochastic extends StatelessWidget {
  const Stochastic({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller=TextEditingController();
    TextEditingController controller1=TextEditingController();
    TextEditingController controller2=TextEditingController();
    TextEditingController controller3=TextEditingController();
    TextEditingController controller4=TextEditingController();
    var formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Stochastic'),
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
            child: Center(
              child: SingleChildScrollView(
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
                      height: 15,
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
                      height: 15,
                    ),
                    SizedBox(
                      width: 300,
                      child: defaultFormField(
                        label: 'Servers Count',
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
                      height: 15,
                    ),
                    SizedBox(
                      width: 300,
                      child: defaultFormField(
                        label: 'System capacity',
                        controller: controller3,
                        type: TextInputType.number,
                        radius: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 300,
                      child: defaultFormField(
                        label: 'Simulation count',
                        controller: controller4,
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
                      height: 15,
                    ),
                    defaultButton(
                      function: (){
                        if(formKey.currentState!.validate()){
                          if(controller3.text.isEmpty||controller3.text.compareTo(' ')==0||controller3.text.compareTo('  ')==0){
                            navigateTo(context, StochasticResult(
                                arrival: double.parse(controller.text),
                                service: double.parse(controller1.text),
                                serversCount: int.parse(controller2.text),
                                systemCapacity:-1,
                                simulation: int.parse(controller4.text,)));
                          }else{
                            navigateTo(context, StochasticResult(
                                arrival: double.parse(controller.text),
                                service: double.parse(controller1.text),
                                serversCount: int.parse(controller2.text),
                                systemCapacity:double.parse(controller3.text),
                                simulation: int.parse(controller4.text,)));
                          }
                          controller.text='';
                          controller1.text='';
                          controller2.text='';
                          controller3.text='';
                          controller4.text='';
                        }
                      },
                      text: 'Calculate',
                      radius: 15,
                      background: Colors.deepOrange,
                      width: 250,
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}
