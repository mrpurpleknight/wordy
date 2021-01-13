import 'package:flutter/material.dart';

class NoResultEntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Text(
            'No result found',
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Icon(
          Icons.search,
          size: 30,
          color: Theme.of(context).backgroundColor,
        ),
      ),
    );
  }
}
