
import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'An error occurred ',
        style: TextStyle(
            color: Colors.white, fontSize: 18),
      ),
    );
  }
}
