import 'package:flutter/material.dart';
import 'appFunction.dart';

void main() {
  runApp(const BMI());
}

class BMI extends StatelessWidget {
  const BMI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: appFuntion(),
    );
  }
}
