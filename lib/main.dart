import 'package:custom_layouts_test/custom_widget/my_custom_slider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  num progress = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                child: TextFormField(
                  decoration: const InputDecoration(hintText: 'progress'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    num? newProgress = num.tryParse(value);
                    if (newProgress != null && newProgress >= 0 && newProgress <= 100) {
                      setState(() {
                        progress = newProgress;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              MyCustomSlider(
                progress: progress,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
