import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:provider/provider.dart';
import 'package:wordy/providers/words.dart';

class OverlayMenuWrapper extends StatelessWidget {
  final Widget _child;

  OverlayMenuWrapper(this._child);

  @override
  Widget build(BuildContext context) {
    Words words = Provider.of<Words>(context);
    return FocusedMenuHolder(
      menuWidth: MediaQuery.of(context).size.width * 0.50,
      menuItemExtent: 45,
      menuBoxDecoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      duration: Duration(milliseconds: 100),
      animateMenuItems: true,
      openWithTap: true,
      menuOffset: 5.0,
      bottomOffsetHeight: 20.0,
      menuItems: <FocusedMenuItem>[
        FocusedMenuItem(
          backgroundColor: Colors.white,
          title: Text(
            "A-Z",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.5,
              color: Colors.black,
            ),
          ),
          trailingIcon: Icon(
            Icons.title,
            color: Colors.black.withOpacity(0.7),
          ),
          onPressed: () =>
              words.sortByAlphabetical(),
        ),
        FocusedMenuItem(
          backgroundColor: Colors.white,
          title: Text(
            "Type",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.5,
              color: Colors.black,
            ),
          ),
          trailingIcon: Icon(
            Icons.article,
            color: Colors.black.withOpacity(0.7),
          ),
          onPressed: () =>
              words.sortByPartOfSpeech(),
        ),
      ],
      onPressed: () {},
      child: _child,
    );
  }
}
