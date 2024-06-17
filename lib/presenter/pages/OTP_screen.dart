import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nxcar/constants/nx_colors.dart';

class OTPScreen extends StatefulWidget {
  final String maskedNumber;

  const OTPScreen({super.key, required this.maskedNumber});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final List<TextEditingController> _otpControllers =
  List.generate(4, (_) => TextEditingController()); // Controllers for OTP inputs
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode()); // Focus nodes for OTP inputs
  final _formKey = GlobalKey<FormState>(); // GlobalKey for the form

  @override
  void dispose() {
    // Dispose of controllers and focus nodes when the widget is disposed
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  // Method to handle focus and character entry in OTP fields
  void _onChanged(String value, int index) {
    if (value.length == 1) {
      if (index + 1 < _focusNodes.length) {
        _focusNodes[index + 1].requestFocus(); // Move to next field
      }
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus(); // Move to previous field if backspace
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NXColors.background, // Set background color
      appBar: AppBar(
        backgroundColor: NXColors.background, // Set AppBar background color
        elevation: 0, // Remove AppBar shadow
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context); // Navigate back
          },
          child: SvgPicture.asset(
            "lib/assets/images/arrow_right.svg",
            fit: BoxFit.scaleDown,
            width: 4,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Form(
          key: _formKey, // Assign the form key
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Enter your OTP",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: NXColors.title,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.maskedNumber.replaceRange(2, 7, "******"), // Masked number display
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xff959898),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(4, (index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 12),
                    width: 48,
                    child: TextFormField(
                      controller: _otpControllers[index], // Assign controller
                      focusNode: _focusNodes[index], // Assign focus node
                      keyboardType: TextInputType.number, // Numeric keyboard
                      textAlign: TextAlign.center,
                      maxLength: 1, // Limit input to 1 character
                      onChanged: (value) => _onChanged(value, index), // Handle input change
                      decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ' '; // Validate OTP input
                        }
                        return null;
                      },
                    ),
                  );
                }),
              ),
              const SizedBox(height: 10),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                ),
                onPressed: () {
                  // Logic for resending OTP
                  print("Resend OTP");
                },
                child: const Text(
                  "Resend",
                  style: TextStyle(
                    color: Color(0xFF4AA09B),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // If all fields pass validation, proceed to the next screen
                    print("Go to next screen");
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width * 1, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 20),
                  backgroundColor: NXColors.primary,
                ),
                child: const Text(
                  "Next",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
