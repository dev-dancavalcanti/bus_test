import 'package:bus_teste/main.dart';
import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

class AppColors {
  static const Color darkBackground = Color(0xFF04040B);
  static const Color lightGray = Color(0xFF908D8C);
  static const Color darkGreen = Color(0xFF4A665C);
  static const Color darkGrayBlue = Color(0xFF41474D);
  static const Color deepBlue = Color(0xFF3E4E64);
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _startSplash();
  }

  void _startSplash() async {
    await Future.delayed(const Duration(milliseconds: 200));
    await _animationController.forward();
    await Future.delayed(const Duration(milliseconds: 2000));

    if (mounted) {
      Routefly.navigate(routePaths.user.path);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1976D2),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      spreadRadius: 2,
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: const Icon(
                      Icons.directions_bus_rounded,
                      size: 60,
                      color: Color(0xFF1976D2),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              const Text(
                'Gerenciador de Usuários',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.8,
                ),
              ),

              const SizedBox(height: 80),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Carregando...',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
