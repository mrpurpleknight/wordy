import 'package:flutter/material.dart';

abstract class OrderedList<T> {
  List<T> toOrder;

  OrderedList({
    @required this.toOrder,
  });
}
