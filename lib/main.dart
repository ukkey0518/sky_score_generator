import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sky_score_generator/app/views/list/list.dart';
import 'package:sky_score_generator/data/theme_data.dart';
import 'package:sky_score_generator/data/util_classes/image_path.dart';
import 'package:sky_score_generator/providers/providers.dart';
import 'package:sky_score_generator/util/functions/set_default_locale.dart';

final String playBgImagePath = ImagePath.getPlayBackgroundImagePath();

DecorationImage playBackgroundImage;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp();

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
      if (playBackgroundImage == null) {
        playBackgroundImage = DecorationImage(
          image: AssetImage(playBgImagePath),
          fit: BoxFit.cover,
        );
      }
    });

    return FutureBuilder<FirebaseApp>(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Container(color: Colors.white);
        }
        return MaterialApp(
          theme: themeData,
          debugShowCheckedModeBanner: false,
          // theme: ThemeData.dark(),
          home: ListScreen(),
        );
      },
    );
  }
}
