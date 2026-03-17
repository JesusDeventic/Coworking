class FilmolyAppStatus {
  final String version;
  final int status;

  const FilmolyAppStatus({
    required this.version,
    required this.status,
  });

  factory FilmolyAppStatus.fromJson(Map<String, dynamic> json) {
    return FilmolyAppStatus(
      version: (json['version'] as String?) ?? '',
      status: (json['status'] as num?)?.toInt() ?? 0,
    );
  }
}

