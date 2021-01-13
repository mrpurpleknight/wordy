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
    return FocusedMenuHolder(
      menuWidth: MediaQuery.of(context).size.width * 0.50,
      menuItemExtent: 45,
      menuBoxDecoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      duration: Duration(milliseconds: 100),
      animateMenuItems: true,
      openWithTap: true,
      menuOffset: 10.0,
      bottomOffsetHeight: 80.0,
      // Offset height to consider, for showing the menu item ( for example bottom navigation bar), so that the popup menu will be shown on top of selected item.
      menuItems: <FocusedMenuItem>[
        // Add Each FocusedMenuItem  for Menu Options
        FocusedMenuItem(
          title: Text(
            "A-Z",
            style: TextStyle(
                fontFamily: 'Merriweather',
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                color: Colors.black87),
          ),
          trailingIcon: Icon(Icons.title, color: Colors.black45),
          onPressed: () => Provider.of<Words>(context, listen: false).sortByAlphabetical(),
        ),
        FocusedMenuItem(
          title: Text(
            "Type",
            style: TextStyle(
                fontFamily: 'Merriweather',
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                color: Colors.black87),
          ),
          trailingIcon: Icon(
            Icons.article,
            color: Colors.black45,
          ),
          onPressed: () => Provider.of<Words>(context, listen: false).sortByPartOfSpeech(),
        ),
      ],
      onPressed: () {},
      child: _child,
    );
  }
}
