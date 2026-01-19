part of '../extensions.dart';

extension GetItExtension on GetIt {
  T? getOrNull<T extends Object>({String? instanceName}) {
    if (isRegistered<T>(instanceName: instanceName)) {
      return get<T>(instanceName: instanceName);
    }
    return null;
  }
}
