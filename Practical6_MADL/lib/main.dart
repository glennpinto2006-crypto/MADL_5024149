import 'package:flutter/material.dart';

void main() {
  runApp(const MediaDashboardApp());
}

class MediaDashboardApp extends StatelessWidget {
  const MediaDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Icons Images and Charts',

      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F7FC),
      ),

      home: const MediaDashboardPage(),
    );
  }
}

class MediaDashboardPage extends StatelessWidget {
  const MediaDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(
                color: const Color(0xFFE4EEFF),
                borderRadius: BorderRadius.circular(20),
              ),

              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.insert_chart_outlined,
                      size: 35,
                      color: Colors.blue,
                    ),
                  ),

                  SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Visual Dashboard',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF30466B),
                          ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          'Icons, images and charts',
                          style: TextStyle(
                            color: Color(0xFF637A9F),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Icons
            const Text(
              '1. Common Icons',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 22,
                  horizontal: 8,
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _iconItem(
                      Icons.home,
                      'Home',
                      Colors.blue,
                    ),

                    _iconItem(
                      Icons.person,
                      'Profile',
                      Colors.green,
                    ),

                    _iconItem(
                      Icons.favorite,
                      'Favorite',
                      Colors.red,
                    ),

                    _iconItem(
                      Icons.settings,
                      'Settings',
                      Colors.orange,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Image
            const Text(
              '2. Image Widget',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Card(
              clipBehavior: Clip.antiAlias,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    'https://picsum.photos/800/350',

                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,

                    loadingBuilder: (
                      context,
                      child,
                      loadingProgress,
                    ) {
                      if (loadingProgress == null) {
                        return child;
                      }

                      return Container(
                        height: 200,
                        color: Colors.blue.shade50,

                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },

                    errorBuilder: (
                      context,
                      error,
                      stackTrace,
                    ) {
                      return Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.blue.shade50,

                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_not_supported_outlined,
                              size: 55,
                              color: Colors.blue,
                            ),

                            SizedBox(height: 8),

                            Text(
                              'Image unavailable',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  const Padding(
                    padding: EdgeInsets.all(16),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Explore the World',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 6),

                        Text(
                          'Images can be loaded from a network '
                          'using Image.network().',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Chart
            const Text(
              '3. Weekly Activity Chart',
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
                    const Text(
                      'Weekly Performance',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      'Sample activity values',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      height: 200,

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: [
                          _bar('Mon', 70, Colors.blue),
                          _bar('Tue', 110, Colors.green),
                          _bar('Wed', 145, Colors.orange),
                          _bar('Thu', 95, Colors.purple),
                          _bar('Fri', 165, Colors.red),
                          _bar('Sat', 125, Colors.teal),
                          _bar('Sun', 85, Colors.indigo),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Information cards
            const Text(
              '4. Statistics Cards',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _statCard(
                    Icons.people,
                    'Users',
                    '1,250',
                    Colors.blue,
                    const Color(0xFFE4EEFF),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _statCard(
                    Icons.trending_up,
                    'Growth',
                    '24%',
                    Colors.green,
                    const Color(0xFFE2F7EB),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _statCard(
                    Icons.star,
                    'Rating',
                    '4.8',
                    Colors.orange,
                    const Color(0xFFFFF1DC),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _statCard(
                    Icons.task_alt,
                    'Tasks',
                    '86',
                    Colors.purple,
                    const Color(0xFFF0E8FF),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Center(
              child: Text(
                'Flutter Media Components Demo',
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

  // Icon item
  Widget _iconItem(
    IconData icon,
    String label,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          height: 48,
          width: 48,

          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(15),
          ),

          child: Icon(
            icon,
            color: color,
            size: 27,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // Bar chart item
  Widget _bar(
    String day,
    double barHeight,
    Color color,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 22,
          height: barHeight,

          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(7),
            ),
          ),
        ),

        const SizedBox(height: 8),

        Text(
          day,
          style: const TextStyle(
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  // Statistics card
  Widget _statCard(
    IconData icon,
    String title,
    String value,
    Color iconColor,
    Color backgroundColor,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 42,
              width: 42,

              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(13),
              ),

              child: Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              value,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}