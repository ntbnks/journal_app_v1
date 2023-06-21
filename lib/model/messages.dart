import 'package:journal_app_v1/model/models.dart';

class Messages {
  String errorTableHandler(String msg) {
    final String m = msg.contains('SocketException: Failed host lookup:')
        ? 'Ошибка соединения!'
        : msg.contains('is not a subtype of type')
            ? 'Несовпадение типов!'
            : msg.contains('Tunnel')
                ? 'Ошибка адреса!'
                : "Неизвестная ошибка!";

    return '$m\n\r$msg';
  }

  String calculateTimeSpent(int value) {
    final int h = value ~/ 60;
    final int m = value - (h * 60);

    final String f = h > 0 ? '$hч $mм' : '$mм';

    return f;
  }

  String genUserName(User user) {
    return '${user.fam} ${user.name}';
  }

  String getDateTimeFromList(List<int> l, {String? separator}) {
    final s = separator ?? '-';

    /// Show string on bool

    String genNum(int value) {
      return value < 10 ? '0$value' : '$value';
    }

    return '${genNum(l[0])}$s${genNum(l[1])}$s${genNum(l[2])}';
  }

  /// Show string on bool
  String genBoolString(bool value) {
    return value ? 'Да' : 'Нет';
  }

  /// Show rating from int
  String genRatingFromInt(int value, {bool shortened = false}) {
    if (shortened) {
      return value == 3
          ? 'Отлично'
          : value == 2
              ? 'Хорошо'
              : value == 1
                  ? 'Неуд.'
                  : 'Ошибка!';
    } else {
      return value == 3
          ? 'Отлично'
          : value == 2
              ? 'Хорошо'
              : value == 1
                  ? 'Неудовлетворительно'
                  : 'Неверное значение!';
    }
  }
}
