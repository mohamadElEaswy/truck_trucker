import 'package:flutter/material.dart';
import 'internet_status.dart';

class NetworkAwareWidget extends StatelessWidget {
  final Widget onlineChild;
  final Widget offlineChild;
  final NetworkStatus networkStatus;
  const NetworkAwareWidget(
      {Key? key, required this.onlineChild, required this.offlineChild, required this.networkStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // di.serviceLocator.get<AuthBase>()
    if (networkStatus == NetworkStatus.online) {
      return onlineChild;
    } else {
      return offlineChild;
    }
  }
}