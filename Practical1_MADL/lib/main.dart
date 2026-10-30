import 'package:flutter/material.dart';

void main() {
  runApp(const EnvironmentApp());
}

class EnvironmentApp extends StatelessWidget {
  const EnvironmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Environment Setup',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F7FC),
      ),
      home: const EnvironmentPage(),
    );
  }
}

class EnvironmentPage extends StatefulWidget {
  const EnvironmentPage({super.key});

  @override
  State<EnvironmentPage> createState() =>
      _EnvironmentPageState();
}

class _EnvironmentPageState extends State<EnvironmentPage> {
  final List<String> tasks = [
    'Install Flutter SDK',
    'Configure Flutter PATH',
    'Install an IDE',
    'Configure Android SDK',
    'Run flutter doctor',
    'Run a sample Flutter application',
  ];

  final List<bool> completed = [
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    int completedCount =
        completed.where((item) => item).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Environment'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),

              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),

              child: const Column(
                children: [
                  Icon(
                    Icons.flutter_dash,
                    color: Colors.white,
                    size: 65,
                  ),

                  SizedBox(height: 12),

                  Text(
                    'Flutter Setup',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Prepare your Flutter development environment.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Setup Checklist',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Mark each step when you have completed it.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 15),

            // Progress
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$completedCount of ${tasks.length} steps completed',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 12),

                    LinearProgressIndicator(
                      value: completedCount / tasks.length,
                      minHeight: 9,
                      backgroundColor: Colors.blue.shade50,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(
                        Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Checklist items
            ...List.generate(tasks.length, (index) {
              return Card(
                margin: const EdgeInsets.only(bottom: 10),

                child: CheckboxListTile(
                  value: completed[index],

                  title: Text(tasks[index]),

                  secondary: Icon(
                    completed[index]
                        ? Icons.check_circle
                        : Icons.settings_suggest,
                    color: completed[index]
                        ? Colors.green
                        : Colors.blue,
                  ),

                  onChanged: (value) {
                    setState(() {
                      completed[index] = value ?? false;
                    });
                  },
                ),
              );
            }),

            const SizedBox(height: 15),

            // Doctor command information
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(15),
              ),

              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Flutter Diagnostic Command',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  SelectableText(
                    'flutter doctor',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Run this command in a terminal to check '
                    'your Flutter installation.',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    for (int i = 0; i < completed.length; i++) {
                      completed[i] = true;
                    }
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'All checklist items marked completed.',
                      ),
                    ),
                  );
                },

                icon: const Icon(Icons.check_circle),

                label: const Text('Complete Checklist'),

                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}