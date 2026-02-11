import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart'
    as material
    show showDialog, showModalBottomSheet;
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:talker/talker.dart';

import 'route/route.dart';

part 'extensions/debug.dart';
part 'extensions/navigation.dart';
part 'extensions/overlay.dart';
part 'extensions/utilities.dart';
part 'extensions/text.dart';

/// Namespace for global application extensions and utilities.
class _AppExt {
  const _AppExt();
}

/// Global instance of [_AppExt] providing access to app-wide functionality.
const App = _AppExt();

final Completer<void> startAppCompleter = Completer<void>();
final Completer<void> initializeAppCompleter = Completer<void>();
final Completer<void> rootPageCompleter = Completer<void>();

final GetIt getIt = GetIt.instance;

extension AppExt on _AppExt {
  Future<void> waitStartAppFinish({bool waitRootPage = false}) async {
    await startAppCompleter.future;
    await initializeAppCompleter.future;
    if (waitRootPage) {
      await rootPageCompleter.future;
    }
  }
}
