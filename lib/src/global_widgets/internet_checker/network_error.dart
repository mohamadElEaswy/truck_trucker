import 'package:flutter/material.dart';
import 'internet_status.dart';
import 'network_handler.dart';

class InternetCheck extends StatelessWidget {
  const InternetCheck({Key? key, required this.online}) : super(key: key);

  final Widget online;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<NetworkStatus>(
      initialData: NetworkStatus.offline,
      stream: NetworkStatusService().networkStatusController.stream,
      builder: (context, snapshot) => NetworkAwareWidget(
        offlineChild: const InternetError(),
        onlineChild: online,
        networkStatus: snapshot.data!,
      ),
    );
  }
}

class InternetError extends StatelessWidget {
  const InternetError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(
          child: Text(
            'No internet connection, please connect to the internet',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
}
