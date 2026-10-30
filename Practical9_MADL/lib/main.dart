import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

// -----------------------------------------------------
// FIREBASE CONFIGURATION
// Replace these values with your actual Firebase values.
// -----------------------------------------------------

const String firebaseDatabaseUrl =
    'PASTE_YOUR_REALTIME_DATABASE_URL_HERE';

const String firebaseApiKey =
    'PASTE_YOUR_WEB_API_KEY_HERE';

const String firebaseAppId =
    'PASTE_YOUR_WEB_APP_ID_HERE';

const String firebaseMessagingSenderId =
    'PASTE_YOUR_MESSAGING_SENDER_ID_HERE';

const String firebaseProjectId =
    'PASTE_YOUR_PROJECT_ID_HERE';

// -----------------------------------------------------
// MAIN
// -----------------------------------------------------

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: firebaseApiKey,
      appId: firebaseAppId,
      messagingSenderId: firebaseMessagingSenderId,
      projectId: firebaseProjectId,
      databaseURL: firebaseDatabaseUrl,
    ),
  );

  runApp(const FirebaseStudentApp());
}

// -----------------------------------------------------
// APPLICATION
// -----------------------------------------------------

class FirebaseStudentApp extends StatelessWidget {
  const FirebaseStudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Student Manager',

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6F7CE8),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F6FC),
      ),

      home: const StudentPage(),
    );
  }
}

// -----------------------------------------------------
// STUDENT PAGE
// -----------------------------------------------------

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final TextEditingController _nameController =
      TextEditingController();

  final TextEditingController _emailController =
      TextEditingController();

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();

  late final DatabaseReference _studentsRef;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();

    _studentsRef = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: firebaseDatabaseUrl,
    ).ref('students');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ---------------------------------------------------
  // CREATE: ADD STUDENT
  // ---------------------------------------------------

  Future<void> _addStudent() async {
    if (_isSaving) return;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      await _studentsRef.push().set({
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'createdAt': DateTime.now().toIso8601String(),
      });

      if (!mounted) return;

      _nameController.clear();
      _emailController.clear();

      _showMessage('Student saved to Firebase successfully!');
    } catch (e) {
      _showMessage('Unable to save student: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  // ---------------------------------------------------
  // UPDATE: EDIT STUDENT
  // ---------------------------------------------------

  Future<void> _editStudent(
    String id,
    String oldName,
    String oldEmail,
  ) async {
    final nameController =
        TextEditingController(text: oldName);

    final emailController =
        TextEditingController(text: oldEmail);

    try {
      final shouldUpdate = await showDialog<bool>(
        context: context,

        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Edit Student'),

            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Student Name',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),

            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext, false);
                },
                child: const Text('Cancel'),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.pop(dialogContext, true);
                },
                child: const Text('Update'),
              ),
            ],
          );
        },
      );

      if (shouldUpdate != true) return;

      final name = nameController.text.trim();
      final email = emailController.text.trim();

      if (name.isEmpty || email.isEmpty) {
        _showMessage('Name and email cannot be empty.');
        return;
      }

      if (!email.contains('@')) {
        _showMessage('Please enter a valid email address.');
        return;
      }

      await _studentsRef.child(id).update({
        'name': name,
        'email': email,
      });

      _showMessage('Student updated successfully!');
    } catch (e) {
      _showMessage('Unable to update student: $e');
    } finally {
      nameController.dispose();
      emailController.dispose();
    }
  }

  // ---------------------------------------------------
  // DELETE: REMOVE STUDENT
  // ---------------------------------------------------

  Future<void> _deleteStudent(
    String id,
    String name,
  ) async {
    final shouldDelete = await showDialog<bool>(
      context: context,

      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Student'),

          content: Text(
            'Are you sure you want to delete $name?',
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) return;

    try {
      await _studentsRef.child(id).remove();
      _showMessage('Student deleted successfully!');
    } catch (e) {
      _showMessage('Unable to delete student: $e');
    }
  }

  // ---------------------------------------------------
  // USER INTERFACE
  // ---------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Firebase Students',
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
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFE4E8FF),
                    Color(0xFFF0EAFF),
                  ],
                ),
                borderRadius: BorderRadius.circular(22),
              ),

              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.cloud_sync_outlined,
                    color: Color(0xFF6F70D8),
                    size: 45,
                  ),

                  SizedBox(height: 12),

                  Text(
                    'Student Database',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF454575),
                    ),
                  ),

                  SizedBox(height: 7),

                  Text(
                    'Manage student records with Firebase '
                    'Realtime Database.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6F709B),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Add New Student',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 13),

            // Form
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Form(
                  key: _formKey,

                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,

                        decoration: const InputDecoration(
                          labelText: 'Student Name',
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                        ),

                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'Enter student name';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 15),

                      TextFormField(
                        controller: _emailController,

                        keyboardType: TextInputType.emailAddress,

                        decoration: const InputDecoration(
                          labelText: 'Email Address',
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(),
                        ),

                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'Enter email address';
                          }

                          if (!RegExp(
                            r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                          ).hasMatch(value.trim())) {
                            return 'Enter a valid email';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 18),

                      SizedBox(
                        width: double.infinity,
                        height: 48,

                        child: ElevatedButton.icon(
                          onPressed:
                              _isSaving ? null : _addStudent,

                          icon: _isSaving
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.cloud_upload_outlined),

                          label: Text(
                            _isSaving
                                ? 'Saving...'
                                : 'Save to Firebase',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 26),

            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Student Records',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const Icon(
                  Icons.sync,
                  color: Colors.green,
                ),

                const SizedBox(width: 5),

                Text(
                  'Live',
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 13),

            // Real-time database listener
            StreamBuilder<DatabaseEvent>(
              stream: _studentsRef.onValue,

              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18),

                      child: Text(
                        'Database error: ${snapshot.error}\n\n'
                        'Check your database URL and security rules.',
                      ),
                    ),
                  );
                }

                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(25),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final records =
                    snapshot.data?.snapshot.children.toList() ?? [];

                if (records.isEmpty) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(30),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: const Column(
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 48,
                          color: Colors.grey,
                        ),

                        SizedBox(height: 10),

                        Text(
                          'No student records yet',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          'Add your first student above.',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return Column(
                  children: records.map((record) {
                    final id = record.key ?? '';

                    final rawValue = record.value;

                    if (rawValue is! Map) {
                      return const SizedBox.shrink();
                    }

                    final data =
                        Map<dynamic, dynamic>.from(rawValue);

                    final name =
                        data['name']?.toString() ?? 'Unknown';

                    final email =
                        data['email']?.toString() ?? '';

                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),

                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 5,
                        ),

                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFFE7EAFF),

                          child: Icon(
                            Icons.person,
                            color: Color(0xFF6F70D8),
                          ),
                        ),

                        title: Text(
                          name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        subtitle: Text(email),

                        trailing: PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'edit') {
                              _editStudent(id, name, email);
                            }

                            if (value == 'delete') {
                              _deleteStudent(id, name);
                            }
                          },

                          itemBuilder: (context) => const [
                            PopupMenuItem(
                              value: 'edit',
                              child: Row(
                                children: [
                                  Icon(Icons.edit_outlined),
                                  SizedBox(width: 10),
                                  Text('Edit'),
                                ],
                              ),
                            ),

                            PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete_outline,
                                    color: Colors.red,
                                  ),
                                  SizedBox(width: 10),
                                  Text('Delete'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}