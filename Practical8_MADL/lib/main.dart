import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';

void main() {
  runApp(const FileManagementApp());
}

class FileManagementApp extends StatelessWidget {
  const FileManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'File Manager',

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7A75E8),
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F7FC),
      ),

      home: const FileManagementPage(),
    );
  }
}

class FileManagementPage extends StatefulWidget {
  const FileManagementPage({super.key});

  @override
  State<FileManagementPage> createState() =>
      _FileManagementPageState();
}

class _FileManagementPageState
    extends State<FileManagementPage> {
  final TextEditingController _controller =
      TextEditingController();

  String _fileName = 'No file selected';
  String _status = 'Ready to work with files';
  String _referenceId = 'Not generated';

  bool _isBusy = false;

  @override
  void dispose() {
    _controller.dispose();
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

  // Generate a reference number using dart:math.
  void _generateReference() {
    final random = Random();

    setState(() {
      _referenceId =
          'DOC-${100000 + random.nextInt(900000)}';

      _status = 'Reference number generated';
    });

    _showMessage('Reference number generated');
  }

  // Import a TXT or JSON file.
  Future<void> _importFile() async {
    if (_isBusy) return;

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['txt', 'json'],
        withData: true,
      );

      if (result == null || result.files.isEmpty) {
        return;
      }

      final file = result.files.single;
      final bytes = file.bytes;

      if (bytes == null) {
        _showMessage('Unable to read the selected file.');
        return;
      }

      String content = utf8.decode(bytes);

      // If JSON is selected, display its note field
      // when available. Otherwise show formatted JSON.
      if (file.extension?.toLowerCase() == 'json') {
        try {
          final dynamic decoded = jsonDecode(content);

          if (decoded is Map && decoded['note'] is String) {
            content = decoded['note'] as String;
          } else {
            content = const JsonEncoder.withIndent('  ')
                .convert(decoded);
          }
        } catch (_) {
          _showMessage('The selected JSON file is invalid.');
          return;
        }
      }

      if (!mounted) return;

      setState(() {
        _controller.text = content;
        _fileName = file.name;
        _status = 'File imported successfully';
      });

      _showMessage('File imported successfully');
    } catch (e) {
      _showMessage('Unable to import file: $e');
    }
  }

  // Export the editor content as a text file.
  Future<void> _exportText() async {
    final content = _controller.text;

    if (content.trim().isEmpty) {
      _showMessage('Enter some text before exporting.');
      return;
    }

    setState(() {
      _isBusy = true;
    });

    try {
      await FileSaver.instance.saveFile(
        name: 'flutter_notes',
        bytes: Uint8List.fromList(utf8.encode(content)),
        fileExtension: 'txt',
        mimeType: MimeType.text,
      );

      if (!mounted) return;

      setState(() {
        _fileName = 'flutter_notes.txt';
        _status = 'Text file exported successfully';
      });

      _showMessage('Text file exported successfully');
    } catch (e) {
      _showMessage('Unable to export text file: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isBusy = false;
        });
      }
    }
  }

  // Encode content as JSON and export it.
  Future<void> _exportJson() async {
    final content = _controller.text;

    if (content.trim().isEmpty) {
      _showMessage('Enter some text before exporting.');
      return;
    }

    final Map<String, dynamic> document = {
      'referenceId': _referenceId,
      'fileName': _fileName,
      'note': content,
      'createdAt': DateTime.now().toIso8601String(),
    };

    final String jsonContent =
        const JsonEncoder.withIndent('  ').convert(document);

    setState(() {
      _isBusy = true;
    });

    try {
      await FileSaver.instance.saveFile(
        name: 'flutter_notes',
        bytes: Uint8List.fromList(
          utf8.encode(jsonContent),
        ),
        fileExtension: 'json',
        mimeType: MimeType.text,
      );

      if (!mounted) return;

      setState(() {
        _fileName = 'flutter_notes.json';
        _status = 'JSON file exported successfully';
      });

      _showMessage('JSON file exported successfully');
    } catch (e) {
      _showMessage('Unable to export JSON: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isBusy = false;
        });
      }
    }
  }

  // Clear the editor.
  void _clearContent() {
    setState(() {
      _controller.clear();
      _fileName = 'No file selected';
      _status = 'Editor cleared';
    });

    _showMessage('Editor cleared');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'File Manager',
          style: TextStyle(fontWeight: FontWeight.bold),
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
                    Color(0xFFE7E5FF),
                    Color(0xFFF0EEFF),
                  ],
                ),
                borderRadius: BorderRadius.circular(22),
              ),

              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.folder_open_rounded,
                    color: Color(0xFF7168D8),
                    size: 45,
                  ),

                  SizedBox(height: 12),

                  Text(
                    'Libraries & Files',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF494477),
                    ),
                  ),

                  SizedBox(height: 7),

                  Text(
                    'Import, edit and export text or JSON files.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF76719C),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // Reference ID
            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFE8F0FF),
                  child: Icon(
                    Icons.tag,
                    color: Colors.blue,
                  ),
                ),

                title: const Text('Document Reference'),

                subtitle: Text(_referenceId),

                trailing: IconButton(
                  onPressed: _generateReference,
                  tooltip: 'Generate reference',
                  icon: const Icon(
                    Icons.refresh,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 22),

            const Text(
              'File Operations',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // Import
            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                onPressed: _isBusy ? null : _importFile,
                icon: const Icon(Icons.upload_file),
                label: const Text('Import TXT / JSON File'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Editor
            TextField(
              controller: _controller,
              minLines: 7,
              maxLines: 12,

              decoration: InputDecoration(
                labelText: 'File Content',
                hintText: 'Type your text here...',
                alignLabelWithHint: true,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(bottom: 115),
                  child: Icon(Icons.edit_document),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Save as TXT
            SizedBox(
              width: double.infinity,

              child: OutlinedButton.icon(
                onPressed: _isBusy ? null : _exportText,
                icon: const Icon(Icons.description_outlined),
                label: const Text('Export as TXT'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(14),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Save as JSON
            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                onPressed: _isBusy ? null : _exportJson,
                icon: const Icon(Icons.data_object),
                label: const Text('Export as JSON'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF756CDD),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(14),
                ),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,

              child: TextButton.icon(
                onPressed: _isBusy ? null : _clearContent,
                icon: const Icon(Icons.delete_outline),
                label: const Text('Clear Editor'),
              ),
            ),

            const SizedBox(height: 22),

            // Current file
            Card(
              child: Padding(
                padding: const EdgeInsets.all(17),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Current File',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        const Icon(
                          Icons.insert_drive_file_outlined,
                          color: Color(0xFF756CDD),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Text(
                            _fileName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    const Divider(),

                    const SizedBox(height: 8),

                    const Text(
                      'Status',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      _status,
                      style: const TextStyle(
                        color: Colors.green,
                      ),
                    ),

                    if (_isBusy) ...[
                      const SizedBox(height: 15),
                      const LinearProgressIndicator(),
                    ],
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