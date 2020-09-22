import 'package:sky_score_generator/data/constants.dart';

TimeZone getTimeZone() {
  final now = DateTime.now();
  final hour = now.hour;

  if (hour >= 6 && hour < 10) {
    return TimeZone.MORNING;
  }

  if (hour >= 10 && hour < 14) {
    return TimeZone.AFTERNOON;
  }

  if (hour >= 14 && hour < 18) {
    return TimeZone.EVENING;
  }

  return TimeZone.NIGHT;
}
