import 'dart:io';
import 'package:aispeak/provider/bubleimage_provider.dart';
import 'package:aispeak/provider/pickimage_provider.dart';
import 'package:aispeak/provider/result_provider.dart';
import 'package:aispeak/provider/user_provider.dart';
import 'package:aispeak/widget/bubbles_image.dart';
import 'package:aispeak/widget/custom_dialog.dart';
import 'package:aispeak/widget/chats.dart';
import 'package:aispeak/widget/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  String? _imageResult;
  String imageResult = '';
  final FocusNode focusKeyboard = FocusNode();
  final TextEditingController messagesController = TextEditingController();
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    final databaseUser = Provider.of<UserProvider>(context);
    final imageDecode = Provider.of<PickImageProvider>(context, listen: false);
    final stream = Provider.of<ResultProvider>(context, listen: false);
    final showBubbles = Provider.of<BubbleProvider>(context, listen: false);
    databaseUser.getAllData();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text('Gemini Flutter AI ',
            style: Theme.of(context).textTheme.titleMedium),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
                style: const ButtonStyle(
                    shape: MaterialStatePropertyAll(CircleBorder())),
                onPressed: () {
                  Future.delayed(
                    const Duration(milliseconds: 100),
                    () => showDialog(
                      context: context,
                      builder: (context) => CustomProfile(),
                    ),
                  );
                },
                child: Consumer<UserProvider>(
                  builder: (context, value, child) {
                    if (value.data.isEmpty) {
                      return const CircleAvatar(
                        backgroundImage: AssetImage('assets/image/robot.png'),
                        backgroundColor: Colors.blue,
                      );
                    } else if (value.data[0].image == null) {
                      return const Icon(size: 18, Icons.people);
                    } else {
                      return CircleAvatar(
                        backgroundColor: Colors.blue,
                        backgroundImage: FileImage(imageDecode
                            .imageConvert(File(value.data[0].image!))),
                      );
                    }
                  },
                )),
          )
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Builder(
                builder: (context) {
                  if (stream.listChat.isEmpty) {
                    return const WelcomeWidget();
                  } else {
                    return Expanded(
                      child: StreamProvider(
                        create: (_) => stream.fetchData(),
                        initialData: '',
                        child: Chats(),
                      ),
                    );
                  }
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: IconButton(
                              onPressed: () async {
                                await imageDecode.gettingImage().then((value) {
                                  _imageResult = value;
                                  imageResult = value;
                                  showBubbles.changeBool();
                                });
                              },
                              icon: const Icon(
                                Icons.image,
                                size: 28,
                              )),
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: messagesController,
                            focusNode: focusKeyboard,
                            style: const TextStyle(
                                fontSize: 16,
                                backgroundColor: Colors.transparent),
                            maxLength: 200,
                            decoration: InputDecoration(
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(15)),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(15)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(15)),
                                hintText: 'Message Gemini Flutter'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: IconButton(
                              onPressed: () {
                                if (messagesController.text.isNotEmpty) {
                                  stream.newChat(
                                      messagesController.text, _imageResult);
                                  _imageResult = null;
                                  messagesController.clear();
                                  focusKeyboard.unfocus();
                                  showBubbles.changeBool();
                                  _imageResult = null;
                                }
                              },
                              icon: const Icon(
                                Icons.send,
                                size: 28,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Visibility(
            visible: stream.listChat.isEmpty ? false : true,
            child: Container(
              padding: const EdgeInsets.only(bottom: 120),
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                  onPressed: () {
                    stream.scrollDownList();
                  },
                  child: const Icon(
                    Icons.arrow_downward,
                    color: Colors.white,
                  )),
            ),
          ),
          BubblesWidget(haveImage: _imageResult, imageResult: imageResult)
        ],
      ),
    );
  }
}
