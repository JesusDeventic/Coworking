class MessageUser {
  final int id;
  final String username;
  final String avatarUrl;

  const MessageUser({
    required this.id,
    required this.username,
    required this.avatarUrl,
  });

  factory MessageUser.fromJson(Map<String, dynamic> json) => MessageUser(
        id: _parseInt(json['id']),
        username: (json['username'] as String?) ?? '',
        avatarUrl: (json['avatar_url'] as String?) ?? '',
      );
}

class PrivateMessage {
  final int id;
  final int senderId;
  final int recipientId;
  final String? message;
  final bool isRead;
  final DateTime createdAt;
  final DateTime? editedAt;
  final DateTime? deletedAt;

  const PrivateMessage({
    required this.id,
    required this.senderId,
    required this.recipientId,
    this.message,
    required this.isRead,
    required this.createdAt,
    this.editedAt,
    this.deletedAt,
  });

  bool get isDeleted => deletedAt != null;
  bool get isEdited => editedAt != null;

  factory PrivateMessage.fromJson(Map<String, dynamic> json) {
    return PrivateMessage(
      id: _parseInt(json['id']),
      senderId: _parseInt(json['sender_id']),
      recipientId: _parseInt(json['recipient_id']),
      message: json['message'] as String?,
      isRead: _parseBool(json['is_read']),
      createdAt: _parseDate(json['created_at']) ?? DateTime.now(),
      editedAt: _parseDate(json['edited_at']),
      deletedAt: _parseDate(json['deleted_at']),
    );
  }

  // El campo más reciente entre created_at, edited_at y deleted_at,
  // usado como cursor para el polling delta.
  DateTime get latestTimestamp {
    var t = createdAt;
    if (editedAt != null && editedAt!.isAfter(t)) t = editedAt!;
    if (deletedAt != null && deletedAt!.isAfter(t)) t = deletedAt!;
    return t;
  }

  PrivateMessage copyWith({bool? isRead}) => PrivateMessage(
        id: id,
        senderId: senderId,
        recipientId: recipientId,
        message: message,
        isRead: isRead ?? this.isRead,
        createdAt: createdAt,
        editedAt: editedAt,
        deletedAt: deletedAt,
      );
}

class Conversation {
  final MessageUser otherUser;
  final ConversationLastMessage lastMessage;
  final bool hasUnread;

  const Conversation({
    required this.otherUser,
    required this.lastMessage,
    required this.hasUnread,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        otherUser: MessageUser.fromJson(json['other_user'] as Map<String, dynamic>),
        lastMessage: ConversationLastMessage.fromJson(
            json['last_message'] as Map<String, dynamic>),
        hasUnread: json['has_unread'] == true,
      );
}

class ConversationLastMessage {
  final int id;
  final int senderId;
  final String? content;
  final bool isRead;
  final DateTime createdAt;
  final DateTime? editedAt;
  final DateTime? deletedAt;

  const ConversationLastMessage({
    required this.id,
    required this.senderId,
    this.content,
    required this.isRead,
    required this.createdAt,
    this.editedAt,
    this.deletedAt,
  });

  bool get isDeleted => deletedAt != null;

  factory ConversationLastMessage.fromJson(Map<String, dynamic> json) =>
      ConversationLastMessage(
        id: _parseInt(json['id']),
        senderId: _parseInt(json['sender_id']),
        content: json['content'] as String?,
        isRead: _parseBool(json['is_read']),
        createdAt: _parseDate(json['created_at']) ?? DateTime.now(),
        editedAt: _parseDate(json['edited_at']),
        deletedAt: _parseDate(json['deleted_at']),
      );
}

bool _parseBool(dynamic v) {
  if (v == null) return false;
  if (v is bool) return v;
  if (v is int) return v != 0;
  if (v is String) return v == '1' || v == 'true';
  return false;
}

int _parseInt(dynamic v) {
  if (v == null) return 0;
  if (v is num) return v.toInt();
  return int.tryParse(v.toString()) ?? 0;
}

DateTime? _parseDate(dynamic v) {
  if (v == null) return null;
  if (v is! String) return null;
  final s = v.trim();
  if (s.isEmpty) return null;

  // WordPress devuelve DATETIME en MySQL típicamente como: 'YYYY-MM-DD HH:mm:ss'
  // (sin timezone). Interpretarlo como UTC evita que la hora cambie según el
  // timezone del cliente.
  final mysqlMatch = RegExp(
    r'^(\d{4})-(\d{2})-(\d{2})[ T](\d{2}):(\d{2}):(\d{2})(\.\d+)?$',
  ).firstMatch(s);
  if (mysqlMatch != null) {
    final year = int.parse(mysqlMatch.group(1)!);
    final month = int.parse(mysqlMatch.group(2)!);
    final day = int.parse(mysqlMatch.group(3)!);
    final hour = int.parse(mysqlMatch.group(4)!);
    final minute = int.parse(mysqlMatch.group(5)!);
    final second = int.parse(mysqlMatch.group(6)!);
    return DateTime.utc(year, month, day, hour, minute, second);
  }

  // ISO/RFC3339 (si ya incluye timezone, DateTime.parse lo respeta).
  try {
    return DateTime.parse(s);
  } catch (_) {
    return null;
  }
}
