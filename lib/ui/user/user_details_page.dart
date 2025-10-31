import 'package:bus_teste/config/injectors.dart';
import 'package:bus_teste/domain/entities/user_entity.dart';
import 'package:bus_teste/utils/components/app_bar_action_button.dart';
import 'package:bus_teste/utils/components/custom_app_bar.dart';
import 'package:bus_teste/utils/components/info_row.dart';
import 'package:bus_teste/utils/components/info_section.dart';
import 'package:bus_teste/utils/components/status_badge.dart';
import 'package:bus_teste/utils/components/user_badge.dart';
import 'package:bus_teste/utils/formater/date_helper.dart';
import 'package:bus_teste/viewmodels/user_viewmodel.dart';
import 'package:flutter/material.dart';

class UserDetailsPage extends StatefulWidget {
  final UserEntity user;

  const UserDetailsPage({super.key, required this.user});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  bool _showPassword = false;
  final viewModel = injector.get<UserViewModel>();
  bool _isTogglingBookmark = false;

  @override
  void initState() {
    super.initState();
    viewModel.getUserLocalStorageCommand.execute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(
        titleIcon: Icons.person_outline_rounded,
        title: 'Detalhes',
        subtitle: 'Informações do usuário',
        showBackButton: true,
        statusWidget: const StatusBadge(isPaused: true, pausedText: 'Pausado'),
        actions: [
          ListenableBuilder(
            listenable: viewModel,
            builder: (context, _) {
              final isSaved = viewModel.isUserSaved(widget.user.login.uuid);
              return AppBarActionButton(
                icon: isSaved
                    ? Icons.bookmark_rounded
                    : Icons.bookmark_border_rounded,
                onPressed: _isTogglingBookmark
                    ? null
                    : () async {
                        setState(() {
                          _isTogglingBookmark = true;
                        });

                        final result = await viewModel.toggleUserSaved(
                          widget.user,
                        );

                        if (mounted) {
                          setState(() {
                            _isTogglingBookmark = false;
                          });

                          result.fold(
                            (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    isSaved
                                        ? 'Usuário removido dos salvos'
                                        : 'Usuário salvo com sucesso',
                                  ),
                                  duration: const Duration(seconds: 2),
                                  backgroundColor: isSaved
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              );
                            },
                            (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Erro: ${error.toString()}'),
                                  duration: const Duration(seconds: 3),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            },
                          );
                        }
                      },
                tooltip: isSaved ? 'Remover dos salvos' : 'Salvar usuário',
                backgroundColor: isSaved
                    ? const Color(0xFF4a665c).withValues(alpha: 0.1)
                    : Colors.grey[100],
                iconColor: isSaved ? const Color(0xFF4a665c) : Colors.black54,
                isLoading: _isTogglingBookmark,
                loadingWidget: const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Color(0xFF4a665c),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Ticker pausado nesta página',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: widget.user.gender == 'male'
                              ? Colors.blue.withValues(alpha: 0.4)
                              : Colors.pink.withValues(alpha: 0.4),
                          width: 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: widget.user.gender == 'male'
                                ? Colors.blue.withValues(alpha: 0.2)
                                : Colors.pink.withValues(alpha: 0.2),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey[100],
                        backgroundImage: NetworkImage(widget.user.picture),
                        onBackgroundImageError: (error, stackTrace) {},
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${widget.user.name.title} ${widget.user.name.first} ${widget.user.name.last}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        UserBadge(
                          text: '${widget.user.dob.age} anos',
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 12),
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
            ),

            const SizedBox(height: 24),

            InfoSection(
              title: 'Informações de Contato',
              children: [
                InfoRow(
                  icon: Icons.email_rounded,
                  label: 'Email',
                  value: widget.user.email,
                  iconColor: Colors.blue,
                ),
                InfoRow(
                  icon: Icons.phone_rounded,
                  label: 'Telefone',
                  value: widget.user.phone,
                  iconColor: Colors.green,
                ),
                InfoRow(
                  icon: Icons.phone_android_rounded,
                  label: 'Celular',
                  value: widget.user.cell,
                  iconColor: Colors.green,
                ),
              ],
            ),

            InfoSection(
              title: 'Informações Pessoais',
              children: [
                InfoRow(
                  icon: Icons.person_rounded,
                  label: 'Gênero',
                  value: widget.user.gender == 'male'
                      ? 'Masculino'
                      : 'Feminino',
                  iconColor: Colors.purple,
                ),
                InfoRow(
                  icon: Icons.cake_rounded,
                  label: 'Data de Nascimento',
                  value: DateHelper.formatDate(widget.user.dob.date),
                  iconColor: Colors.pink,
                ),
                InfoRow(
                  icon: Icons.calendar_today_rounded,
                  label: 'Data de Registro',
                  value: DateHelper.formatDate(widget.user.registered),
                  iconColor: Colors.orange,
                ),
              ],
            ),

            InfoSection(
              title: 'Localização',
              children: [
                InfoRow(
                  icon: Icons.location_city_rounded,
                  label: 'Cidade',
                  value: widget.user.location.city,
                  iconColor: Colors.orange,
                ),
                InfoRow(
                  icon: Icons.map_rounded,
                  label: 'Estado',
                  value: widget.user.location.state,
                  iconColor: Colors.orange,
                ),
                InfoRow(
                  icon: Icons.public_rounded,
                  label: 'País',
                  value: widget.user.location.country,
                  iconColor: Colors.orange,
                ),
                InfoRow(
                  icon: Icons.markunread_mailbox_rounded,
                  label: 'CEP',
                  value: widget.user.location.postcode,
                  iconColor: Colors.orange,
                ),
                InfoRow(
                  icon: Icons.home_rounded,
                  label: 'Endereço',
                  value:
                      '${widget.user.location.street.name}, ${widget.user.location.street.number}',
                  iconColor: Colors.orange,
                ),
                InfoRow(
                  icon: Icons.location_on_rounded,
                  label: 'Coordenadas',
                  value:
                      '${widget.user.location.coordinates.latitude}, ${widget.user.location.coordinates.longitude}',
                  iconColor: Colors.red,
                ),
                InfoRow(
                  icon: Icons.access_time_rounded,
                  label: 'Fuso Horário',
                  value:
                      '${widget.user.location.timezone.offset} - ${widget.user.location.timezone.description}',
                  iconColor: Colors.teal,
                ),
              ],
            ),

            InfoSection(
              title: 'Informações de Acesso',
              children: [
                InfoRow(
                  icon: Icons.badge_rounded,
                  label: 'ID',
                  value:
                      widget.user.id.name != null &&
                          widget.user.id.value != null
                      ? '${widget.user.id.name}: ${widget.user.id.value}'
                      : 'N/A',
                  iconColor: Colors.indigo,
                ),
                InfoRow(
                  icon: Icons.fingerprint_rounded,
                  label: 'UUID',
                  value: widget.user.login.uuid,
                  iconColor: Colors.indigo,
                ),
                InfoRow(
                  icon: Icons.account_circle_rounded,
                  label: 'Username',
                  value: widget.user.login.username,
                  iconColor: Colors.indigo,
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.lock_rounded,
                          color: Colors.red,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _showPassword
                                        ? widget.user.login.password
                                        : '••••••••',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  onPressed: () {
                                    setState(() {
                                      _showPassword = !_showPassword;
                                    });
                                  },
                                  icon: Icon(
                                    _showPassword
                                        ? Icons.visibility_off_rounded
                                        : Icons.visibility_rounded,
                                    color: Colors.grey[600],
                                    size: 18,
                                  ),
                                  tooltip: _showPassword
                                      ? 'Ocultar senha'
                                      : 'Mostrar senha',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
