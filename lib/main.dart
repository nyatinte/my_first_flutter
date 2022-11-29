import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '通話アプリデモ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '通話アプリデモ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final addressMaxLen = 13;
  String address = '';

  void _addAddress(String value) {
    if (address.length < addressMaxLen) {
      setState(() {
        address += value;
      });
    }
  }

  void _resetAddress() {
    setState(() {
      address = '';
    });
  }

  void _removeAddress() {
    setState(() {
      address = address.substring(0, address.length - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  for (final number in numbers)
                    CircleButton(
                      onPressed: () => _addAddress(number.toString()),
                      child: Text('$number'),
                    ),
                  CircleButton(
                      onPressed: () => _resetAddress(),
                      child: const Icon(Icons.clear)),
                  CircleButton(
                    onPressed: () => _addAddress('0'),
                    child: const Text('0'),
                  ),
                  CircleButton(
                      onPressed: () => _removeAddress(),
                      child: const Icon(Icons.keyboard_backspace)),
                ],
              ),
              Text(
                address,
                style: const TextStyle(fontSize: 32),
              ),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {},
                  child: const Icon(Icons.call))
            ],
          )),
    );
  }
}

class CircleButton extends StatelessWidget {
  const CircleButton({super.key, required this.onPressed, required this.child});

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return TextButton(
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(
          Size(size.width / 4, size.width / 4),
        ),
        shape: MaterialStateProperty.all<CircleBorder>(
          CircleBorder(side: BorderSide(color: Colors.black)),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
