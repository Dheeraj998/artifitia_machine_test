import 'package:flutter/foundation.dart';

customPrint(dynamic data) {
  if (kDebugMode) debugPrint(data?.toString());
}
