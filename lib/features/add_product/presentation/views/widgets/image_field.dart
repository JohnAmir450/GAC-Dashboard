import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gac_dashboard/core/utils/app_colors.dart';
import 'package:image_picker/image_picker.dart';

class ImageField extends StatefulWidget {
  final ValueChanged<File?> onChanged;
  const ImageField({super.key, required this.onChanged});

  @override
  State<ImageField> createState() => _ImageFieldState();
}

class _ImageFieldState extends State<ImageField> {
  bool isLoading = false;
  File? fileImage;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          isLoading = true;
        });
        try {
          await pickImage();
        } catch (e) {
          setState(() {
            isLoading = false;
          });
        }
        setState(() {
          isLoading = false;
        });
        // Pick an image
      },
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey, width: 0.5),
            ),
            child: fileImage != null
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                      fileImage!,
                      fit: BoxFit.cover,
                    ),
                )
                : const Icon(
                    Icons.image_outlined,
                    size: 180,
                    color: AppColors.lightPrimaryColor,
                  ),
          ),
          Visibility(
          visible: fileImage != null,
            child: IconButton(onPressed: (){
            setState(() {
              fileImage = null;
               widget.onChanged(fileImage);
            });
          }, icon: CircleAvatar(child: Icon(Icons.close),)))
        ],
      ),
    );
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    fileImage = File(image!.path);
    widget.onChanged(fileImage!);
  }
}
