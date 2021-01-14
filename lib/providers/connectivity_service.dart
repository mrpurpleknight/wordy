import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';

class ConnectivityService with ChangeNotifier{

  ConnectivityStatus _actual;

  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _actual = _getStatusFromResult(result);
      notifyListeners();
    });
  }

  ConnectivityStatus get actualState {
    return _actual;
  }

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        return ConnectivityStatus.on;
        break;
      case ConnectivityResult.none:
        return ConnectivityStatus.off;
        break;
      default:
        return ConnectivityStatus.off;
        break;
    }
  }
}

enum ConnectivityStatus { on, off }
