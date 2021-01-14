import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class ConnectivityStatus {
  ConnectionStatus _actual;
  StreamSubscription _subscription;

  ConnectivityStatus() : _actual = ConnectionStatus.on;

  ConnectionStatus get actual => _actual;


  Stream get connection {
    return Connectivity().onConnectivityChanged;
  }

  Future<ConnectionStatus> checkWhileOn() async {
    ConnectionStatus status;
    while (status == null) {
      ConnectivityResult result = await Connectivity().checkConnectivity();
      if (result != ConnectivityResult.none) status = ConnectionStatus.on;
    }

    return status;
  }

  void pauseConnection() {
    _subscription.pause(checkWhileOn());
  }

  void closeConnection() {
    _subscription.cancel();
  }

  ConnectionStatus mapEvent(ConnectivityResult result) {
    ConnectionStatus status;
    switch (result) {
      case ConnectivityResult.none:
        status = ConnectionStatus.off;
        break;
      default:
        status = ConnectionStatus.on;
        break;
    }

    return status;
  }
}

enum ConnectionStatus { on, off }
