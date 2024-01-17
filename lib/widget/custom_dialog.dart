import 'dart:io';

import 'package:aispeak/provider/pickimage_provider.dart';
import 'package:aispeak/provider/textcontroll_provider.dart';
import 'package:aispeak/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:aispeak/provider/theme_provider.dart';

class CustomProfile extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();
  CustomProfile({super.key});
  final double padding = 20, avatarRadius = 35, spacingWIdget = 20;
  bool inClick = true;

  @override
  Widget build(BuildContext context) {
    final providerUsername = Provider.of<UserProvider>(context, listen: false);
    final textUser = Provider.of<TextProvider>(context, listen: false);
    textEditingController.text = providerUsername.data.isEmpty
        ? textUser.username
        : providerUsername.data[0].username.toString();

    return Dialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(padding)),
      elevation: 0,
      child: contentBox(),
    );
  }

  Widget contentBox() {
    return Consumer4<ThemeProvider, PickImageProvider, UserProvider,
        TextProvider>(
      builder: (context, consumerTheme, consumerImage, consumerDatabase,
              consumerText, child) =>
          Container(
        height: 460,
        padding: EdgeInsets.only(
          left: padding,
          top: avatarRadius,
          right: padding,
        ),
        // margin: EdgeInsets.only(top: padding),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(padding),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Flexible(
              flex: 2,
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Profile',
                  style: TextStyle(
                      fontFamily: 'Urbaninst',
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(
              height: spacingWIdget,
            ),
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: CircleAvatar(
                      backgroundImage: consumerDatabase.data.isEmpty
                          ? const AssetImage("assets/image/robot.png")
                          : consumerDatabase.data[0].image != null
                              ? FileImage(consumerImage.imageConvert(
                                      File(consumerDatabase.data[0].image!)))
                                  as ImageProvider
                              : const AssetImage("assets/image/robot.png"),
                      radius: avatarRadius,
                    ),
                  ),
                  Positioned(
                      left: 100,
                      child: ElevatedButton(
                          onPressed: () {
                            consumerImage.gettingImage().then((value) async {
                              if (consumerDatabase.data.isEmpty) {
                                consumerDatabase.insertData(
                                    textEditingController.text.isEmpty
                                        ? 'Not have username'
                                        : textEditingController.text,
                                    value.toString());
                              } else {
                                consumerDatabase.updateData(
                                    textEditingController.text.isEmpty
                                        ? 'Not have username'
                                        : textEditingController.text,
                                    value.toString());
                              }
                            });
                          },
                          child: const Icon(Icons.edit)))
                ],
              ),
            ),
            SizedBox(
              height: spacingWIdget,
            ),
            Flexible(
              child: Align(
                alignment: Alignment.center,
                child: TextField(
                  controller: textEditingController,
                  onSubmitted: (value) async {

                    consumerText.serUsername(value);
                    if (consumerDatabase.data.isEmpty) {
                      await consumerDatabase.insertData(
                          value,
                          consumerImage.image == null
                              ? null
                              : consumerImage.image!.path.toString());
                    } else {
                      await consumerDatabase.updateData(
                          value,
                          consumerImage.image!.path.toString() ==
                                  consumerDatabase.data[0].image
                              ? consumerDatabase.data[0].image.toString()
                              : consumerImage.image!.path.toString());
                    }
                  },
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
            ),
            const Flexible(
              flex: 2,
              child: SizedBox(
                height: 20,
              ),
            ),
            const Flexible(
              child: Text(
                'Mode Theme',
                style: TextStyle(fontFamily: 'Urbaninst', fontSize: 20),
              ),
            ),
            const Flexible(
              child: SizedBox(
                height: 25,
              ),
            ),
            Flexible(
              flex: 2,
              child: SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: AnimatedToggleSwitch<bool>.dual(
                  current: consumerTheme.themeValue,
                  first: false,
                  second: true,
                  style: const ToggleStyle(
                    borderColor: Colors.transparent,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 1.5),
                      ),
                    ],
                  ),
                  onChanged: (valueSwith) {
                    if (inClick == consumerTheme.themeValue) {
                      inClick = true;
                    } else {
                      inClick = false;
                    }
                    consumerTheme.changeTheme(inClick);
                  },
                  styleBuilder: (value) => value
                      ? const ToggleStyle(
                          backgroundColor: Colors.black,
                          indicatorColor: Colors.transparent,
                        )
                      : const ToggleStyle(
                          backgroundColor: Colors.white,
                          indicatorColor: Colors.transparent,
                        ),
                  iconBuilder: (value) => value
                      ? Image.asset(
                          "assets/Icons/moon.png",
                          color: Colors.white,
                          scale: 25,
                        )
                      : const Icon(Icons.sunny, color: Colors.amber),
                  textBuilder: (value) => value
                      ? const Center(
                          child: Text(
                            'Dark',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Urbaninst',
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      : const Center(
                          child: Text('Ligth',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Urbaninst',
                                  fontWeight: FontWeight.w600)),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
