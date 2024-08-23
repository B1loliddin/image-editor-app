import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_editor_app/widgets/icon_button_change_text.dart';
import 'package:image_editor_app/widgets/image_edit_view_model.dart';
import 'package:image_editor_app/widgets/image_text.dart';
import 'package:image_editor_app/widgets/tooltip_change_text.dart';
import 'package:screenshot/screenshot.dart';

class ImageEditScreen extends StatefulWidget {
  const ImageEditScreen({super.key});

  @override
  State<ImageEditScreen> createState() => _ImageEditScreenState();
}

class _ImageEditScreenState extends ImageEditViewModel {
  @override
  Widget build(BuildContext context) {
    final imagePath = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 56,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              IconButtonChangeText(
                onPressed: saveImageToGallery,
                iconData: Icons.save,
              ),
              IconButtonChangeText(
                onPressed: increaseFontSize,
                iconData: Icons.text_increase,
              ),
              IconButtonChangeText(
                onPressed: decreaseFontSize,
                iconData: Icons.text_decrease,
              ),
              IconButtonChangeText(
                onPressed: alignLeft,
                iconData: Icons.format_align_left,
              ),
              IconButtonChangeText(
                onPressed: alignCenter,
                iconData: Icons.format_align_center,
              ),
              IconButtonChangeText(
                onPressed: alignRight,
                iconData: Icons.format_align_right,
              ),
              IconButton(
                onPressed: boldText,
                icon: const Icon(Icons.format_bold),
              ),
              IconButtonChangeText(
                onPressed: italicText,
                iconData: Icons.format_italic,
              ),
              IconButtonChangeText(
                onPressed: addLinesToToText,
                iconData: Icons.space_bar,
              ),
              TooltipChangeText(
                message: 'Red',
                onTap: () => changeTextColor(Colors.red),
                backgroundColor: Colors.red,
              ),
              const SizedBox(width: 5),
              TooltipChangeText(
                message: 'White',
                onTap: () => changeTextColor(Colors.white),
                backgroundColor: Colors.white,
              ),
              const SizedBox(width: 5),
              TooltipChangeText(
                message: 'Blue',
                onTap: () => changeTextColor(Colors.blue),
                backgroundColor: Colors.blue,
              ),
              const SizedBox(width: 5),
              TooltipChangeText(
                message: 'Black',
                onTap: () => changeTextColor(Colors.black),
                backgroundColor: Colors.black,
              ),
              const SizedBox(width: 5),
              TooltipChangeText(
                message: 'Yellow',
                onTap: () => changeTextColor(Colors.yellow),
                backgroundColor: Colors.yellow,
              ),
              const SizedBox(width: 5),
              TooltipChangeText(
                message: 'Green',
                onTap: () => changeTextColor(Colors.green),
                backgroundColor: Colors.green,
              ),
              const SizedBox(width: 5),
              TooltipChangeText(
                message: 'Orange',
                onTap: () => changeTextColor(Colors.orange),
                backgroundColor: Colors.orange,
              ),
              const SizedBox(width: 5),
              TooltipChangeText(
                message: 'Pink',
                onTap: () => changeTextColor(Colors.pink),
                backgroundColor: Colors.pink,
              ),
              const SizedBox(width: 5),
            ],
          ),
        ),
      ),
      body: Screenshot(
        controller: screenshotController,
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.3,
          child: Stack(
            children: [
              /// #actual image
              Center(
                child: Image(
                  fit: BoxFit.fill,
                  width: MediaQuery.sizeOf(context).width,
                  image: FileImage(File(imagePath)),
                ),
              ),

              /// #texts on image
              for (int i = 0; i < texts.length; i++)
                Positioned(
                  left: texts[i].left,
                  top: texts[i].top,
                  child: GestureDetector(
                    onTap: () => setCurrentIndex(context, i),
                    onLongPress: () {
                      currentIndex = i;

                      setState(() => deleteText());
                    },
                    child: Draggable(
                      onDragEnd: (DraggableDetails drag) {
                        final renderBox =
                            context.findRenderObject() as RenderBox;
                        final offset = renderBox.globalToLocal(drag.offset);

                        setState(() {
                          texts[i].top = offset.dy - 110;
                          texts[i].left = offset.dx;
                        });
                      },
                      feedback: ImageText(textInfoModel: texts[i]),
                      child: ImageText(textInfoModel: texts[i]),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewDialog,
        child: const Icon(Icons.edit),
      ),
    );
  }
}
