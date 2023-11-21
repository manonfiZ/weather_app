import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  final void Function()? onPressed;
  const MyErrorWidget({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'An error occurred ',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: onPressed,
            child: const Text(
              'Retry',
              //   style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
