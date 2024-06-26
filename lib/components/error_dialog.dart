import 'package:ahamove/core/constants/app/color_constant.dart';
import 'package:flutter/material.dart';

class ErrorAlertDialog extends StatelessWidget {
  const ErrorAlertDialog({
    super.key,
    required this.context,
    required this.label,
  });

  final BuildContext context;
  final String label;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 36.0),
      backgroundColor: ColorConstants.instance.aliceBlue,
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 8, bottom: 20),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Text(
                  label,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: ColorConstants.instance.black0B,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: const Text(
                      'Close',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: null,
    );
  }
}
