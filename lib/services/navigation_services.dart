import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:halal_check/shared/component/bottomsheets/bottomsheet_layout.dart';
import 'package:halal_check/theme/component_theme/custom_textstyle_theme.dart';

class NavigationService {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigatorKey;
  BuildContext? get _context => _navigatorKey.currentContext!;

  Future<dynamic> showCustomDialog(Widget dialog) async {
    return await showDialog(
      context: _navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  Future<dynamic> showBottomsheet({
    String? title,
    String? subTitle,
    required Widget child,
  }) async {
    return await showModalBottomSheet(
        backgroundColor: Colors.white,
        context: _navigatorKey.currentContext!,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (context) {
          return BottomsheetLayout(
            title: title,
            subtitle: subTitle,
            child: child,
          );
        });
  }

  void showToast({required String message, bool error = false}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void showSnackBar({required String message, bool error = false}) {
    ScaffoldMessenger.of(_context!).clearSnackBars();
    final snackBar = SnackBar(
      content: Text(
        message,
        style: _context!.textTheme.bodyMedium!.copyWith(color: Colors.white),
      ),
    );
    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(_context!).showSnackBar(snackBar);
  }

  navigateTo(Function(BuildContext context) navigationFunc) {
    navigationFunc(_navigatorKey.currentContext!);
  }
}
