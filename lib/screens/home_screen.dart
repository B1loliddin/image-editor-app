import 'package:flutter/material.dart';
import 'package:image_editor_app/helpers/show_snack_bar.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToImageEditScreen(Object? arguments) => Navigator.pushNamed(
          context,
          '/image_edit_screen',
          arguments: arguments,
        );

    void getImage() async {
      XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (file != null) {
        navigateToImageEditScreen(file.path);
      } else {
        if (context.mounted) showSnackBar(context, 'Pick an image');
      }
    }

    return Scaffold(
      body: Center(
        child: IconButton(
          onPressed: getImage,
          icon: const Icon(Icons.upload_file),
        ),
      ),
    );
  }
}
