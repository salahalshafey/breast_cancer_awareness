import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../app.dart';

final context = navigatorKey.currentContext!;

/// * DateFormat pattern = `hh:mm a`.
///
/// * example of returning string: `06:22 PM` in case of the current locale is `en`.

String time24To12HoursFormat(DateTime dateTime) {
  return intl.DateFormat(
    "hh:mm a",
    Localizations.localeOf(context).languageCode,
  ).format(dateTime);
}

/*String time24To12HoursFormat(int hours, int minuts) {
  String minut = minuts.toString();
  if (minut.length < 2) {
    minut = '0$minut';
  }

  if (hours == 0) {
    return "12:$minut AM";
  } else if (hours == 12) {
    return '12:$minut PM';
  } else if (hours > 21) {
    return '${hours - 12}:$minut PM';
  } else if (hours > 12) {
    return '0${hours - 12}:$minut PM';
  } else if (hours > 9) {
    return '$hours:$minut AM';
  }
  return '0$hours:$minut AM';
}*/

/// ### Examples of returning string in case of the current locale is `en`
///
/// * `Today` **OR**
/// * `Yesterday` **OR**
/// * `23/7/2022` or `٢٠٢٢/٧/٢٣` for `ar`.
///
/// ## details
///
/// * If the [date] is today the returning string is `Today` in case of the current locale is `en`.
///
/// * If the [date] is yesterday the returning string is `Yesterday` in case of the current locale is `en`.
///
/// * If before the above DateFormat pattern is: `Directionality.of(context) == TextDirection.rtl ? "y/M/d" : "d/M/y"`. for example: `23/7/2022` OR `٢٠٢٢/٧/٢٣`

String formatedDate(DateTime date) {
  final currentDate = DateTime.now();

  if (currentDate.year == date.year &&
      currentDate.month == date.month &&
      currentDate.day == date.day) {
    return AppLocalizations.of(context)!.today;
  }

  if (currentDate.year == date.year &&
      currentDate.month == date.month &&
      currentDate.day == date.day + 1) {
    return AppLocalizations.of(context)!.yesterday;
  }

  // return '${date.day}/${date.month}/${date.year}';

  return intl.DateFormat(
    Directionality.of(context) == TextDirection.rtl ? "y/M/d" : "d/M/y",
    Localizations.localeOf(context).languageCode,
  ).format(date);
}

/// ### Examples of returning string in case of the current locale is `en`
///
/// * `Today at 06:22 PM` **OR**
/// * `Yesterday at 06:22 PM` **OR**
/// * `23/7/2022 at 06:22 PM` **OR** for `ar`
/// * `٢٠٢٢/٧/٢٣ الساعة ٠٨:٤٨ م`
///
/// * if [seperateByLine] = `true`, the time `06:22 PM` will be in new line.
///
/// ## details
///
/// * If the [date] is today the returning string is `Today at 06:22 PM` in case of the current locale is `en`.
///
/// * If the [date] is yesterday the returning string is `Yesterday at 06:22 PM` in case of the current locale is `en`.
///
/// * If before the above DateFormat pattern is:
///
///  ```
/// Directionality.of(context) == TextDirection.rtl ? "y/M/d" : "d/M/y"
/// ```
/// * for example:
///   * `23/7/2022 at 06:22 PM` OR
///   * `٢٠٢٢/٧/٢٣ الساعة ٠٨:٤٨ م`
///

String wellFormattedDateTime(DateTime date, {bool seperateByLine = false}) {
  final at = AppLocalizations.of(context)!.at;

  return formatedDate(date) +
      (seperateByLine ? '\n' : ' $at ') +
      time24To12HoursFormat(date);
}

/// ### Examples of returning string in case of the current locale is `en`
/// * `Sunday, August 8, 2023 02:30 PM`.
///
/// * if [seperateByLine] = `true`, the time `02:30 PM` will be in new line.

String wellFormattedDateTimeLong(DateTime dateTime,
    {bool seperateByLine = false}) {
  final date = intl.DateFormat(
    "EEEE, d MMMM, y",
    Localizations.localeOf(context).languageCode,
  ).format(dateTime);

  return date + (seperateByLine ? '\n' : ' ') + time24To12HoursFormat(dateTime);
}

/// ### Examples of returning string in case of the current locale is `en`
/// * ` August 2023` **OR** for `ar`
/// * `أغسطس ٢٠٢٣`

String wellFormattedDateWithoutDay(DateTime dateTime) {
  return intl.DateFormat(
    "MMMM yyy",
    Localizations.localeOf(context).languageCode,
  ).format(dateTime);
}

DateTime getCurrentDateTimeremovedMinutesAndSeconds() =>
    DateTime.now().copyWith(
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );

String formatedDuration(Duration time) {
  // print(time.toString());
  return time.toString().substring(2, 7);
}

String wellFormatedDuration(Duration duration, {bool lineEach = false}) {
  int durationInSecond = duration.inSeconds;

  final hours = durationInSecond ~/ 3600;
  final hoursString =
      hours == 0 ? '' : '$hours hour${_s(hours)}${_lineOrSpace(lineEach)}';
  durationInSecond %= 3600;

  final minutes = durationInSecond ~/ 60;
  final minutesString = minutes == 0
      ? ''
      : '$minutes minute${_s(minutes)}${_lineOrSpace(lineEach)}';
  durationInSecond %= 60;

  final secondsString = durationInSecond == 0
      ? ''
      : '$durationInSecond second${_s(durationInSecond)}';

  return hoursString + minutesString + secondsString;
}

String _lineOrSpace(bool lineEach) {
  return lineEach ? '\n' : ' ';
}

String pastOrFutureTimeFromNow(DateTime dateTime) {
  final duration = DateTime.now().difference(dateTime);

  var d = duration.inDays ~/ 3650;
  var res = _res(d, 'decade');
  if (res != null) {
    return res;
  }

  d = duration.inDays ~/ 365;
  res = _res(d, 'year');
  if (res != null) {
    return res;
  }

  d = duration.inDays ~/ 30;
  res = _res(d, 'month');
  if (res != null) {
    return res;
  }

  d = duration.inDays ~/ 7;
  res = _res(d, 'week');
  if (res != null) {
    return res;
  }

  d = duration.inDays;
  res = _res(d, 'day');
  if (res != null) {
    return res;
  }

  d = duration.inHours;
  res = _res(d, 'hour');
  if (res != null) {
    return res;
  }

  d = duration.inMinutes;
  res = _res(d, 'minute');
  if (res != null) {
    return res;
  }

  return 'just now';
}

String? _res(int d, String timeName) {
  if (d > 0) {
    return '$d $timeName${_s(d)} ago';
  }
  if (d < 0) {
    return '${d.abs()} $timeName${_s(d)} from now';
  }
  return null;
}

String _s(int num) => num.abs() > 1 ? 's' : '';
