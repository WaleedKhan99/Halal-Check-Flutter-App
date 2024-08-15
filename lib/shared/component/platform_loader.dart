import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformLoader extends StatelessWidget {
  final bool center;

  const PlatformLoader({super.key, this.center = true});

  @override
  Widget build(BuildContext context) {
    return center
        ? const Center(
            child: _Loader(),
          )
        : const _Loader();
  }
}

class _Loader extends StatelessWidget {
  const _Loader();

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? const CupertinoActivityIndicator() : const CircularProgressIndicator();
  }
}
