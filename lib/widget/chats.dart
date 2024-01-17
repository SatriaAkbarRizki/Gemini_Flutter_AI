import 'dart:io';

import 'package:aispeak/provider/pickimage_provider.dart';
import 'package:aispeak/provider/result_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Chats extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  Chats({super.key});

  bool doScroll(bool isScrollDown) {
    if (isScrollDown == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(seconds: 2),
              curve: Curves.fastOutSlowIn);
        }
      });
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final watchValue = context.watch<String>();
    final imageConvert = Provider.of<PickImageProvider>(context);
    final value = Provider.of<ResultProvider>(context);
    value.isScroll = doScroll(value.isScroll);
    return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowIndicator();
          return true;
        },
        child: ListView.builder(
          controller: _scrollController,
          itemCount: value.listChat.length,
          itemBuilder: (context, index) {
            if (value.listChat[index].isCurrentUser == true) {
              return Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(value.listChat[index].value,
                              style: Theme.of(context).textTheme.titleSmall,
                              textAlign: TextAlign.right),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Consumer<ResultProvider>(
                    builder: (context, valueImage, child) {
                      if (valueImage.listChat[index].image == null) {
                        return const SizedBox();
                      } else {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            height: 200,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            padding: const EdgeInsets.all(5),
                            child: Image.file(
                              imageConvert.imageConvert(
                                  File(valueImage.listChat[index].image!)),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              );
            } else {
              if (watchValue.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardTheme.color,
                              borderRadius: BorderRadius.circular(10)),
                          child: Lottie.asset(
                            "assets/animation/AnimationLoading.json",
                            fit: BoxFit.cover,
                            height: 50,
                            width: 100,
                          ))),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardTheme.color,
                        ),
                        child: Markdown(
                            selectable: true,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            data: value.listChat[index].value),
                      )),
                );
              }
            }
          },
        ));
  }
}
