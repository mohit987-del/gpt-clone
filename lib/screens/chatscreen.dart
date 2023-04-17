import 'package:cxw7/providers/models.dart';
import 'package:cxw7/services/api_serv.dart';
import 'package:cxw7/widgets/chatwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../services/assets_manager.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _texting = false;
  final TextEditingController _chat = TextEditingController();
  final List<Map<String, dynamic>> chatlist = [];
  final FocusNode _focus = FocusNode();
  final ScrollController _scroll = ScrollController();
  @override
  Widget build(BuildContext context) {
    final mod = Provider.of<ModelsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            AssetsManager.openAiImage,
          ),
        ),
        title: const SizedBox(child: Text("ChatGPT")),
        actions: [
          IconButton(
            onPressed: () {
              //_scroll.jumpTo(_scroll.position.minScrollExtent);
              _scroll.animateTo(
                _scroll.position.minScrollExtent,
                duration: const Duration(milliseconds: 200),
                curve: Curves.fastOutSlowIn,
              );
            },
            icon: const Icon(Icons.arrow_upward),
            splashRadius: 25,
          ),
          IconButton(
            onPressed: () {
              // _scroll.jumpTo(_scroll.position.maxScrollExtent);
              _scroll.animateTo(
                _scroll.position.maxScrollExtent,
                duration: const Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
              );
            },
            icon: const Icon(Icons.arrow_downward),
            splashRadius: 25,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                chatlist.clear();
              });
            },
            icon: const Icon(Icons.delete_forever),
            splashRadius: 25,
          ),
          // IconButton(
          //   onPressed: () async {
          //     await ShowModal.showModal(context);
          //   },
          //   icon: Icon(Icons.more_vert),
          //   splashRadius: 25,
          // ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView(
                controller: _scroll,
                children: List.generate(
                  chatlist.length,
                  (index) => ChatWidget(
                    data: chatlist[index],
                  ),
                ),

                //reverse: true,
                //itemBuilder: (context, index) => ChatWidget(
                //data: chatlist[index],
                //),
                //itemCount: chatlist.length,
              ),
            ),
            if (_texting) ...[
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 25,
              )
            ],
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                focusNode: _focus,
                textInputAction: TextInputAction.done,
                controller: _chat,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  hintText: "Hi , how can I help you ? ",
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
                  fillColor: cardColor,
                  filled: true,
                  suffixIcon: IconButton(
                    onPressed: () async {
                      if (_chat.text == "") {
                        return;
                      }
                      try {
                        setState(() {
                          _texting = true;
                          _focus.unfocus();
                        });
                        final String res;
                        // if (mod.getCurrent.contains("gpt-3.5-turbo")) {
                        res = await ApiService.gptmsg(
                          message: _chat.text,
                          modelid: mod.getCurrent,
                        );
                        // } else {
                        //   res = await ApiService.sendMessage(
                        //     message: _chat.text,
                        //     modelid: mod.getCurrent,
                        //   );
                        // }
                        if (res != "") {
                          chatlist.add(
                            {
                              "msg": _chat.text,
                              "chatIndex": 0,
                            },
                          );
                          chatlist.add(
                            {
                              "msg": res,
                              "chatIndex": 1,
                            },
                          );
                          setState(() {
                            _chat.text = "";
                          });
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                          ),
                        );
                      } finally {
                        setState(() {
                          _texting = false;
                        });
                      }
                      _scroll.jumpTo(_scroll.position.maxScrollExtent);
                    },
                    icon: const Icon(Icons.send),
                    splashRadius: 25,
                  ),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
