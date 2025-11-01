import 'package:flutter/material.dart';

/// Widget de badge de status reutilizável para mostrar estados pausado/ativo
class StatusBadge extends StatelessWidget {
  final bool isPaused;
  final String? pausedText;
  final String? runningText;
  final int? countdown;
  final bool showCountdown;
  final bool showIndicator;

  const StatusBadge({
    super.key,
    required this.isPaused,
    this.pausedText = 'Pausado',
    this.runningText,
    this.countdown,
    this.showCountdown = false,
    this.showIndicator = false,
  });

  @override
  Widget build(BuildContext context) {
    return _buildBadge(context, isPaused);
  }

  Widget _buildBadge(BuildContext context, bool currentPausedState) {
    return Container(
      // Altura fixa
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: currentPausedState
            ? Colors.red.withValues(alpha: 0.1)
            : Colors.green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: currentPausedState
              ? Colors.red.withValues(alpha: 0.3)
              : Colors.green.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            currentPausedState ? Icons.pause_rounded : Icons.play_arrow_rounded,
            color: currentPausedState ? Colors.red : Colors.green,
            size: 14,
          ),
          const SizedBox(width: 4),
          _buildText(currentPausedState),
        ],
      ),
    );
  }

  Widget _buildText(bool currentPausedState) {
    if (showCountdown && countdown != null) {
      return Text(
        currentPausedState
            ? (pausedText ?? 'Pausado')
            : 'Adicionando em ${countdown}s',
        style: TextStyle(
          color: currentPausedState ? Colors.red : Colors.green,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      );
    }

    return Text(
      currentPausedState ? (pausedText ?? 'Pausado') : (runningText ?? 'Ativo'),
      style: TextStyle(
        color: currentPausedState ? Colors.red : Colors.green,
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
