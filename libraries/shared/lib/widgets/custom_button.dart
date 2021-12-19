import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final VoidCallback onTap;
  final String label;

  const CustomButton({Key? key, required this.onTap, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Center(
          child: Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
