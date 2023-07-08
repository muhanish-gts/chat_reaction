import 'dart:math';

import 'package:chat_reaction/chatProvider.dart';
import 'package:chat_reaction/recived_card.dart';
import 'package:chat_reaction/sender_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ChatProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatPage(),
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
      ),
      body: GestureDetector(
        onTap: () {
          chatProvider.clearMessageSelection;

          chatProvider.removeOverlay();
        },
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  physics: BouncingScrollPhysics(),
                  reverse: true,
                  itemCount: context.watch<ChatProvider>().messages.length,
                  itemBuilder: (context, indexMain) {
                    final message = chatProvider.messages[indexMain];
                    final messageKey = GlobalKey();

                    if (message.id.hashCode > "[#4c58a]".hashCode) {
                      return SenderMessageCard(
                        messageKey: messageKey,
                        message: message,
                      );
                    } else {
                      return RecivedMessageCard(
                        key: messageKey,
                        message: message,
                      );
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(hintText: 'Enter a message'),
                      onSubmitted: (value) {
                        chatProvider.addMessage(value);
                        // Clear the text field after submitting the message
                        // textFieldController.clear();
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      chatProvider.addMessage(textController.text.trim().toString());

                      textController.clear();
                    },
                    icon: Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
