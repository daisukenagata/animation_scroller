<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->


# Pub.dev version

[![Pub Version](https://img.shields.io/pub/v/animation_scroller?color=emerald)](https://pub.dev/packages/animation_scroller/versions/)



## Environment

```
Flutter 2.13.0-0.0.pre.301 • channel master • https://github.com/flutter/flutter.git
Framework • revision c4585ecc46 (17 hours ago) • 2022-03-29 11:02:09 -0700
Engine • revision 13414a51e7
Tools • Dart 2.17.0 (build 2.17.0-248.0.dev) • DevTools 2.11.4
```


## Example

Some devices may not support the behavior.


introduction

```
// "Value" Scrolls to the bottom part.　 It is the place of zero
_scrollController.widgetBuild(context, Value, _scrollController.duration);
     
```

All 
```

import 'package:animation_scroller/animation_scroller.dart';
import 'package:flutter/material.dart';

class AnimationScroller extends ScrollController {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;

  bool? initFlg;
  bool? animationFlg;
  int? durationValue;
  double? scrollOffset;
  double? keyboardHeight;
  double? _animationValue;
  double? _containerValue;
  double? _maxScrollExtent;

  /// Notify logic of scroll status.
  scrollState(ScrollNotification scrollNotification, double maxScrollExtent,
      double containerValue) {
    ///　Check the status of scrollNotification.
    if (scrollNotification is ScrollStartNotification) {
    } else if (scrollNotification is ScrollUpdateNotification) {
    } else if (scrollNotification is ScrollEndNotification) {
      scrollOffset = position.maxScrollExtent;
      bool aFlg = (animationFlg ?? false);

      /// Judgment by scroll amount.
      _maxScrollExtent = maxScrollExtent;
      if (_maxScrollExtent == containerValue && aFlg) {
        animationFlg = false;
      }
    }
  }

  /// Initialization of each value.
  reset() {
    initFlg = true;
    durationValue = 0;
    scrollOffset = 0.0;
    keyboardHeight = 0.0;
    _animationValue = 0.0;
    _containerValue = 0.0;
    _maxScrollExtent = 0.0;
    jumpTo(0.0);
    animationFlg = false;

  }

  /// Bind with a widget.
  widgetBuild(BuildContext context, double containerValue, int duration) {
    bool iFlg = (initFlg ?? false);
    bool aFlg = (animationFlg ?? false);
    double kValue = (keyboardHeight ?? 0.0);
    double cValue = (_containerValue ?? 0.0);
    double offsetValue = (scrollOffset ?? 0.0);

    /// Scroll judgment.
    if (aFlg) {
      /// Substitute keyboard height.
      kValue = kValue <= MediaQuery.of(context).viewInsets.bottom
          ? MediaQuery.of(context).viewInsets.bottom
          : kValue;

      /// Substitute scroll amount.
      scrollOffset = (scrollOffset ?? 0.0) <= position.maxScrollExtent
          ? position.maxScrollExtent
          : (scrollOffset ?? 0.0);

      /// Scroll judgment
      if (offsetValue > cValue && iFlg) {
        animationFlg = false;

        /// Scroll animation method
        _animationLogic(duration);
      } else if (!iFlg) {
        /// Scroll animation method
        _animationLogic(duration);
      }

      _containerValue = containerValue;
    }
  }

  /// Speed set and flg check.
  speedCheck(FocusNode focusNode, int value) {
    ///　check focusNode state.
    switch (focusNode.hasFocus) {
      case true:
        durationValue = value;
        animationFlg = true;
        break;
    }
  }

  /// Scroll animation.
  _animationLogic(int duration) {
    Future(() {
      double offsetValue = (scrollOffset ?? 0.0);
      double cValue = (_containerValue ?? 0.0);

      /// Judgment by scroll amount.
      if (offsetValue > cValue) {
        /// Substitute the amount of animation.
        _animationValue = offsetValue - cValue;
        double aValue = (_animationValue ?? 0.0);
        animateTo(aValue,
            duration: Duration(milliseconds: duration), curve: Curves.linear);
      }
    });
  }
}
```

## Getting started

* In the example, tapping textfiled scrolls to the specified position.
