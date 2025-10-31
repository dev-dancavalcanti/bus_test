import 'package:flutter/material.dart';

/// Widget de container decorado usado especificamente no UserCard
class DecoratedContainer extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final List<BoxShadow>? boxShadow;
  final double? borderWidth;
  final Gradient? gradient;

  const DecoratedContainer({
    super.key,
    required this.child,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius = 12,
    this.padding,
    this.margin,
    this.boxShadow,
    this.borderWidth = 1,
    this.gradient,
  });

  // Factory para card padrão da aplicação
  factory DecoratedContainer.card({
    required Widget child,
    EdgeInsets? padding,
    EdgeInsets? margin,
  }) {
    return DecoratedContainer(
      backgroundColor: Colors.white,
      borderRadius: 16,
      padding: padding ?? const EdgeInsets.all(20),
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.1),
          spreadRadius: 1,
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
      borderColor: Colors.grey.withValues(alpha: 0.1),
      child: child,
    );
  }

  // Factory para container com ícone
  factory DecoratedContainer.iconContainer({
    required IconData icon,
    required Color color,
    double size = 20,
    double padding = 8,
  }) {
    return DecoratedContainer(
      backgroundColor: color.withValues(alpha: 0.1),
      borderRadius: 12,
      padding: EdgeInsets.all(padding),
      child: Icon(icon, color: color, size: size),
    );
  }

  // Factory para info container
  factory DecoratedContainer.infoContainer({
    required Widget child,
    Color? backgroundColor,
    Color? borderColor,
  }) {
    return DecoratedContainer(
      backgroundColor: backgroundColor ?? Colors.grey[50],
      borderRadius: 12,
      padding: const EdgeInsets.all(12),
      borderColor: borderColor ?? Colors.grey.withValues(alpha: 0.1),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: gradient == null ? backgroundColor : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        boxShadow: boxShadow,
        border: borderColor != null && borderWidth != null
            ? Border.all(color: borderColor!, width: borderWidth!)
            : null,
      ),
      child: child,
    );
  }
}
