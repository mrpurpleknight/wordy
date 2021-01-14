import 'dart:async';
import 'package:connectivity/connectivity.dart';

class ConnectivityService {
  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();

  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectionStatusController.add(_getStatusFromResult(result));
    });
  }

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        return ConnectivityStatus.on;
      case ConnectivityResult.none:
        return ConnectivityStatus.off;
      default:
        return ConnectivityStatus.off;
    }
  }
}

enum ConnectivityStatus { on, off }
