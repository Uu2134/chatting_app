import 'package:chatting_app/screens/imagefeed-screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:chatting_app/services/firebase_services.dart';

class ImagePickerWidget extends StatefulWidget {
  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();
  File? _imageFile;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile != null && _usernameController.text.isNotEmpty && _captionController.text.isNotEmpty) {
      try {
        await FirebaseService().uploadImage(
          _imageFile!,
          _usernameController.text.trim(),
          _captionController.text.trim(),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image uploaded successfully')),
        );
        setState(() {
          _imageFile = null;
          _usernameController.clear();
          _captionController.clear();
        });
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ImageFeedScreen()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload image: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an image and fill in all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Image')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: _captionController,
                decoration: InputDecoration(labelText: 'Caption'),
              ),
              SizedBox(height: 20),
              if (_imageFile != null)
                Container(
                  constraints: BoxConstraints(
                    maxHeight: 300,
                  ),
                  child: Image.file(_imageFile!),
                ),
              SizedBox(height: 20),
              if (_imageFile != null)
                ElevatedButton(
                  onPressed: _uploadImage,
                  child: Text('Upload Image'),
                )
              else
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Pick Image'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
