import 'package:flutter/material.dart';

/// Widget reutilizável de botão de ação para app bar com suporte a loading
class AppBarActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final Color? backgroundColor;
  final Color? iconColor;
  final bool isLoading;
  final Widget? loadingWidget;

  const AppBarActionButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.backgroundColor,
    this.iconColor,
    this.isLoading = false,
    this.loadingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: isLoading
            ? (loadingWidget ??
                  const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.grey,
                    ),
                  ))
            : Icon(icon, color: iconColor ?? Colors.black54, size: 22),
        onPressed: isLoading ? null : onPressed,
        tooltip: tooltip,
      ),
    );
  }
}
