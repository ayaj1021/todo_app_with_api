// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class PageNavigator {
  PageNavigator({
    this.ctx,
  });
  BuildContext? ctx;

  Future nextPage({Widget? page}) {
    return Navigator.push(ctx!, MaterialPageRoute(builder: (context) => page!));
  }

//This is to remove the previous page for example in a splashscreen
  void nextPageOnly({Widget? page}) {
    Navigator.pushAndRemoveUntil(
        ctx!, MaterialPageRoute(builder: (context) => page!), (route) => false);
  }
}
