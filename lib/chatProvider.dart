import 'package:chat_reaction/message.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  List<Message> _messages = []; // List of all messages
  List<Message> _selectedMessages = []; // List of selected messages

  List<Message> get messages => _messages;
  List<Message> get selectedMessages => _selectedMessages;

  void addMessage(String content) {
    final message = Message(id: UniqueKey().toString(), content: content);
    _messages.add(message);
    notifyListeners();
  }

  void toggleMessageSelection(Message message) {
    message.isSelected = !message.isSelected;

    if (message.isSelected) {
      _selectedMessages.add(message);
    } else {
      _selectedMessages.remove(message);
    }

    notifyListeners();
  }

  void clearMessageSelection() {
    for (var message in _selectedMessages) {
      message.isSelected = false;
    }

    _selectedMessages.clear();
    notifyListeners();
  }

  void setReaction(Message message, Reaction? reaction) {
    message.reaction = reaction;
    notifyListeners();
  }

  OverlayState? reactionOverlayState;
  OverlayEntry? reactionOverlayEntry;

  void removeOverlay() {
    if (reactionOverlayEntry != null && reactionOverlayEntry!.mounted) {
      reactionOverlayEntry!.remove();
    }
  }
}
