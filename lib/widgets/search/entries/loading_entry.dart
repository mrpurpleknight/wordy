import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingEntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListTile(
      title: SizedBox(
        width: 50,
        height: 10,
        child: Padding(
          padding: EdgeInsets.only(right: size.width * 0.45),
          child: SpinKitThreeBounce(
            size: 13,
            color: Theme.of(context).backgroundColor,
          ),
        ),
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 5.0),
        child: Icon(
          Icons.search,
          color: Theme.of(context).backgroundColor,
          size: 30,
        ),
      ),
    );
  }
}
