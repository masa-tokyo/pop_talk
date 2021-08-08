import 'package:flutter/material.dart';

class ElevatedCircleButtonWithIcon extends StatelessWidget {
  const ElevatedCircleButtonWithIcon({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final VoidCallback onPressed;
  final Widget icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: ElevatedButton(
              onPressed: onPressed,
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(const CircleBorder())),
              child: icon),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          label,
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.bodyText2!.fontSize),
        ),
      ],
    );
  }
}
