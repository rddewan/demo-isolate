import 'dart:isolate';

import 'package:demo_isolate/functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int count = 0;
  bool isLoading = false;
  List number = [1,2,3,4,5,6,7,8,10];

  void updateCounter(int value) {
    setState(() {
      count = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () async {

                  setState(() {
                    isLoading = true;
                    count = 0;
                  });

                  final value = await Isolate.run(() => simpleTask1Future(number));
                  //final value = await simpleTask1Future(number);
                  //final value = await compute(simpleTask1Future, number);
                  
                  updateCounter(value);

                  setState(() {
                    isLoading = false;
                  });
                }, 
                child: const Text('Run Task'),
              ),

              const SizedBox(height: 16,),

              Text(count.toString()),              

              if (isLoading) ...[
                const CircularProgressIndicator.adaptive()
              ]
            ],
          ),
        ),
      ),
    );
  }
}
