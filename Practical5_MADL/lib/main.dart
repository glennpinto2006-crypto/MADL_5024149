import 'package:flutter/material.dart';

void main() {
  runApp(const LayoutApp());
}

class LayoutApp extends StatelessWidget {
  const LayoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Layout Demo',

      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF5F6FC),
      ),

      home: const LayoutHomePage(),
    );
  }
}

class LayoutHomePage extends StatelessWidget {
  const LayoutHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Layout Demo'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header container
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),

              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(20),
              ),

              child: const Column(
                children: [
                  Icon(
                    Icons.dashboard_customize,
                    size: 55,
                    color: Colors.white,
                  ),

                  SizedBox(height: 12),

                  Text(
                    'My Dashboard',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Designed using Flutter layout widgets',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Row layout
            const Text(
              'Quick Access',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _quickCard(
                    icon: Icons.person_outline,
                    title: 'Profile',
                    color: Colors.blue,
                    background: const Color(0xFFE7F0FF),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _quickCard(
                    icon: Icons.book_outlined,
                    title: 'Courses',
                    color: Colors.green,
                    background: const Color(0xFFE6F7EE),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _quickCard(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    color: Colors.orange,
                    background: const Color(0xFFFFF1DD),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // Stack layout
            const Text(
              'Featured Section',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Stack(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,

                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF818CF8),
                        Color(0xFFA5B4FC),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),

                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                const Positioned(
                  left: 20,
                  top: 24,

                  child: Icon(
                    Icons.lightbulb_outline,
                    size: 35,
                    color: Colors.white,
                  ),
                ),

                const Positioned(
                  left: 20,
                  top: 75,

                  child: Text(
                    'Learn Something New',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const Positioned(
                  left: 20,
                  top: 110,

                  child: Text(
                    'Explore your learning journey.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ),

                Positioned(
                  right: 15,
                  bottom: 15,

                  child: Container(
                    padding: const EdgeInsets.all(10),

                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),

                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.indigo,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // Column and cards
            const Text(
              'Recent Activities',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Card(
              elevation: 1,

              child: Column(
                children: [
                  _activityTile(
                    Icons.code,
                    'Flutter Programming',
                    'Practicing UI development',
                    Colors.blue,
                  ),

                  const Divider(height: 1),

                  _activityTile(
                    Icons.school,
                    'Online Learning',
                    'Exploring Flutter widgets',
                    Colors.green,
                  ),

                  const Divider(height: 1),

                  _activityTile(
                    Icons.check_circle_outline,
                    'Practice Completed',
                    'Completed the layout exercise',
                    Colors.orange,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Expanded layout
            const Text(
              'Project Progress',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Flutter UI Project'),

                        Text(
                          '70%',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    Row(
                      children: [
                        Expanded(
                          flex: 7,

                          child: Container(
                            height: 12,

                            decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 3,

                          child: Container(
                            height: 12,

                            decoration: BoxDecoration(
                              color: Colors.indigo.shade50,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'Keep working to complete the project.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Center(
              child: Text(
                'Created with Flutter Layout Widgets',
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

  // Reusable quick-access card
  Widget _quickCard({
    required IconData icon,
    required String title,
    required Color color,
    required Color background,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 5,
      ),

      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        children: [
          Icon(
            icon,
            size: 30,
            color: color,
          ),

          const SizedBox(height: 8),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // Reusable activity tile
  Widget _activityTile(
    IconData icon,
    String title,
    String subtitle,
    Color color,
  ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.12),

        child: Icon(
          icon,
          color: color,
        ),
      ),

      title: Text(title),
      subtitle: Text(subtitle),

      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
      ),
    );
  }
}