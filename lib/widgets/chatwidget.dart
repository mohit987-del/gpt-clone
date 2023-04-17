import 'package:cxw7/constants/colors.dart';
import 'package:cxw7/services/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.data});
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final int num = int.parse(data["chatIndex"].toString());
    return Material(
      color: num == 1 ? cardColor : scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (num == 1)
              Column(
                children: [
                  ImageWidget(image: AssetsManager.botImage),
                  IconButton(
                    onPressed: () async {
                      await Clipboard.setData(
                        ClipboardData(
                          text: data["msg"].toString(),
                        ),
                      ).then((value) {
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 500),
                            content: Text("Text Copied !!"),
                          ),
                        );
                      });
                      // copied successfully
                    },
                    splashRadius: 25,
                    icon: const Icon(
                      Icons.copy,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            TextWidget(
              label: data["msg"].toString(),
              left: num == 1,
            ),
            if (num == 0) ImageWidget(image: AssetsManager.userImage),
            const Divider(
              thickness: 50,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
