class AuthedUser {
  AuthedUser({
    required this.id,
    required this.name,
    required this.isAnonymous,
  });

  final String id;
  final String name;
  final bool isAnonymous;
}
