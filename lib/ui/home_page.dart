import 'package:bus_teste/config/injectors.dart';
import 'package:bus_teste/main.dart';
import 'package:bus_teste/utils/components/app_bar_action_button.dart';
import 'package:bus_teste/utils/components/custom_app_bar.dart';
import 'package:bus_teste/utils/components/loading_widget.dart';
import 'package:bus_teste/utils/components/status_badge.dart';
import 'package:bus_teste/utils/components/user_card.dart';
import 'package:bus_teste/viewmodels/ticker_viewmodel.dart';
import 'package:bus_teste/viewmodels/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final viewModel = injector.get<UserViewModel>();
  final tickerViewModel = injector.get<TickerViewModel>();

  @override
  void initState() {
    super.initState();
    tickerViewModel.initializeTicker(this);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: viewModel,
      builder: (context, child) {
        final status = viewModel.userCommand.value;

        return Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: CustomAppBar(
            titleIcon: Icons.people_alt_outlined,
            title: 'Usuários',
            subtitle: '${viewModel.users.length} carregados',
            statusWidget: AnimatedBuilder(
              animation: tickerViewModel,
              builder: (context, _) {
                return StatusBadge(
                  isPaused: tickerViewModel.isTickerPaused,
                  pausedText: 'Pausado',
                  countdown: tickerViewModel.currentCountdown,
                  showCountdown: true,
                  showIndicator: true,
                );
              },
            ),
            actions: [
              AnimatedBuilder(
                animation: tickerViewModel,
                builder: (context, _) {
                  return AppBarActionButton(
                    icon: tickerViewModel.isTickerPaused
                        ? Icons.play_arrow_rounded
                        : Icons.pause_rounded,
                    onPressed: tickerViewModel.toggleTicker,
                    tooltip: tickerViewModel.isTickerPaused
                        ? 'Retomar'
                        : 'Pausar',
                    backgroundColor: const Color(
                      0xFF1976D2,
                    ).withValues(alpha: 0.1),
                    iconColor: const Color(0xFF1976D2),
                  );
                },
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (viewModel.users.isEmpty && !status.isRunning)
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 200,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFF1976D2,
                                ).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(
                                    0xFF1976D2,
                                  ).withValues(alpha: 0.2),
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.directions_bus_rounded,
                                size: 60,
                                color: Color(0xFF1976D2),
                              ),
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              'Bem-vindo ao',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Gerenciador de usuários!',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 32),
                            AnimatedBuilder(
                              animation: tickerViewModel,
                              builder: (context, _) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.green.withValues(
                                        alpha: 0.3,
                                      ),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.access_time_rounded,
                                        color: Colors.green,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Usuário irá aparecer em ${tickerViewModel.currentCountdown}s',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.green,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Os usuários aparecerão automaticamente a cada 5 segundos',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (status.isRunning && viewModel.users.isEmpty)
                    const LoadingWidget(message: 'Carregando usuário...'),
                  if (viewModel.saveUserCommand.value.isFailure)
                    Builder(
                      builder: (context) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(
                                        alpha: 0.2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.error_outline_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Erro ao salvar usuário',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: Colors.red[600],
                              duration: const Duration(seconds: 4),
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.all(16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 8,
                              action: SnackBarAction(
                                label: 'OK',
                                textColor: Colors.white,
                                onPressed: () {
                                  ScaffoldMessenger.of(
                                    context,
                                  ).hideCurrentSnackBar();
                                },
                              ),
                            ),
                          );
                        });
                        return const SizedBox.shrink();
                      },
                    ),
                  if (status.isFailure)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Erro ao carregar usuários',
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                  else
                    RepaintBoundary(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: viewModel.users.length,

                        addAutomaticKeepAlives: true,
                        addRepaintBoundaries: true,
                        itemBuilder: (context, index) {
                          final user = viewModel.users[index];

                          return RepaintBoundary(
                            key: ValueKey(user.login.uuid),
                            child: UserCard(
                              user: user,
                              index: index,
                              onToggleSaved: () async {
                                await viewModel.toggleUserSaved(user);
                              },
                              isUserSaved: () =>
                                  viewModel.isUserSaved(user.login.uuid),
                              viewModel: viewModel,
                              tickerViewModel: tickerViewModel,
                              onDetails: () {
                                tickerViewModel.pauseForNavigation();
                                Routefly.pushNavigate(
                                  routePaths.user.userDetails,
                                  arguments: user,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              viewModel.getUserLocalStorageCommand.execute();
              tickerViewModel.pauseForNavigation();
              Routefly.pushNavigate(routePaths.user.userSaved);
            },
            icon: const Icon(Icons.storage, color: Colors.white),
            label: const Text(
              'Salvos',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.green,
            elevation: 8,
            extendedPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }
}
