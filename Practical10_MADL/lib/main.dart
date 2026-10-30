import 'package:flutter/material.dart';

void main() {
  runApp(const ReleaseApp());
}

// =====================================================
// MAIN APPLICATION
// =====================================================

class ReleaseApp extends StatelessWidget {
  const ReleaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Release Readiness',

      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C7CE8),
        ),

        scaffoldBackgroundColor: const Color(0xFFF5F7FC),
      ),

      home: const ReleaseDashboard(),
    );
  }
}

// =====================================================
// RELEASE TASK MODEL
// =====================================================

class ReleaseTask {
  final String title;
  final String description;
  final String category;

  bool completed;

  ReleaseTask({
    required this.title,
    required this.description,
    required this.category,
    this.completed = false,
  });
}

// =====================================================
// DASHBOARD
// =====================================================

class ReleaseDashboard extends StatefulWidget {
  const ReleaseDashboard({super.key});

  @override
  State<ReleaseDashboard> createState() =>
      _ReleaseDashboardState();
}

class _ReleaseDashboardState extends State<ReleaseDashboard> {
  final List<ReleaseTask> _tasks = [
    ReleaseTask(
      title: 'Test on Android Emulator',
      description:
          'Verify screen layouts, buttons, navigation and input validation.',
      category: 'Testing',
    ),

    ReleaseTask(
      title: 'Test on Physical Device',
      description:
          'Check performance, touch interactions and screen compatibility.',
      category: 'Testing',
    ),

    ReleaseTask(
      title: 'Check All User Interactions',
      description:
          'Test important features and verify expected results.',
      category: 'Testing',
    ),

    ReleaseTask(
      title: 'Run Flutter Analyzer',
      description:
          'Review code for errors, warnings and potential issues.',
      category: 'Debugging',
    ),

    ReleaseTask(
      title: 'Review Error Handling',
      description:
          'Verify validation, failure messages and unexpected conditions.',
      category: 'Debugging',
    ),

    ReleaseTask(
      title: 'Review Application Code',
      description:
          'Check code quality, unused code and resource management.',
      category: 'Debugging',
    ),

    ReleaseTask(
      title: 'Set Application Version',
      description:
          'Confirm the application version and build number.',
      category: 'Release Build',
    ),

    ReleaseTask(
      title: 'Configure Release Signing',
      description:
          'Configure and protect the Android release signing key.',
      category: 'Release Build',
    ),

    ReleaseTask(
      title: 'Build Release APK',
      description:
          'Generate and test the signed Android APK.',
      category: 'Release Build',
    ),

    ReleaseTask(
      title: 'Build Android App Bundle',
      description:
          'Generate the AAB artifact for Google Play.',
      category: 'Release Build',
    ),

    ReleaseTask(
      title: 'Prepare Store Listing',
      description:
          'Prepare the app name, description, icon and screenshots.',
      category: 'Deployment',
    ),

    ReleaseTask(
      title: 'Review Privacy and Data Safety',
      description:
          'Prepare accurate privacy disclosures and required declarations.',
      category: 'Deployment',
    ),

    ReleaseTask(
      title: 'Prepare Play Console Release',
      description:
          'Upload the signed AAB and test using an internal testing track.',
      category: 'Deployment',
    ),
  ];

  String _selectedCategory = 'All';

  int get _completedCount =>
      _tasks.where((task) => task.completed).length;

  double get _progress =>
      _tasks.isEmpty ? 0 : _completedCount / _tasks.length;

  List<ReleaseTask> get _visibleTasks {
    if (_selectedCategory == 'All') {
      return _tasks;
    }

    return _tasks
        .where((task) => task.category == _selectedCategory)
        .toList();
  }

  void _toggleTask(ReleaseTask task, bool? value) {
    setState(() {
      task.completed = value ?? false;
    });
  }

  void _markAllReviewed() {
    setState(() {
      for (final task in _tasks) {
        task.completed = true;
      }
    });

    _showMessage('All checklist items marked as reviewed.');
  }

  void _resetChecklist() {
    setState(() {
      for (final task in _tasks) {
        task.completed = false;
      }
    });

    _showMessage('Checklist reset.');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSummary() {
    final remaining = _tasks.length - _completedCount;

    showDialog<void>(
      context: context,

      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Release Readiness Summary'),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total items: ${_tasks.length}'),

              const SizedBox(height: 8),

              Text('Completed: $_completedCount'),

              const SizedBox(height: 8),

              Text('Remaining: $remaining'),

              const SizedBox(height: 15),

              LinearProgressIndicator(
                value: _progress,
                minHeight: 8,
              ),

              const SizedBox(height: 12),

              Text(
                remaining == 0
                    ? 'All checklist items are marked reviewed.'
                    : 'Review the remaining items before release.',
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Release Readiness',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFE3E9FF),
                    Color(0xFFF0E9FF),
                  ],
                ),

                borderRadius: BorderRadius.circular(22),
              ),

              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.verified_user_outlined,
                    color: Color(0xFF6776D9),
                    size: 45,
                  ),

                  SizedBox(height: 14),

                  Text(
                    'Android Release',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF414C88),
                    ),
                  ),

                  SizedBox(height: 7),

                  Text(
                    'Test, review and prepare your Flutter '
                    'application for release.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6F76A7),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 23),

            // Progress
            const Text(
              'Readiness Overview',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 13),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '$_completedCount of ${_tasks.length} items reviewed',

                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        Text(
                          '${(_progress * 100).round()}%',

                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xFF6C7CE8),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),

                      child: LinearProgressIndicator(
                        value: _progress,
                        minHeight: 10,
                        backgroundColor: const Color(0xFFE6E9F5),
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(
                          Color(0xFF6C7CE8),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      _completedCount == _tasks.length
                          ? 'All checklist items have been reviewed.'
                          : 'Complete the necessary checks before release.',

                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Summary cards
            Row(
              children: [
                Expanded(
                  child: _summaryCard(
                    icon: Icons.check_circle_outline,
                    title: 'Reviewed',
                    value: '$_completedCount',
                    background: const Color(0xFFE0F5EA),
                    iconColor: Colors.green,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _summaryCard(
                    icon: Icons.pending_actions,
                    title: 'Remaining',
                    value: '${_tasks.length - _completedCount}',
                    background: const Color(0xFFFFF0DC),
                    iconColor: Colors.orange,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Text(
              'Release Checklist',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Tick each item after actually performing the task.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 15),

            // Category filter
            Wrap(
              spacing: 8,
              runSpacing: 8,

              children: [
                'All',
                'Testing',
                'Debugging',
                'Release Build',
                'Deployment',
              ].map((category) {
                final selected =
                    _selectedCategory == category;

                return ChoiceChip(
                  label: Text(category),
                  selected: selected,

                  onSelected: (_) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 15),

            // Checklist items
            ..._visibleTasks.map((task) {
              final color = _categoryColor(task.category);

              return Card(
                margin: const EdgeInsets.only(bottom: 10),

                child: CheckboxListTile(
                  value: task.completed,

                  onChanged: (value) {
                    _toggleTask(task, value);
                  },

                  controlAffinity:
                      ListTileControlAffinity.leading,

                  secondary: Container(
                    width: 42,
                    height: 42,

                    decoration: BoxDecoration(
                      color: color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(13),
                    ),

                    child: Icon(
                      _categoryIcon(task.category),
                      color: color,
                    ),
                  ),

                  title: Text(
                    task.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,

                      decoration: task.completed
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),

                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5),

                    child: Text(
                      '${task.description}\n${task.category}',
                      style: const TextStyle(
                        fontSize: 11,
                      ),
                    ),
                  ),

                  isThreeLine: true,
                ),
              );
            }),

            const SizedBox(height: 20),

            // Action buttons
            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                onPressed: _showSummary,

                icon: const Icon(Icons.assessment_outlined),

                label: const Text('View Release Summary'),

                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                ),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,

              child: OutlinedButton.icon(
                onPressed: _markAllReviewed,

                icon: const Icon(Icons.done_all),

                label: const Text('Mark All as Reviewed'),
              ),
            ),

            const SizedBox(height: 8),

            SizedBox(
              width: double.infinity,

              child: TextButton.icon(
                onPressed: _resetChecklist,

                icon: const Icon(Icons.refresh),

                label: const Text('Reset Checklist'),
              ),
            ),

            const SizedBox(height: 22),

            // Build command information
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: const Color(0xFFE8EEFF),
                borderRadius: BorderRadius.circular(18),
              ),

              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.terminal,
                    color: Color(0xFF596DD4),
                    size: 30,
                  ),

                  SizedBox(height: 10),

                  Text(
                    'Android Release Commands',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4658A4),
                    ),
                  ),

                  SizedBox(height: 12),

                  SelectableText(
                    'flutter analyze',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 8),

                  SelectableText(
                    'flutter test',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 8),

                  SelectableText(
                    'flutter build apk --release',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 8),

                  SelectableText(
                    'flutter build appbundle --release',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 12),

                  Text(
                    'Run these commands from a supported Flutter '
                    'terminal. The checklist does not execute them.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6370A5),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Center(
              child: Text(
                'Flutter Android Deployment Practical',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Summary card
  Widget _summaryCard({
    required IconData icon,
    required String title,
    required String value,
    required Color background,
    required Color iconColor,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,

              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(13),
              ),

              child: Icon(
                icon,
                color: iconColor,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              value,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Category colors
  Color _categoryColor(String category) {
    switch (category) {
      case 'Testing':
        return Colors.blue;

      case 'Debugging':
        return Colors.orange;

      case 'Release Build':
        return Colors.purple;

      case 'Deployment':
        return Colors.green;

      default:
        return Colors.indigo;
    }
  }

  // Category icons
  IconData _categoryIcon(String category) {
    switch (category) {
      case 'Testing':
        return Icons.phone_android;

      case 'Debugging':
        return Icons.bug_report_outlined;

      case 'Release Build':
        return Icons.build_circle_outlined;

      case 'Deployment':
        return Icons.cloud_upload_outlined;

      default:
        return Icons.check_circle_outline;
    }
  }
}