import 'dart:async';
import 'dart:io';
import 'package:go_router/go_router.dart';
import 'package:vacoworking/api/vacoworking_api.dart';
import 'package:vacoworking/core/global_functions.dart';
import 'package:vacoworking/generated/l10n.dart';
import 'package:vacoworking/page/users/contact_page.dart';
import 'package:vacoworking/page/users/general_settings_page.dart';
import 'package:vacoworking/page/users/faq_page.dart';
import 'package:vacoworking/page/users/notifications_page.dart';
import 'package:vacoworking/core/user_preferences.dart';
import 'package:vacoworking/widget/components_widgets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserPreferences _prefs = UserPreferences();
  int _unreadNotificationsCount = 0;
  Timer? _unreadTimer;

  @override
  void initState() {
    super.initState();
    _refreshUnreadNotifications();
    _unreadTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (!mounted) return;
      _refreshUnreadNotifications();
    });
  }

  @override
  void dispose() {
    _unreadTimer?.cancel();
    super.dispose();
  }

  Future<void> _refreshUnreadNotifications() async {
    final lastSeenId = await _prefs.getLastSeenNotificationId();
    final response = await VACoworkingApi.getNotifications(
      page: 1,
      perPage: 1,
      sinceId: lastSeenId,
    );
    final count = (response['total'] as int?) ?? 0;
    if (mounted) setState(() => _unreadNotificationsCount = count);
  }

  Widget _buildDesktopAppBarDivider() {
    return Container(
      height: 24,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: Theme.of(context).colorScheme.outline,
    );
  }

  Widget _buildNotificationIcon() {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    return Tooltip(
      message: S.current.notificationsLabel,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        mouseCursor: SystemMouseCursors.click,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NotificationsPage(),
            ),
          ).then((_) => _refreshUnreadNotifications());
        },
        child: Padding(
          padding: isDesktop ? const EdgeInsets.all(8) : const EdgeInsets.all(2),
          child: Container(
            width: isDesktop ? null : 50,
            height: 50,
            alignment: Alignment.center,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  _unreadNotificationsCount > 0
                      ? Icons.notifications_active
                      : Icons.notifications,
                  color: _unreadNotificationsCount > 0
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.onSurface,
                  size: 34,
                ),
                if (_unreadNotificationsCount > 0)
                  Positioned(
                    right: -4,
                    top: -4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.error,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: Text(
                        _unreadNotificationsCount > 9
                            ? '9+'
                            : _unreadNotificationsCount.toString(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onError,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openUserPanel() {
    unFocusGlobal();
    final isDesktop = MediaQuery.of(context).size.width > 800;
    final width = isDesktop
        ? MediaQuery.of(context).size.width * 0.4
        : MediaQuery.of(context).size.width * 0.85;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        alignment: Alignment.centerRight,
        child: SizedBox(
          width: width,
          height: MediaQuery.of(context).size.height,
          child: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Stack(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(ctx),
                    child: Container(color: Colors.transparent),
                  ),
                  Transform.translate(
                    offset: Offset(width * (1 - value), 0),
                    child: child,
                  ),
                ],
              );
            },
            child: _buildSettingsPanel(ctx),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsPanel(BuildContext dialogContext) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.2),
            blurRadius: 5,
            offset: const Offset(-1, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.settings_rounded,
                        size: 28,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          S.current.settingsLabel,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Tooltip(
                  message: S.current.buttonClose,
                  child: IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      size: 30,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    onPressed: () => Navigator.pop(dialogContext),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 4),
              children: [
                rowSettingsAppAndVersion(context),
                const SizedBox(height: 4),
                const Divider(),
                ListTile(
                  leading: Icon(
                    Icons.app_settings_alt_rounded,
                  ),
                  title: Text(S.current.generalSettings),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GeneralSettingsPage(),
                      ),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.help_outline_rounded),
                  title: Text(S.current.userSectionFAQs),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FAQPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.support_agent_rounded),
                  title: Text(S.current.userSectionContact),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ContactPage(),
                      ),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.cancel_presentation_rounded),
                  title: Text(S.current.dialogCloseAppTitle),
                  onTap: () {
                    _showExitAppDialog();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showExitAppDialog() async {
    final confirmed = await showConfirmDialogGlobal(
      context,
      title: S.current.dialogCloseAppTitle,
      message: S.current.dialogCloseAppContent,
      destructive: true,
    );
    if (confirmed) exit(0);
  }

  Widget _buildUserProfile() {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    return Tooltip(
      message: S.current.settingsLabel,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        mouseCursor: SystemMouseCursors.click,
        onTap: _openUserPanel,
        child: Padding(
          padding: isDesktop ? const EdgeInsets.all(8) : const EdgeInsets.all(2),
          child: Container(
            width: isDesktop ? null : 50,
            height: 50,
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.settings_rounded,
                  size: 32,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                if (isDesktop) ...[
                  const SizedBox(width: 12),
                  Text(
                    S.current.settingsLabel,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 16,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          await _showExitAppDialog();
        }
      },
      child: Scaffold(
        appBar: AppBar(
        toolbarHeight: 60,
        leadingWidth: 0,
        leading: const SizedBox.shrink(),
        titleSpacing: isDesktop ? 16 : 8,
        title: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ContactPage(),
              ),
            );
          },
          borderRadius: BorderRadius.circular(8),
          mouseCursor: SystemMouseCursors.click,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/logo.png',
                  height: 50,
                  errorBuilder: (_, __, ___) => const Icon(Icons.movie, size: 40),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    S.current.appName,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: isDesktop ? 30 : 22,
                        ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          _buildNotificationIcon(),
          if (isDesktop) _buildDesktopAppBarDivider(),
          _buildUserProfile(),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 0.5,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
          ),
        ),
      ),
        body: SafeArea(
          child: _buildMainContent(),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 120,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.business_center_rounded, size: 72),
            ),
            const SizedBox(height: 24),
            Text(
              S.current.homeHeroTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                context.push('/map');
              },
              icon: const Icon(Icons.map_rounded),
              label: Text(S.current.homeSearchCoworkingButton),
            ),
          ],
        ),
      ),
    );
  }
}



