import 'package:flutter/material.dart';

void main() {
  runApp(const FormApp());
}

class FormApp extends StatelessWidget {
  const FormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Interactive Student Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F7FC),
      ),
      home: const StudentFormPage(),
    );
  }
}

class StudentFormPage extends StatefulWidget {
  const StudentFormPage({super.key});

  @override
  State<StudentFormPage> createState() => _StudentFormPageState();
}

class _StudentFormPageState extends State<StudentFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController =
      TextEditingController();

  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _phoneController =
      TextEditingController();

  String _course = 'Flutter';
  String _gender = 'Male';

  double _age = 20;

  bool _notifications = true;
  bool _acceptedTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submitForm() {
    // Validate text fields.
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Validate terms acceptance.
    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please accept the terms and conditions.',
          ),
        ),
      );
      return;
    }

    // Display submitted information.
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Registration Successful'),

          content: SingleChildScrollView(
            child: Text(
              'Name: ${_nameController.text}\n\n'
              'Email: ${_emailController.text}\n\n'
              'Phone: ${_phoneController.text}\n\n'
              'Course: $_course\n\n'
              'Gender: $_gender\n\n'
              'Age: ${_age.round()}\n\n'
              'Notifications: '
              '${_notifications ? "Enabled" : "Disabled"}',
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _resetForm() {
    setState(() {
      _formKey.currentState?.reset();

      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();

      _course = 'Flutter';
      _gender = 'Male';
      _age = 20;

      _notifications = true;
      _acceptedTerms = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Registration'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Form(
          key: _formKey,

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
                      Icons.assignment_ind,
                      color: Colors.white,
                      size: 55,
                    ),

                    SizedBox(height: 10),

                    Text(
                      'Student Registration Form',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 6),

                    Text(
                      'Enter your details below',
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              // Name
              TextFormField(
                controller: _nameController,

                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                  filled: true,
                  fillColor: Colors.white,
                ),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your name';
                  }

                  if (value.trim().length < 2) {
                    return 'Name must contain at least 2 characters';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Email
              TextFormField(
                controller: _emailController,

                keyboardType: TextInputType.emailAddress,

                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  hintText: 'example@gmail.com',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                  filled: true,
                  fillColor: Colors.white,
                ),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your email';
                  }

                  final emailPattern =
                      RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

                  if (!emailPattern.hasMatch(value.trim())) {
                    return 'Enter a valid email address';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Phone
              TextFormField(
                controller: _phoneController,

                keyboardType: TextInputType.phone,

                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter 10-digit phone number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                  filled: true,
                  fillColor: Colors.white,
                ),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your phone number';
                  }

                  if (!RegExp(r'^[0-9]{10}$')
                      .hasMatch(value.trim())) {
                    return 'Enter a valid 10-digit phone number';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 25),

              // Course selection
              const Text(
                'Select Course',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),

                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(10),
                ),

                child: DropdownButton<String>(
                  value: _course,
                  isExpanded: true,
                  underline: const SizedBox(),

                  items: const [
                    DropdownMenuItem(
                      value: 'Flutter',
                      child: Text('Flutter Development'),
                    ),
                    DropdownMenuItem(
                      value: 'Java',
                      child: Text('Java Programming'),
                    ),
                    DropdownMenuItem(
                      value: 'Python',
                      child: Text('Python Programming'),
                    ),
                    DropdownMenuItem(
                      value: 'Web Development',
                      child: Text('Web Development'),
                    ),
                  ],

                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _course = value;
                      });
                    }
                  },
                ),
              ),

              const SizedBox(height: 22),

              // Gender selection
              const Text(
                'Select Gender',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              RadioListTile<String>(
                title: const Text('Male'),
                value: 'Male',
                groupValue: _gender,

                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _gender = value;
                    });
                  }
                },
              ),

              RadioListTile<String>(
                title: const Text('Female'),
                value: 'Female',
                groupValue: _gender,

                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _gender = value;
                    });
                  }
                },
              ),

              // Age slider
              const SizedBox(height: 15),

              Text(
                'Age: ${_age.round()} years',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Slider(
                value: _age,
                min: 15,
                max: 60,
                divisions: 45,

                label: _age.round().toString(),

                onChanged: (value) {
                  setState(() {
                    _age = value;
                  });
                },
              ),

              const SizedBox(height: 15),

              // Notifications
              Card(
                child: SwitchListTile(
                  title: const Text('Enable Notifications'),
                  subtitle: const Text(
                    'Receive course announcements',
                  ),

                  value: _notifications,

                  onChanged: (value) {
                    setState(() {
                      _notifications = value;
                    });
                  },
                ),
              ),

              const SizedBox(height: 8),

              // Terms
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,

                title: const Text(
                  'I accept the terms and conditions',
                ),

                value: _acceptedTerms,

                onChanged: (value) {
                  setState(() {
                    _acceptedTerms = value ?? false;
                  });
                },
              ),

              const SizedBox(height: 20),

              // Submit
              SizedBox(
                width: double.infinity,
                height: 50,

                child: ElevatedButton.icon(
                  onPressed: _submitForm,

                  icon: const Icon(Icons.check_circle),

                  label: const Text(
                    'SUBMIT FORM',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                height: 48,

                child: OutlinedButton.icon(
                  onPressed: _resetForm,

                  icon: const Icon(Icons.refresh),

                  label: const Text('RESET FORM'),
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}