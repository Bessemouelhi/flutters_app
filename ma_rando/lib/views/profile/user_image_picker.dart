import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.onPickImage});

  final void Function(File pickedImage) onPickImage;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;
  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(
      source: source,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey,
            foregroundImage:
                _pickedImageFile != null ? FileImage(_pickedImageFile!) : null),
        Row(
          children: [
            TextButton.icon(
              onPressed: () {
                _pickImage(ImageSource.camera);
              },
              icon: Icon(Icons.camera),
              label: Text(
                'Camera',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                _pickImage(ImageSource.gallery);
              },
              icon: Icon(Icons.image),
              label: Text(
                'Gallery',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ],
        )
      ],
    );
  }
}
