import 'dart:ui';

import 'package:chat_reaction/chatProvider.dart';
import 'package:chat_reaction/message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SenderMessageCard extends StatefulWidget {
  SenderMessageCard({required this.messageKey, required this.message});
  GlobalKey messageKey;
  Message message;

  @override
  State<SenderMessageCard> createState() => _SenderMessageCardState();
}

class _SenderMessageCardState extends State<SenderMessageCard> {
  final layerLink = LayerLink();

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: GestureDetector(
              onTap: () => onTapOfMessage(context),
              onLongPress: () => _showOverLay(context, widget.message),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 4),
                color: widget.message.isSelected ? Color.fromARGB(141, 189, 231, 250) : null,
                margin: EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                      padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
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
                              Text("Mohnees",
                                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      )),
                              Text("12:20 PM",
                                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                        color: Colors.white,
                                      )),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(widget.message.content,
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: Colors.white,
                                  )),
                        ],
                      ),
                    ),
                    profilePic(),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 50,
            child: widget.message.reaction != null ? Icon(_getReactionIcon(widget.message.reaction!)) : SizedBox(),
          ),
        ],
      ),
    );
  }

  //// second try
  // void _showReactionPopup(BuildContext context, Message message, GlobalKey messageKey) {
  //   final reactionIcons = {
  //     Reaction.favorite: Icons.favorite,
  //     Reaction.thumbsDown: Icons.thumb_down,
  //   };

  //   final popupMenuThemeData = PopupMenuTheme.of(context);
  //   final style = popupMenuThemeData.textStyle ?? Theme.of(context).textTheme.subtitle1;

  //   final overlay = Overlay.of(context)?.context.findRenderObject() as RenderBox?;
  //   final messagePosition = messageKey.currentContext?.findRenderObject() as RenderBox?;
  //   final statusBarHeight = MediaQuery.of(context).padding.top;

  //   final messageSize = messagePosition?.size;
  //   final messageOffset = messagePosition?.localToGlobal(Offset.zero);

  //   final position = RelativeRect.fromRect(
  //     Rect.fromPoints(
  //       Offset(messageOffset?.dx ?? 0, (messageOffset?.dy ?? 0) + statusBarHeight),
  //       Offset(
  //         (messageOffset?.dx ?? 0) + (messageSize?.width ?? 0),
  //         (messageOffset?.dy ?? 0) + statusBarHeight + (messageSize?.height ?? 0),
  //       ),
  //     ),
  //     Offset.zero & (overlay?.size ?? Size.zero),
  //   );

  //   showMenu<Reaction>(
  //     context: context,
  //     position: position,
  //     items: [
  //       PopupMenuItem<Reaction>(
  //         value: Reaction.favorite,
  //         child: ListTile(
  //           leading: Icon(reactionIcons[Reaction.favorite]),
  //           title: Text('Favorite'),
  //         ),
  //       ),
  //       PopupMenuItem<Reaction>(
  //         value: Reaction.thumbsDown,
  //         child: ListTile(
  //           leading: Icon(reactionIcons[Reaction.thumbsDown]),
  //           title: Text('Thumbs Down'),
  //         ),
  //       ),
  //     ],
  //     elevation: popupMenuThemeData.elevation,
  //     shape: popupMenuThemeData.shape,
  //     color: popupMenuThemeData.color,
  //     // captureInheritedThemes: popupMenuThemeData.captureInheritedThemes,
  //     // elevationGetter: popupMenuThemeData.elevationGetter,
  //     // semanticLabel: popupMenuThemeData.semanticLabel,
  //     // shapeBorder: popupMenuThemeData.shapeBorder,
  //     // clipBehavior: popupMenuThemeData.clipBehavior,
  //     // colorBrightness: popupMenuThemeData.colorBrightness,
  //     // iconTheme: popupMenuThemeData.iconTheme,
  //     // materialTapTargetSize: popupMenuThemeData.materialTapTargetSize,
  //     // textStyle: style?.copyWith(color: Colors.white),
  //   ).then((value) {
  //     if (value != null) {
  //       Provider.of<ChatProvider>(context, listen: false).setReaction(message, value);
  //     }
  //   });
  // }

  /// third try
  // void _showReactionPopup(BuildContext context, Message message, GlobalKey messageKey) {
  //   final overlay = Overlay.of(context)?.context.findRenderObject() as RenderBox?;
  //   final messagePosition = messageKey?.currentContext?.findRenderObject() as RenderBox?;

  //   final messageOffset = messagePosition?.localToGlobal(Offset.zero);
  //   final reactionSize = 32.0;

  //   final popUpHeight = reactionSize + 16.0; // Adjust the height as needed
  //   final popUpWidth = reactionSize * 2 + 24.0; // Adjust the width as needed

  //   final popUpPosition = Offset(
  //     (messageOffset?.dx ?? 0) - (popUpWidth / 2) + (messagePosition?.size.width ?? 0) / 2,
  //     (messageOffset?.dy ?? 0) - popUpHeight,
  //   );
  //   showGeneralDialog(
  //     context: context,
  //     barrierDismissible: true,
  //     barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
  //     barrierColor: Colors.black54,
  //     transitionDuration: const Duration(milliseconds: 200),
  //     pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
  //       return Center(
  //         child: Container(
  //           decoration: BoxDecoration(
  //             color: Colors.transparent,
  //           ),
  //           child: Stack(
  //             children: [
  //               Positioned(
  //                 top: popUpPosition.dy,
  //                 left: popUpPosition.dx,
  //                 child: ReactionPopUp(
  //                   reaction: Reaction.favorite,
  //                   onPressed: () {
  //                     Provider.of<ChatProvider>(context, listen: false).setReaction(message, Reaction.favorite);
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ),
  //               Positioned(
  //                 top: popUpPosition.dy,
  //                 left: popUpPosition.dx + reactionSize + 8.0,
  //                 child: ReactionPopUp(
  //                   reaction: Reaction.thumbsDown,
  //                   onPressed: () {
  //                     Provider.of<ChatProvider>(context, listen: false).setReaction(message, Reaction.thumbsDown);
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  void _showOverLay(BuildContext context, Message message) {
    context.read<ChatProvider>().reactionOverlayState = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;

    final size = renderBox.size;

    context.read<ChatProvider>().reactionOverlayEntry = OverlayEntry(
      maintainState: true,
      builder: (context) {
        return Positioned(
          width: 160,
          child: CompositedTransformFollower(
            link: layerLink,
            showWhenUnlinked: false,
            offset: Offset(50, -20),
            child: buildOverlay(message),
          ),
        );
      },
    );

    context.read<ChatProvider>().reactionOverlayState!.insert(context.read<ChatProvider>().reactionOverlayEntry!);
  }

  Widget buildOverlay(Message message) {
    return GestureDetector(
        child: Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        // width: 40,
        height: 60,
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ReactionPopUp(
              reaction: Reaction.favorite,
              onPressed: () {
                context.read<ChatProvider>().setReaction(message, Reaction.favorite);
                context.read<ChatProvider>().removeOverlay();
                // overlayEntry?.remove();
              },
            ),
            ReactionPopUp(
              reaction: Reaction.thumbsDown,
              onPressed: () {
                context.read<ChatProvider>().setReaction(message, Reaction.thumbsDown);
                // overlayEntry?.remove();
                context.read<ChatProvider>().removeOverlay();
              },
            ),
          ],
        ),
      ),
    ));
  }

  void _showReactionPopup(BuildContext context, Message message, GlobalKey messageKey) {
    final overlayState = Overlay.of(context);
    OverlayEntry? overlayEntry;

    // final overlay = Overlay.of(context)?.context.findRenderObject() as RenderBox?;
    final messagePosition = messageKey.currentContext?.findRenderObject() as RenderBox?;
    final messageSize = messagePosition?.size;
    final messageOffset = messagePosition?.localToGlobal(Offset.zero);

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 100,
        left: messageOffset?.dx,
        right: 0,
        child: GestureDetector(
          onTap: () {
            overlayEntry?.remove();
            context.read<ChatProvider>().clearMessageSelection();
          },
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Container(
              // height: MediaQuery.of(context).size.height,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ReactionPopUp(
                      reaction: Reaction.favorite,
                      onPressed: () {
                        context.read<ChatProvider>().setReaction(message, Reaction.favorite);
                        overlayEntry?.remove();
                      },
                    ),
                    SizedBox(width: 16.0),
                    ReactionPopUp(
                      reaction: Reaction.thumbsDown,
                      onPressed: () {
                        context.read<ChatProvider>().setReaction(message, Reaction.thumbsDown);
                        overlayEntry?.remove();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlayState?.insert(overlayEntry);
  }

  IconData _getReactionIcon(Reaction reaction) {
    final reactionIcons = {
      Reaction.favorite: Icons.favorite,
      Reaction.thumbsDown: Icons.thumb_down,
    };
    return reactionIcons[reaction] ?? Icons.favorite_border;
  }

  Padding profilePic() {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 0.0),
      child: SizedBox(
          width: 24,
          height: 24,
          child: Container(
            decoration: BoxDecoration(color: Colors.amber[200], shape: BoxShape.circle),
          )),
    );
  }

  void onTapOfMessage(BuildContext context) {
    context.read<ChatProvider>().toggleMessageSelection(widget.message);
  }
}

class ReactionPopUp extends StatelessWidget {
  final Reaction reaction;
  final VoidCallback onPressed;

  const ReactionPopUp({required this.reaction, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final reactionIcons = {
      Reaction.favorite: Icons.favorite,
      Reaction.thumbsDown: Icons.thumb_down,
    };

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.all(8.0),
        child: Icon(
          reactionIcons[reaction],
          size: 26.0,
          color: Colors.black,
        ),
      ),
    );
  }
}
