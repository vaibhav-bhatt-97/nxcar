import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nxcar/constants/nx_colors.dart';
import 'package:nxcar/presenter/common_widgets/custom_text_formfield.dart';
import 'package:nxcar/presenter/pages/OTP_screen.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>(); // GlobalKey to identify the form
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _vehicleNumberController = TextEditingController();

  // Email validation method
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  // Required field validation method
  String? _validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  // Vehicle number validation method
  String? _validateVehicleNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your vehicle number';
    }
    String pattern = r'^[A-Z]{2}\d{2}[A-Z]{2,3}\d{4}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid vehicle number';
    }
    return null;
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
                "Welcome Back!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: NXColors.title,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Please fill out the details",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: NXColors.subTitle,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 30),
              CustomTextFormField(
                labelText: "Enter your number",
                controller: _numberController,
                keyboardType: TextInputType.number,
                validator: _validateRequired,
                required: true,
                maxLength: 10,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                labelText: "Enter your name",
                controller: _nameController,
                validator: _validateRequired,
                required: true,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                labelText: "Enter your email",
                controller: _emailController,
                validator: _validateEmail,
                required: true,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                labelText: "Enter your vehicle number",
                controller: _vehicleNumberController,
                validator: _validateVehicleNumber,
                required: true,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // If all fields pass validation, proceed to the next screen
                    print("Go to next screen");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OTPScreen(maskedNumber: _numberController.text),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
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

