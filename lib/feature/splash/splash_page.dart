import 'package:flutter/material.dart';
import 'package:game_app/core/constant/app_color.dart';
import 'package:game_app/core/constant/app_image.dart';
import 'package:game_app/core/router/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // إعداد الأنيميشن
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    // تحديد مكان التنقل بعد الأنيميشن
    _decideNavigation();
  }

  Future<void> _decideNavigation() async {
    await Future.delayed(const Duration(seconds: 5)); 
    Navigator.pushReplacementNamed(context, AppRoutes.homeRoute); 
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _animation,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: Image.asset(
                  AppImage.logoSplash,
                  width: 200,
                  height: 200,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ScaleTransition(
              scale: _animation,
              child: const Text(
                'أفلام من غير كلام',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


