import 'package:chat_reaction/chatProvider.dart';
import 'package:chat_reaction/message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecivedMessageCard extends StatefulWidget {
  RecivedMessageCard({key, required this.message});
  Message message;

  @override
  State<RecivedMessageCard> createState() => _RecivedMessageCardState();
}

class _RecivedMessageCardState extends State<RecivedMessageCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GestureDetector(
        onTap: () => onTapOfMessage(context),
        child: Container(
          color: widget.message.isSelected
              ? Color.fromARGB(92, 170, 177, 201)
              : null,
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              profile(),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7),
                padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 16.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Muhanish Chouahan",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                )),
                        Text("3.30 AM",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: Colors.black,
                                  fontSize: 12,
                                )),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(widget.message.content,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Color(0xff63697B),
                            )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding profile() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 4.0, bottom: 8.0),
      child: SizedBox(
          width: 24,
          height: 24,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.lightGreenAccent[200], shape: BoxShape.circle),
          )),
    );
  }

  void onTapOfMessage(BuildContext context) {
    context.read<ChatProvider>().toggleMessageSelection(widget.message);
  }

  Color _colorfromhex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
}
