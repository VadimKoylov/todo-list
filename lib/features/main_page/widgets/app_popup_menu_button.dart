import 'package:flutter/material.dart';

class AppPopupMenuButton extends StatelessWidget {
  final Set<String> items;
  final void Function(String)? onSelected;
  final Icon icon;

  const AppPopupMenuButton({
    required this.items,
    required this.onSelected,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      elevation: 10,
      icon: icon,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      onSelected: onSelected,
      itemBuilder: (BuildContext context) {
        return items.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }
}
