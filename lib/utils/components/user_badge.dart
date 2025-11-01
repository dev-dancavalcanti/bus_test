import 'package:flutter/material.dart';

/// Widget de badge reutilizável para mostrar informações de usuário com bandeiras de países
class UserBadge extends StatelessWidget {
  final String text;
  final Color color;
  final String? countryCode;
  final double? fontSize;
  final EdgeInsets? padding;
  final double? borderRadius;

  const UserBadge({
    super.key,
    required this.text,
    required this.color,
    this.countryCode,
    this.fontSize,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (countryCode != null) ...[
            Text(() {
              const Map<String, String> countryFlags = {
                'US': '🇺🇸',
                'GB': '🇬🇧',
                'CA': '🇨🇦',
                'AU': '🇦🇺',
                'DE': '🇩🇪',
                'FR': '🇫🇷',
                'BR': '🇧🇷',
                'ES': '🇪🇸',
                'IT': '🇮🇹',
                'NL': '🇳🇱',
                'CH': '🇨🇭',
                'DK': '🇩🇰',
                'FI': '🇫🇮',
                'NO': '🇳🇴',
                'IE': '🇮🇪',
                'NZ': '🇳🇿',
                'TR': '🇹🇷',
                'UA': '🇺🇦',
                'MX': '🇲🇽',
                'IN': '🇮🇳',
                'JP': '🇯🇵',
                'KR': '🇰🇷',
                'CN': '🇨🇳',
                'RU': '🇷🇺',
                'PT': '🇵🇹',
                'SE': '🇸🇪',
                'AR': '🇦🇷',
                'CL': '🇨🇱',
                'CO': '🇨🇴',
                'PE': '🇵🇪',
                'VE': '🇻🇪',
              };
              return countryFlags[countryCode!.toUpperCase()] ?? '🌍';
            }(), style: TextStyle(fontSize: fontSize ?? 14)),
            const SizedBox(width: 6),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: fontSize ?? 14,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
