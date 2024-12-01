import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Profile Page',
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  File? _profileImage;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _selectProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _submitProfile() {
    setState(() {
      // Do nothing, just update the UI
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Profile Page'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'Enter your name',
            ),
          ),
          TextField(
            controller: _ageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter your age',
            ),
          ),
          ElevatedButton(
            onPressed: _selectProfileImage,
            child: Text('Upload Profile Picture'),
          ),
          ElevatedButton(
            onPressed: _submitProfile,
            child: Text('Submit'),
          ),
          if (_profileImage != null)
            Image.file(
              _profileImage!,
              width: 200,
              height: 200,
            )
          else
            Image.asset(
              'assets/placeholder_image.png',
              width: 200,
              height: 200,
            ),
          Text('Name: ${_nameController.text}'),
          Text('Age: ${_ageController.text}'),
        ],
      ),
    );
  }
}
