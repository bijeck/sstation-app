import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CoreUtils {
  const CoreUtils._();

  static final oCcy = NumberFormat('#,##0', 'en_US');
  static DateFormat timestampFortmatter = DateFormat('dd/MM/yyyy HH:MM');
  static DateFormat dateFortmatter = DateFormat('dd/MM/yyyy');

  static String welcomeTitleByTime() {
    var hour = TimeOfDay.now().hour;

    if (hour < 12) {
      return 'helloMorning'.tr();
    }

    if (hour >= 12 && hour < 18) {
      return 'helloAfternoon'.tr();
    }

    return 'helloEvening'.tr();
  }

  static String parseTimestamp(String timestamp) {
    List<String> timeParts = timestamp.split('T');

    var parsedDate =
        DateTime.parse('${timeParts[0]}T${timeParts[1].substring(0, 8)}');
    return timestampFortmatter
        .format(parsedDate.add(parsedDate.timeZoneOffset));
  }

  static String parseDateFromTimestamp(String timestamp) {
    List<String> timeParts = timestamp.split('T');
    var parsedDate =
        DateTime.parse('${timeParts[0]}T${timeParts[1].substring(0, 8)}');
    return dateFortmatter.format(parsedDate.add(parsedDate.timeZoneOffset));
  }

  static String parseDate(DateTime date) {
    return dateFortmatter.format(date);
  }

  static DateTime toDate(String date) {
    return dateFortmatter.parse(date);
  }

  static DateTime toDateTime(String timestamp) {
    List<String> timeParts = timestamp.split('T');

    var parsedDate =
        DateTime.parse('${timeParts[0]}T${timeParts[1].substring(0, 8)}');
    return parsedDate.add(parsedDate.timeZoneOffset);
  }

  static String reformatDate(String date) {
    DateFormat reFortmatter = DateFormat('yyyy-MM-dd');
    return reFortmatter.format(dateFortmatter.parse(date));
  }

  static Duration getRemainDuration(String timestamp) {
    List<String> timeParts = timestamp.split('T');

    var parsedDate =
        DateTime.parse('${timeParts[0]}T${timeParts[1].substring(0, 8)}');
    var expiredTime = parsedDate.add(parsedDate.timeZoneOffset);
    return expiredTime.difference(DateTime.now()) < Duration.zero
        ? Duration.zero
        : expiredTime.difference(DateTime.now());
  }
}
