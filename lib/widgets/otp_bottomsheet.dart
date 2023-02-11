import 'package:flutter/material.dart';

class OTPBottomSheetWidget extends StatefulWidget {
  const OTPBottomSheetWidget({super.key, required this.otpController, required this.onBackPressed});
  final TextEditingController otpController;
  final VoidCallback onBackPressed;
  @override
  State<OTPBottomSheetWidget> createState() => _OTPBottomSheetWidgetState();
}

class _OTPBottomSheetWidgetState extends State<OTPBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(controller: widget.otpController),
          MaterialButton(
            color: Colors.blue,
            textColor: Colors.white,
            child: const Text("Verify"),
            onPressed: () => widget.onBackPressed(),
          )
        ],
      ),
    );
  }
}
