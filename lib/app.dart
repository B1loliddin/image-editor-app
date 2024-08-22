import 'package:flutter/material.dart';
import 'package:image_editor_app/screens/home_screen.dart';
import 'package:image_editor_app/screens/image_edit_screen.dart';

class ImageEditorApp extends StatelessWidget {
  const ImageEditorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image Editor',
      theme: ThemeData.light(),
      routes: {
        '/': (_) => HomeScreen(),
        '/image_edit_screen': (_) => ImageEditScreen(),
      },
      initialRoute: '/',
    );
  }
}
