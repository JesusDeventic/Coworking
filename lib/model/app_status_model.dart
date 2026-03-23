class VACoworkingAppStatus {
  final String version;
  final int status;

  const VACoworkingAppStatus({
    required this.version,
    required this.status,
  });

  factory VACoworkingAppStatus.fromJson(Map<String, dynamic> json) {
    return VACoworkingAppStatus(
      version: (json['version'] as String?) ?? '',
      status: (json['status'] as num?)?.toInt() ?? 0,
    );
  }
}


