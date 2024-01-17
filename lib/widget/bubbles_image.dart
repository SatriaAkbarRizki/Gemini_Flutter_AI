import 'dart:io';

import 'package:aispeak/provider/bubleimage_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/pickimage_provider.dart';

class BubblesWidget extends StatelessWidget {
  String imageResult;
  String? haveImage;
  BubblesWidget(
      {required this.haveImage, required this.imageResult, super.key});

  @override
  Widget build(BuildContext context) {
    final imageDecode = Provider.of<PickImageProvider>(context);
    return Consumer<BubbleProvider>(
      builder: (context, value, child) {
        if (haveImage != null) {
          return Visibility(
            visible: value.inClose == false ? false : true,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 10, bottom: 100, right: 10),
                height: 80,
                width: 130,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                padding: const EdgeInsets.all(5),
                child: Image.file(
                  imageDecode.imageConvert(File(imageResult)),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
