library animation_scroller;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimationScroller extends ScrollController{
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;

  double scrollOffset = 0.0;
  double containerValue = 0.0;
  double animationValue = 0.0;
  double keyboardHeight = 0.0;
  double offsetDy = 0.0;
  bool animationFlg = true;

  onStartScroll(ScrollMetrics metrics) {
    debugPrint("Scroll Start");
  }

  onUpdateScroll(ScrollMetrics metrics) {
    debugPrint("Scroll Update");
  }

  onEndScroll(ScrollMetrics metrics) {
    debugPrint("Scroll End");
    animationFlg = false;
  }

  reset() {
    animationValue = 0;
    scrollOffset = 0;
    jumpTo(0.0);
  }

  scrollReturn(int value) {
    animationValue = 0;
    animateTo(animationValue,
        duration: Duration(milliseconds: value),
        curve: Curves.linear);
  }

  widgetBuild(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom != 0 && animationFlg) {
      keyboardHeight = keyboardHeight <= MediaQuery.of(context).viewInsets.bottom ?
      MediaQuery.of(context).viewInsets.bottom :
      keyboardHeight;
    }

    if (MediaQuery.of(context).viewInsets.bottom != 0 && hasClients && animationFlg) {
      scrollOffset = scrollOffset <= position.maxScrollExtent ?
      position.maxScrollExtent : scrollOffset;

      if (scrollOffset != 0 && keyboardHeight == MediaQuery.of(context).viewInsets.bottom && animationFlg) {
        Future(() {
          notifyListeners();
        });
      }
    }
  }

  focusLogic(FocusNode focusNode, double value, RenderBox box, double offsetFlg) {
    switch (focusNode.hasFocus) {
      case true:
        animationFlg = true;
        offsetDy > offsetFlg ? Future(() {notifyListeners();}) : null;
        break;
    }
  }

  listener(duration) {
    addListener(() {
      if (scrollOffset > containerValue && animationFlg) {
        _animationLogic(duration);
      }
    });
  }

  _animationLogic(int duration) {
    animationValue = scrollOffset - containerValue;
    animateTo(animationValue, duration: Duration(milliseconds: duration), curve: Curves.linear);
  }
}