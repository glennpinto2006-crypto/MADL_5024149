import 'package:flutter/material.dart';

void main() {
  runApp(const NavigationApp());
}

class NavigationApp extends StatelessWidget {
  const NavigationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigation and Gestures',

      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F7FC),
      ),

      initialRoute: '/',

      routes: {
        '/': (context) => const HomePage(),
        '/about': (context) => const AboutPage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}

// =====================================================
// HOME PAGE
// =====================================================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _gestureMessage = 'Try a gesture below!';

  void _showMessage(String message) {
    setState(() {
      _gestureMessage = message;
    });
  }

  void _handleSwipe(DragEndDetails details) {
    final velocity = details.primaryVelocity;

    if (velocity == null || velocity == 0) {
      return;
    }

    if (velocity < 0) {
      _showMessage('You swiped left!');
    } else {
      _showMessage('You swiped right!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation & Gestures'),
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
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),

              child: const Column(
                children: [
                  Icon(
                    Icons.navigation,
                    color: Colors.white,
                    size: 50,
                  ),

                  SizedBox(height: 10),

                  Text(
                    'Navigation & Gestures',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 7),

                  Text(
                    'Navigate between pages and interact '
                    'with the gesture area.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Named routing
            const Text(
              'Named Routes',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/about',
                  );
                },

                icon: const Icon(Icons.info_outline),

                label: const Text('Open About Page'),
              ),
            ),

            const SizedBox(height: 8),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/profile',
                  );
                },

                icon: const Icon(Icons.person_outline),

                label: const Text('Open Profile Page'),
              ),
            ),

            const SizedBox(height: 25),

            // Gestures
            const Text(
              'Gesture Detector',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Tap, double tap, long press, or swipe '
              'the coloured area.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 15),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),

              decoration: BoxDecoration(
                color: const Color(0xFFE7EEFF),
                borderRadius: BorderRadius.circular(15),
              ),

              child: Text(
                _gestureMessage,
                textAlign: TextAlign.center,

                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),

            const SizedBox(height: 12),

            GestureDetector(
              onTap: () {
                _showMessage('Single tap detected!');
              },

              onDoubleTap: () {
                _showMessage('Double tap detected!');
              },

              onLongPress: () {
                _showMessage('Long press detected!');
              },

              onHorizontalDragEnd: _handleSwipe,

              child: Container(
                height: 190,
                width: double.infinity,

                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF6FA8F5),
                      Color(0xFF9C8AEF),
                    ],
                  ),

                  borderRadius: BorderRadius.circular(22),
                ),

                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Icon(
                      Icons.touch_app,
                      size: 60,
                      color: Colors.white,
                    ),

                    SizedBox(height: 12),

                    Text(
                      'Touch Me!',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: 8),

                    Text(
                      'Tap • Double Tap • Long Press',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      'Swipe left or right',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Direct navigation
            const Text(
              'Direct Navigation',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,

              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (context) => const DetailsPage(),
                    ),
                  );
                },

                icon: const Icon(Icons.open_in_new),

                label: const Text(
                  'Open Details using Navigator.push()',
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// ABOUT PAGE
// =====================================================

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Page'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              const Icon(
                Icons.info_outline,
                color: Colors.green,
                size: 85,
              ),

              const SizedBox(height: 20),

              const Text(
                'About This Application',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'This screen demonstrates named route '
                'navigation using Navigator.pushNamed().',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 25),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },

                icon: const Icon(Icons.arrow_back),

                label: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================
// PROFILE PAGE
// =====================================================

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              const CircleAvatar(
                radius: 55,
                backgroundColor: Color(0xFFFFE8C8),

                child: Icon(
                  Icons.person,
                  size: 65,
                  color: Colors.orange,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Student Profile',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Flutter Development Student',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 25),

              Card(
                child: Column(
                  children: const [
                    ListTile(
                      leading: Icon(Icons.school),
                      title: Text('Course'),
                      subtitle: Text('Flutter Programming'),
                    ),

                    Divider(height: 1),

                    ListTile(
                      leading: Icon(Icons.phone_android),
                      title: Text('Platform'),
                      subtitle: Text('Android'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },

                icon: const Icon(Icons.arrow_back),

                label: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================
// DETAILS PAGE
// =====================================================

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Page'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              const Icon(
                Icons.route,
                color: Colors.purple,
                size: 80,
              ),

              const SizedBox(height: 20),

              const Text(
                'Navigation Details',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'This page was opened using '
                'Navigator.push() and MaterialPageRoute.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 25),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },

                icon: const Icon(Icons.arrow_back),

                label: const Text('Return to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}