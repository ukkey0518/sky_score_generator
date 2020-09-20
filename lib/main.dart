import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sky_score_generator/app/views/list/list.dart';
import 'package:sky_score_generator/data/util_classes/sound_path.dart';
import 'package:sky_score_generator/providers/providers.dart';
import 'package:sky_score_generator/util/functions/set_default_locale.dart';

final AudioCache audioCache = AudioCache(prefix: 'assets/sounds/');

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //向き指定
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(
    MultiProvider(
      providers: globalProviders,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ロケールの設定
    setDefaultLocale('ja_JP');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      audioCache.loadAll(SoundPath.fileNames);
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark(),
      home: ListScreen(),
    );
  }
}
