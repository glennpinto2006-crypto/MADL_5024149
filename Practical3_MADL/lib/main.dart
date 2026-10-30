import 'package:flutter/material.dart';

void main() {
  runApp(const CommonWidgetsApp());
}

class CommonWidgetsApp extends StatelessWidget {
  const CommonWidgetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Common Flutter Widgets',

      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F7FC),
      ),

      home: const WidgetsPage(),
    );
  }
}

class WidgetsPage extends StatefulWidget {
  const WidgetsPage({super.key});

  @override
  State<WidgetsPage> createState() => _WidgetsPageState();
}

class _WidgetsPageState extends State<WidgetsPage> {
  final TextEditingController nameController =
      TextEditingController();

  String selectedCourse = 'Flutter';
  String selectedGender = 'Male';

  bool isChecked = false;
  bool isSwitched = false;

  double sliderValue = 50;

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Common Widgets'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // 1. Container and Text
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(18),
              ),

              child: const Column(
                children: [
                  Icon(
                    Icons.widgets,
                    color: Colors.white,
                    size: 48,
                  ),

                  SizedBox(height: 10),

                  Text(
                    'Flutter Widget Gallery',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 6),

                  Text(
                    'Explore common Flutter widgets',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // 2. TextField
            const Text(
              'Text Input',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(15),

                child: TextField(
                  controller: nameController,

                  decoration: const InputDecoration(
                    labelText: 'Enter your name',
                    hintText: 'Your full name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 3. Dropdown
            const Text(
              'Dropdown Menu',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),

                child: DropdownButton<String>(
                  value: selectedCourse,
                  isExpanded: true,

                  items: const [
                    DropdownMenuItem(
                      value: 'Flutter',
                      child: Text('Flutter'),
                    ),
                    DropdownMenuItem(
                      value: 'Java',
                      child: Text('Java'),
                    ),
                    DropdownMenuItem(
                      value: 'Python',
                      child: Text('Python'),
                    ),
                    DropdownMenuItem(
                      value: 'Web Development',
                      child: Text('Web Development'),
                    ),
                  ],

                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        selectedCourse = value;
                      });
                    }
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 4. Buttons and Icons
            const Text(
              'Buttons and Icons',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showMessage('Submit button pressed!');
                    },
                    icon: const Icon(Icons.send),
                    label: const Text('Submit'),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      setState(() {
                        nameController.clear();
                        selectedCourse = 'Flutter';
                        selectedGender = 'Male';
                        isChecked = false;
                        isSwitched = false;
                        sliderValue = 50;
                      });

                      showMessage('Form reset successfully.');
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  IconButton(
                    onPressed: () {
                      showMessage('Home icon clicked');
                    },
                    icon: const Icon(
                      Icons.home,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      showMessage('Favorite icon clicked');
                    },
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      showMessage('Star icon clicked');
                    },
                    icon: const Icon(
                      Icons.star,
                      color: Colors.orange,
                      size: 30,
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      showMessage('Settings icon clicked');
                    },
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.green,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 5. Checkbox
            const Text(
              'Checkbox Widget',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            Card(
              child: CheckboxListTile(
                title: const Text('Accept Terms and Conditions'),
                value: isChecked,

                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value ?? false;
                  });
                },
              ),
            ),

            const SizedBox(height: 15),

            // 6. Switch
            const Text(
              'Switch Widget',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            Card(
              child: SwitchListTile(
                title: const Text('Enable Notifications'),
                subtitle: const Text('Turn notifications on or off'),
                value: isSwitched,

                onChanged: (bool value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 15),

            // 7. Radio buttons
            const Text(
              'Radio Buttons',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            Card(
              child: Column(
                children: [
                  RadioListTile<String>(
                    title: const Text('Male'),
                    value: 'Male',
                    groupValue: selectedGender,

                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          selectedGender = value;
                        });
                      }
                    },
                  ),

                  RadioListTile<String>(
                    title: const Text('Female'),
                    value: 'Female',
                    groupValue: selectedGender,

                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          selectedGender = value;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 8. Slider
            const Text(
              'Slider Widget',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(15),

                child: Column(
                  children: [
                    Slider(
                      value: sliderValue,
                      min: 0,
                      max: 100,
                      divisions: 10,

                      onChanged: (double value) {
                        setState(() {
                          sliderValue = value;
                        });
                      },
                    ),

                    Text(
                      'Selected Value: ${sliderValue.round()}',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 9. ListTile
            const Text(
              'ListTile Widgets',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: const Text('Student Profile'),
                    subtitle: const Text('View student details'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      showMessage('Student Profile selected');
                    },
                  ),

                  const Divider(),

                  ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.book),
                    ),
                    title: const Text('Courses'),
                    subtitle: const Text('Explore available courses'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      showMessage('Courses selected');
                    },
                  ),

                  const Divider(),

                  ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.settings),
                    ),
                    title: const Text('Settings'),
                    subtitle: const Text('Application settings'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      showMessage('Settings selected');
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 10. Display selected values
            Card(
              color: Colors.blue.shade50,

              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Selected Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'Name: ${nameController.text.isEmpty ? "Not entered" : nameController.text}',
                    ),

                    Text('Course: $selectedCourse'),

                    Text('Gender: $selectedGender'),

                    Text('Terms accepted: ${isChecked ? "Yes" : "No"}'),

                    Text(
                      'Notifications: ${isSwitched ? "Enabled" : "Disabled"}',
                    ),

                    Text('Slider value: ${sliderValue.round()}'),

                    const SizedBox(height: 10),

                    ElevatedButton(
                      onPressed: () {
                        setState(() {});

                        showMessage('Information refreshed');
                      },
                      child: const Text('Refresh Information'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}