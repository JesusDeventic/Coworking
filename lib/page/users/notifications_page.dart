import 'package:vacoworking/api/vacoworking_api.dart';
import 'package:vacoworking/core/global_functions.dart';
import 'package:vacoworking/core/user_preferences.dart';
import 'package:vacoworking/generated/l10n.dart';
import 'package:vacoworking/widget/components_widgets.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final UserPreferences _prefs = UserPreferences();
  final List<Map<String, dynamic>> _notificationList = [];
  final ScrollController _scrollController = ScrollController();
  int _entryLastSeenId = 0;
  bool _entrySeenLoaded = false;

  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  bool _shouldLoadMore = true;

  int _totalNotifications = 0;
  int _currentPage = 1;
  int _totalPages = 1;
  static const int _perPage = 20;

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (_hasMore && !_isLoadingMore) _loadMoreNotifications();
    }
  }

  Future<void> _fetchNotifications() async {
    if (!_entrySeenLoaded) {
      _entryLastSeenId = await _prefs.getLastSeenNotificationId();
      _entrySeenLoaded = true;
    }
    setState(() {
      _isLoading = true;
      _hasMore = true;
      _shouldLoadMore = true;
    });

    final response = await VACoworkingApi.getNotifications(page: 1, perPage: _perPage);
    if (!mounted) return;

    final list = response['notifications'] as List<Map<String, dynamic>>;
    await _markAsSeenIfNeeded(list);
    setState(() {
      _totalNotifications = response['total'] as int? ?? 0;
      _notificationList
        ..clear()
        ..addAll(list);
      _currentPage = response['page'] as int? ?? 1;
      _totalPages = response['total_pages'] as int? ?? 1;
      _hasMore = _currentPage < _totalPages;
      _isLoading = false;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_shouldLoadMore && _hasMore) _checkIfNeedMoreNotifications();
    });
  }

  void _checkIfNeedMoreNotifications() {
    if (!_scrollController.hasClients) return;
    final viewportHeight = _scrollController.position.viewportDimension;
    final contentHeight =
        _scrollController.position.maxScrollExtent + viewportHeight;
    if (contentHeight < viewportHeight && _hasMore && !_isLoadingMore) {
      _loadMoreNotifications();
    } else {
      _shouldLoadMore = false;
    }
  }

  Future<void> _loadMoreNotifications() async {
    if (_isLoadingMore || !_hasMore) return;
    setState(() => _isLoadingMore = true);

    final nextPage = _currentPage + 1;
    final response =
        await VACoworkingApi.getNotifications(page: nextPage, perPage: _perPage);
    if (!mounted) return;

    final list = response['notifications'] as List<Map<String, dynamic>>;
    await _markAsSeenIfNeeded(list);
    setState(() {
      _notificationList.addAll(list);
      _currentPage = response['page'] as int? ?? nextPage;
      _totalPages = response['total_pages'] as int? ?? _totalPages;
      _hasMore = _currentPage < _totalPages;
      _isLoadingMore = false;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_shouldLoadMore && _hasMore) _checkIfNeedMoreNotifications();
    });
  }

  Future<void> _markAsSeenIfNeeded(List<Map<String, dynamic>> list) async {
    if (list.isEmpty) return;
    int maxId = 0;
    for (final row in list) {
      final id = (row['id'] as num?)?.toInt() ?? 0;
      if (id > maxId) maxId = id;
    }
    if (maxId <= 0) return;
    final current = await _prefs.getLastSeenNotificationId();
    if (maxId > current) {
      await _prefs.setLastSeenNotificationId(maxId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text(
              '${S.current.notificationsLabel}${_totalNotifications > 0 ? ' ($_totalNotifications)' : ''}',
            ),
            actions: [
              if (MediaQuery.of(context).size.width > 800)
                Tooltip(
                  message: S.current.buttonReloadNotifications,
                  child: IconButton(
                    icon: const Icon(Icons.refresh_rounded),
                    onPressed: _fetchNotifications,
                  ),
                ),
              const SizedBox(width: 8),
            ],
          ),
          body: SafeArea(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _notificationList.isEmpty
                    ? emptyDataWidget(
                        context,
                        Icons.notifications_none_rounded,
                        S.current.notificationsEmptyText,
                        '',
                      )
                    : RefreshIndicator(
                        onRefresh: _fetchNotifications,
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.all(8),
                          itemCount: _notificationList.length + 1,
                          itemBuilder: (context, index) {
                          if (index == _notificationList.length) {
                            if (_isLoadingMore) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Center(child: CircularProgressIndicator()),
                              );
                            }
                            if (!_hasMore) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: Center(
                                  child: Text(
                                    S.current.noMoreRecords,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withValues(alpha: 0.6),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          }

                          final notification = _notificationList[index];
                          final notificationId =
                              (notification['id'] as num?)?.toInt() ?? 0;
                          final topic =
                              (notification['topic'] as String?) ?? 'global';
                          final isGlobalTopic =
                              topic.toLowerCase().trim() == 'global';
                          final isNew = notificationId > _entryLastSeenId;

                            return Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 800),
                              child: Card(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                elevation: isNew ? 3 : 1,
                                color: isNew
                                    ? Theme.of(context)
                                        .colorScheme
                                        .primaryContainer
                                        .withValues(alpha: 0.25)
                                    : null,
                                child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      (notification['title']
                                                              as String?) ??
                                                          '',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Tooltip(
                                                    message: isGlobalTopic
                                                        ? 'Global'
                                                        : topic,
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              6),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                999),
                                                        color: isGlobalTopic
                                                            ? Theme.of(context)
                                                                .colorScheme
                                                                .primary
                                                                .withValues(
                                                                    alpha: 0.15)
                                                            : Theme.of(context)
                                                                .colorScheme
                                                                .secondary
                                                                .withValues(
                                                                    alpha: 0.18),
                                                      ),
                                                      child: Icon(
                                                        isGlobalTopic
                                                            ? Icons.public_rounded
                                                            : Icons.tag_rounded,
                                                        size: 14,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSurface,
                                                      ),
                                                    ),
                                                  ),
                                                  if (isNew) ...[
                                                    const SizedBox(width: 6),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                              horizontal: 8,
                                                              vertical: 2),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                999),
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary
                                                            .withValues(
                                                                alpha: 0.22),
                                                      ),
                                                      child: Text(
                                                        S.current.notificationsNewBadge,
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .onSurface,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ],
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                (notification['message'] as String?) ??
                                                    '',
                                              ),
                                              const SizedBox(height: 6),
                                              Text(
                                                formatDate(
                                                  (notification['created_at']
                                                              as String?) ??
                                                          '',
                                                  showTime: true,
                                                ),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface
                                                      .withValues(alpha: 0.6),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ),
                            ),
                            );
                          },
                        ),
                      ),
          ),
        );
  }
}



