import 'package:flutter/material.dart';

class ListWithNumber extends StatelessWidget {
  const ListWithNumber({
    Key? key,
    required this.children,
    this.numberFontSize = 16,
  }): super(key: key);

  final List<Widget> children;
  final int numberFontSize;

  @override
  Widget build(BuildContext context) {
    var index = 1;
    return Container(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List<Widget>.from(
          children.map<Widget>((Widget child) {
            if (child is ListWithNumber) {
              return child;
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${index++}.', style: const TextStyle(fontSize: 16)),
                  SizedBox(width: numberFontSize / 2),
                  Flexible(child: child),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
