import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomeKeyBoardListner extends StatefulWidget {
  const CustomeKeyBoardListner(
      { required this.keyEvents,
       required this.child,
      Key? key,
      required this.keysFunction})
      : super(key: key);

  final Map<LogicalKeyboardKey, Function()> keyEvents;
  final Widget child;
  final Function(String character) keysFunction;
  @override
  State<CustomeKeyBoardListner> createState() => CustomeKeyBoardListnerState();
}

class CustomeKeyBoardListnerState extends State<CustomeKeyBoardListner> {
  FocusNode node = FocusNode();
  CustomeKeyBoardListnerState? parent;
  List<CustomeKeyBoardListnerState> children = <CustomeKeyBoardListnerState>[];

  @override
  void dispose() {
    if (parent != null) {
      parent?.removeChild(this);
    }
    node.dispose();
    super.dispose();
  }

  /// Works similarly to the .of() functions except we don't check ourself
  /// as that would cause the tree of [CustomeKeyBoardListnerState]'s
  /// to be circular
  CustomeKeyBoardListnerState? getAncestorSKL(BuildContext context) {
    return context.findAncestorStateOfType<CustomeKeyBoardListnerState>();
  }

  @override
  void initState() {
    parent = getAncestorSKL(context);
    if (parent != null) {
      parent?.addChild(this);
    }
    super.initState();
  }

  void addChild(CustomeKeyBoardListnerState child) {
    children.add(child);
  }

  void removeChild(CustomeKeyBoardListnerState child) {
    children.remove(child);
  }

  /// Bubbles down the keyboard event. Returns true if anyone bellow us
  /// managed to handle it.
  bool bubbleDown(RawKeyEvent event) {
    for (int i = 0; i < children.length; i++) {
      if (children[i].bubbleDown(event)) {
        return true;
      }
    }
    if (event.character != null) {
      widget.keysFunction(event.character!);
    }
    if (node.hasFocus && widget.keyEvents.containsKey(event.logicalKey) && event.isKeyPressed(event.logicalKey)) {
      widget.keyEvents[event.logicalKey]!();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: node,
      onKey: (RawKeyEvent key) {
        if (parent != null) {
          return;
        }
        bubbleDown(key);
      },
      child: widget.child,
    );
  }
}