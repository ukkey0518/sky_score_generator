import 'package:mock_data/mock_data.dart';
import 'package:sky_score_generator/data/constants.dart';
import 'package:sky_score_generator/util/functions/get_time_zone.dart';

class ImagePath {
  ImagePath._();

  static const String playBgMorning1 = 'assets/images/play_bg_morning_1.jpeg';
  static const String playBgMorning2 = 'assets/images/play_bg_morning_2.jpeg';
  static const String playBgAfternoon1 =
      'assets/images/play_bg_afternoon_1.jpeg';
  static const String playBgAfternoon2 =
      'assets/images/play_bg_afternoon_2.jpeg';
  static const String playBgEvening1 = 'assets/images/play_bg_evening_1.jpeg';
  static const String playBgEvening2 = 'assets/images/play_bg_evening_2.jpeg';
  static const String playBgNight1 = 'assets/images/play_bg_night_1.jpeg';
  static const String playBgNight2 = 'assets/images/play_bg_night_2.jpeg';

  static String getPlayBackgroundImagePath() {
    final timeZone = getTimeZone();

    final is1 = mockInteger(1, 100) % 2 == 0;

    String imagePath;

    switch (timeZone) {
      case TimeZone.MORNING:
        imagePath = is1 ? playBgMorning1 : playBgMorning2;
        break;
      case TimeZone.AFTERNOON:
        imagePath = is1 ? playBgAfternoon1 : playBgAfternoon2;
        break;
      case TimeZone.EVENING:
        imagePath = is1 ? playBgEvening1 : playBgEvening2;
        break;
      case TimeZone.NIGHT:
        imagePath = is1 ? playBgNight1 : playBgNight2;
        break;
    }
    return imagePath;
  }
}
