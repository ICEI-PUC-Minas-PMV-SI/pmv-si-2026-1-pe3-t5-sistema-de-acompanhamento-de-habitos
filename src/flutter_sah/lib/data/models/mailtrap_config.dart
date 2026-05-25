class MailtrapConfig {
  final String apiToken;
  final String inboxId;
  final String fromEmail;
  final String fromName;

  const MailtrapConfig({
    required this.apiToken,
    required this.inboxId,
    required this.fromEmail,
    required this.fromName,
  });

  factory MailtrapConfig.fromJson(Map<String, dynamic> j) => MailtrapConfig(
        apiToken: j['api_token'] as String,
        inboxId: j['inbox_id'] as String,
        fromEmail: j['from_email'] as String,
        fromName: j['from_name'] as String,
      );

  Map<String, dynamic> toJson() => {
        'api_token': apiToken,
        'inbox_id': inboxId,
        'from_email': fromEmail,
        'from_name': fromName,
      };
}
