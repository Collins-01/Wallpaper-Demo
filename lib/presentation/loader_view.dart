import 'package:flutter/material.dart';
import '../extensions/xcontext.dart';

class LoaderView extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final String progress;
  const LoaderView({
    Key? key,
    required this.child,
    required this.isLoading,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          child,
          if (isLoading)
            Container(
              height: context.deviceHeight,
              width: context.deviceWith,
              color: Colors.black.withOpacity(.5),
            ),
          if (isLoading)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  Text(
                    "Progress: $progress",
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}
