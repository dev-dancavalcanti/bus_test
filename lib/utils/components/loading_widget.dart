import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String message;
  final double? height;
  final Color? progressColor;
  final double? strokeWidth;

  const LoadingWidget({
    super.key,
    this.message = 'Carregando...',
    this.height,
    this.progressColor,
    this.strokeWidth = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? MediaQuery.of(context).size.height - 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: progressColor,
              strokeWidth: strokeWidth!,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingButton extends StatelessWidget {
  final bool isLoading;
  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final double? width;
  final double? height;

  const LoadingButton({
    super.key,
    required this.isLoading,
    required this.text,
    this.onPressed,
    this.color,
    this.width = 16,
    this.height = 16,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        width: width,
        height: height,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: color ?? Colors.white,
        ),
      );
    }

    return Text(
      text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    );
  }
}
