import 'package:bus_teste/domain/entities/user_entity.dart';
import 'package:bus_teste/main.dart';
import 'package:bus_teste/utils/components/loading_widget.dart';
import 'package:bus_teste/utils/components/user_badge.dart';
import 'package:bus_teste/utils/widgets/decorated_container.dart';
import 'package:bus_teste/viewmodels/ticker_viewmodel.dart';
import 'package:bus_teste/viewmodels/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

class UserCard extends StatefulWidget {
  final UserEntity user;
  final int index;
  final TickerViewModel tickerViewModel;
  final UserViewModel viewModel;
  final VoidCallback? onDetails;
  final Future<void> Function()? onToggleSaved;
  final bool Function()? isUserSaved;

  const UserCard({
    super.key,
    required this.user,
    required this.index,
    required this.viewModel,
    required this.tickerViewModel,
    this.onDetails,
    this.onToggleSaved,
    this.isUserSaved,
  });

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  bool _isTogglingBookmark = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.viewModel,
      builder: (context, child) {
        final isSaved =
            widget.isUserSaved?.call() ??
            widget.viewModel.isUserSaved(widget.user.login.uuid);

        return DecoratedContainer.card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserHeader(),
              const SizedBox(height: 20),
              _buildUserInfo(),
              const SizedBox(height: 20),
              _buildActionButtons(isSaved),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUserHeader() {
    return Row(
      children: [
        _buildUserAvatar(),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.user.name.first} ${widget.user.name.last}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  UserBadge(
                    text: '${widget.user.dob.age} anos',
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 8),
                  UserBadge(
                    text: widget.user.nat.toUpperCase(),
                    color: Colors.orange,
                    countryCode: widget.user.nat,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserAvatar() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: widget.user.gender == 'male'
              ? Colors.blue.withValues(alpha: 0.3)
              : Colors.pink.withValues(alpha: 0.3),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: widget.user.gender == 'male'
                ? Colors.blue.withValues(alpha: 0.1)
                : Colors.pink.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 32,
        backgroundColor: Colors.grey[100],
        backgroundImage: NetworkImage(widget.user.picture),
        onBackgroundImageError: (error, stackTrace) {},
        child: NetworkImage(widget.user.picture).toString().isEmpty
            ? const Icon(Icons.person, color: Colors.grey, size: 32)
            : null,
      ),
    );
  }

  Widget _buildUserInfo() {
    return DecoratedContainer.infoContainer(
      child: Column(
        children: [
          _buildInfoRow(
            Icons.location_on_rounded,
            Colors.orange,
            '${widget.user.location.city}, ${widget.user.location.country}',
          ),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.phone_rounded, Colors.green, widget.user.phone),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.email_rounded, Colors.blue, widget.user.email),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, MaterialColor color, String text) {
    return Row(
      children: [
        DecoratedContainer.iconContainer(
          icon: icon,
          color: color[700]!,
          size: 16,
          padding: 6,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[800],
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(bool isSaved) {
    return Row(
      children: [
        Expanded(child: _buildSaveButton(isSaved)),
        const SizedBox(width: 12),
        Expanded(child: _buildDetailsButton()),
      ],
    );
  }

  Widget _buildSaveButton(bool isSaved) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isSaved
              ? [Colors.red[400]!, Colors.red[600]!]
              : [Colors.green[400]!, Colors.green[600]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: (isSaved ? Colors.red : Colors.green).withValues(alpha: 0.3),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _isTogglingBookmark
            ? null
            : () => _handleToggleSaved(isSaved),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isTogglingBookmark)
              const LoadingWidget()
            else ...[
              Icon(
                isSaved
                    ? Icons.bookmark_rounded
                    : Icons.bookmark_border_rounded,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                isSaved ? 'Remover' : 'Salvar',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsButton() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton(
        onPressed: () {
          if (widget.onDetails != null) {
            widget.onDetails!();
          } else {
            Routefly.pushNavigate(
              routePaths.user.userDetails,
              arguments: widget.user,
            );
            widget.tickerViewModel.pauseForNavigation();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 6),
            Text(
              'Detalhes',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleToggleSaved(bool wasUserSaved) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    setState(() => _isTogglingBookmark = true);

    try {
      if (widget.onToggleSaved != null) {
        await widget.onToggleSaved!();
        _showSuccessMessage(scaffoldMessenger, wasUserSaved);
      } else {
        final result = await widget.viewModel.toggleUserSaved(widget.user);
        result.fold(
          (success) => _showSuccessMessage(scaffoldMessenger, wasUserSaved),
          (error) => _showErrorMessage(scaffoldMessenger, error.toString()),
        );
      }
    } catch (error) {
      _showErrorMessage(scaffoldMessenger, error.toString());
    }

    if (mounted) setState(() => _isTogglingBookmark = false);
  }

  void _showSuccessMessage(ScaffoldMessengerState messenger, bool wasRemoved) {
    if (!mounted) return;
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          wasRemoved
              ? 'Usuário removido dos salvos'
              : 'Usuário salvo com sucesso',
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: wasRemoved ? Colors.red : Colors.green,
      ),
    );
  }

  void _showErrorMessage(ScaffoldMessengerState messenger, String error) {
    if (!mounted) return;
    messenger.showSnackBar(
      SnackBar(
        content: Text('Erro: $error'),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red,
      ),
    );
  }
}
