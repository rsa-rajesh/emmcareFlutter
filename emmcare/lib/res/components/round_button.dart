import 'package:emmcare/res/colors.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;
  const RoundButton({
    super.key,
    required this.title,
    this.loading = false,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 40,
        width: 200,
        child: Center(
          child: loading
              ? CircularProgressIndicator()
              : Text(
                  title,
                  style: TextStyle(color: AppColors.whiteColor),
                ),
        ),
      ),
    );
  }
}
