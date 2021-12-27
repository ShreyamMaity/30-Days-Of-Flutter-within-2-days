

import 'dart:async';

class checkTheme {
  final _themeController = StreamController<bool>();
  get changeTheme => _themeController.sink.add;
  get isDark => _themeController.stream;
}

final bloc = checkTheme();