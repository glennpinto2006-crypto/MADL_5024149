import 'package:flutter/material.dart';

void main() {
  runApp(const HelloWorldApp());
}

class HelloWorldApp extends StatelessWidget {
  const HelloWorldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hello World App',

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: const HelloWorldPage(),
    );
  }
}

class HelloWorldPage extends StatelessWidget {
  const HelloWorldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My First Flutter App'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            const Icon(
              Icons.flutter_dash,
              color: Colors.blue,
              size: 90,
            ),

            const SizedBox(height: 20),

            const Text(
              'Hello World!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Welcome to Flutter Programming',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Hello World from Flutter!'),
                  ),
                );
              },

              child: const Text('Click Me'),
            ),
          ],
        ),
      ),
    );
  }
}