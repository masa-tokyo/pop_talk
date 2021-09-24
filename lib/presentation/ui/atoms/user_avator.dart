import 'package:flutter/material.dart';
import 'package:pop_talk/domain/model/interface.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    required this.profile,
    this.radius = 40,
  });

  final HasProfile profile;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.black12,
      foregroundImage: NetworkImage(profile.photoUrl),
      child: Text(
        profile.name.isNotEmpty ? profile.name.substring(0, 1) : '',
        style: TextStyle(
          fontSize: radius,
          color: Colors.black54,
        ),
      ),
    );
  }
}
