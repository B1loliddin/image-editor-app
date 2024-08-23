import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_editor_app/helpers/request_permission.dart';
import 'package:image_editor_app/helpers/show_snack_bar.dart';
import 'package:image_editor_app/models/text_info_model.dart';
import 'package:image_editor_app/screens/image_edit_screen.dart';
import 'package:image_editor_app/widgets/default_button.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

abstract class ImageEditViewModel extends State<ImageEditScreen> {
  late final TextEditingController dialogTextController;
  late final ScreenshotController screenshotController;
  List<TextInfoModel> texts = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _initAllController();
  }

  @override
  void dispose() {
    _disposeAllController();
    super.dispose();
  }

  void _initAllController() {
    dialogTextController = TextEditingController();
    screenshotController = ScreenshotController();
  }

  void _disposeAllController() {
    dialogTextController.dispose();
  }

  void _navigateToImageEditScreen() => Navigator.pop(context);

  void _addNewText() {
    setState(() {
      texts.add(
        TextInfoModel(
          text: dialogTextController.text.trim(),
          left: 0,
          top: 0,
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          textAlign: TextAlign.left,
        ),
      );
    });

    dialogTextController.clear();
    _navigateToImageEditScreen();
  }

  void addNewDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Text'),
          content: TextField(
            controller: dialogTextController,
            maxLines: 5,
            decoration: const InputDecoration(
              filled: true,
              hintText: 'Write...',
              border: UnderlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
          ),
          actions: [
            DefaultButton(
              color: Colors.white,
              onPressed: _navigateToImageEditScreen,
              child: const Text(
                'Back',
                style: TextStyle(color: Colors.black),
              ),
            ),
            DefaultButton(
              color: Colors.green,
              onPressed: _addNewText,
              child: const Text(
                'Add Text',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void setCurrentIndex(BuildContext context, int index) {
    setState(() => currentIndex = index);

    showSnackBar(context, 'Selected for styling');
  }

  void changeTextColor(Color color) =>
      setState(() => texts[currentIndex].color = color);

  void increaseFontSize() => setState(() => texts[currentIndex].fontSize++);

  void decreaseFontSize() => setState(() => texts[currentIndex].fontSize--);

  void alignLeft() =>
      setState(() => texts[currentIndex].textAlign = TextAlign.left);

  void alignCenter() =>
      setState(() => texts[currentIndex].textAlign = TextAlign.center);

  void alignRight() =>
      setState(() => texts[currentIndex].textAlign = TextAlign.right);

  void boldText() {
    setState(() {
      if (texts[currentIndex].fontWeight == FontWeight.bold) {
        texts[currentIndex].fontWeight = FontWeight.normal;
      } else {
        texts[currentIndex].fontWeight = FontWeight.bold;
      }
    });
  }

  void italicText() {
    setState(() {
      if (texts[currentIndex].fontStyle == FontStyle.italic) {
        texts[currentIndex].fontStyle = FontStyle.normal;
      } else {
        texts[currentIndex].fontStyle = FontStyle.italic;
      }
    });
  }

  void addLinesToToText() {
    setState(() {
      if (texts[currentIndex].text.contains('\n')) {
        texts[currentIndex].text =
            texts[currentIndex].text.replaceAll('\n', ' ');
      } else {
        texts[currentIndex].text =
            texts[currentIndex].text.replaceAll(' ', '\n');
      }
    });
  }

  void deleteText() {
    setState(() => texts.removeAt(currentIndex));

    showSnackBar(context, 'Text deleted');
  }

  void saveImage(Uint8List imageBytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');

    final name = 'screenshot_$time';

    await requestPermission(Permission.storage);
    await ImageGallerySaver.saveImage(imageBytes, name: name);

    if (mounted) showSnackBar(context, 'Image added to gallery');
  }

  void saveImageToGallery() {
    if (texts.isNotEmpty) {
      screenshotController.capture().then(
            (Uint8List? imageBytes) => saveImage(imageBytes!),
            onError: (error) => debugPrint(error),
          );
    }
  }
}
