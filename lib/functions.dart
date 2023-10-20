
import 'package:flutter/foundation.dart';




Future<int>  simpleTask1Future(List number) async {
  var sum  = 0;

  final value = await Future.wait<int>(
    number.map((e) async {
      final data = await simpleTask2Future(e);

      return data;

    }).toList()
  );

  sum = value.reduce((value, element) => value + element);

  return sum;
}

Future<int>  simpleTask2Future(int data) async {

  await Future.delayed(const Duration(seconds: 1), () {   
    debugPrint('simpleTask2Future: $data');
  });

  return data;
}