import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halal_check/screens/authentication/login_screen.dart';
import 'package:halal_check/screens/screen_layout.dart';
import 'package:halal_check/shared/widget/custom_textform_field.dart';
import '../../shared/component/heading_subtitle.dart';
import '../../shared/widget/custom_gradient_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late ValueNotifier<bool> loader;
  late InputDescriptor email;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loader = ValueNotifier(false);
    email = InputDescriptor(
        label: 'Email',
        hint: 'Insert your Email here',
        keyBoardType: TextInputType.name);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      appBarTitle: 'Forgot Password',
      loader: loader,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const Align(
              alignment: Alignment.center,
              child: HeaderSubtitle(
                subtitle:
                    'Please Enter The Email Address That You Used When Creating Your Account.',
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            CustomTextField(
              descriptor: email,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required!';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomGradientButton(
              text: 'Submit',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _displayBottomSheet(context);
                  loader.value = true;
                  Future.delayed(const Duration(milliseconds: 1000), () {
                    loader.value = false;
                  });
                }
              },
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}

// ======================= Bottom Sheet code =======================

Future<void> _displayBottomSheet(BuildContext context) {
  late ValueNotifier<bool> loader = ValueNotifier<bool>(false);
  return showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 400,
      width: double.infinity,
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 4),
            Container(
              width: 38,
              height: 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFF35383F),
              ),
            ),
            SizedBox(height: 70),
            Text(
              "Password Reset",
              style: TextStyle(
                fontSize: 24,
                fontFamily: "Euclid",
                fontWeight: FontWeight.w700,
                color: Color(0xFF35383F),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Password Reset Email has been sent.",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: "Euclid",
                color: Color(0xFF7D7F88),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            CustomGradientButton(
              text: 'OK',
              onPressed: () {
                LoginScreen();
                loader.value = true;
                Future.delayed(const Duration(milliseconds: 1000), () {
                  loader.value = false;
                });
              },
            ),
          ],
        ),
      ),
    ),
  );
}
