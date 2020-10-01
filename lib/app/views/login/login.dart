import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:sky_score_generator/app/views/list/list.dart';
import 'package:sky_score_generator/util/routes/fade_route.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Color _shadeColor = Colors.white;
  bool _isEnabledLogin = false;

  FadeInController _titleFadeController = FadeInController();
  FadeInController _tapTextFadeController = FadeInController();

  @override
  void initState() {
    super.initState();
    _shadeColor = Colors.white;
    _isEnabledLogin = false;
    _titleFadeController = FadeInController();
    _tapTextFadeController = FadeInController();
    Future(_startAnimation);
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isEnabledLogin ? () => _startApp(context) : null,
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              'assets/images/title_bg.JPG',
              fit: BoxFit.cover,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 1000),
              color: _shadeColor,
              height: double.infinity,
              width: double.infinity,
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.bottomCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: FadeIn(
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeIn,
                      controller: _titleFadeController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sky 作曲家になろう",
                            style: TextStyle(
                              fontSize: 32,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 32.0),
                          Text(
                            'Score Generator',
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.black87,
                              fontFamily: 'sub_title',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    child: FadeIn(
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeIn,
                      controller: _tapTextFadeController,
                      child: Text('画面タップでログイン'),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // アニメーション
  Future<void> _startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      _shadeColor = Colors.white54;
    });

    await Future.delayed(const Duration(milliseconds: 1000));
    _titleFadeController.fadeIn();

    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      _isEnabledLogin = true;
    });
    _tapTextFadeController.fadeIn();
  }

  void _startApp(BuildContext context) {
    Navigator.pushReplacement(
      context,
      FadeRoute(screen: ListScreen()),
    );
  }
}
