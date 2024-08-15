import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halal_check/app_constants/image_constant.dart';
import 'package:halal_check/domain/authentication/models/authDTO.dart';
import 'package:halal_check/domain/authentication/models/shop_detail_DTO.dart';
import 'package:halal_check/domain/shop_details/model/shop_timing_model.dart';
import 'package:halal_check/provider/authentication_provider.dart';
import 'package:halal_check/screens/screen_layout.dart';
import 'package:halal_check/services/di_services.dart';
import 'package:halal_check/shared/validator/validator.dart';
import 'package:halal_check/theme/component_theme/custom_textstyle_theme.dart';

import '../../shared/component/heading_subtitle.dart';
import '../../shared/widget/shared_widget.dart';
import '../../theme/color_constant.dart';

class OTPScreen extends StatefulWidget {
  static String route = '/otp_screen';
  final AuthDto dto;
  final ShopDetailDTO? shopDto;
  final ShopTimingModel? timingModel;

  const OTPScreen({
    super.key,
    required this.dto,
    this.shopDto,
    this.timingModel,
  });

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late InputDescriptor otp;
  late ValueNotifier<bool> loader;
  late Timer timer;
  late ValueNotifier<String> countDownText;
  late GlobalKey<FormState> _formKey;
  late ValueNotifier<AutovalidateMode> _autoValidation;
  int timeOut = 30;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _autoValidation = ValueNotifier<AutovalidateMode>(AutovalidateMode.disabled);
    otp = InputDescriptor(label: 'OTP', hint: 'Enter your OTP', keyBoardType: TextInputType.number);
    countDownText = ValueNotifier('00:30');
    loader = ValueNotifier(false);
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeOut > 0) {
        countDownText.value = '00:${timeOut.toString().padLeft(2, '0')}';
        timeOut--;
        print(countDownText.value);
      } else {
        timer.cancel();
        timeOut = 30;
        countDownText.value = 'Resend';
        return;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      appBarTitle: 'One time password',
      loader: loader,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Column(
          children: [
            SizedBox(
              width: 282.w,
              height: 188.h,
              child: SvgPicture.asset(ImageConstant.otpBackground),
            ),
            SizedBox(height: 30.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: HeaderSubtitle(
                      headerText: 'Enter One time password',
                      subtitle: 'Enter one time password you received on your phone number',
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ValueListenableBuilder<AutovalidateMode>(
                      valueListenable: _autoValidation,
                      builder: (context, validationMode, _) {
                        return Form(
                          key: _formKey,
                          autovalidateMode: validationMode,
                          child: CustomTextField(
                            addBottomPadding: false,
                            descriptor: otp,
                            maxLength: 6,
                            maxlines: 1,
                            validator: ValidatorFunction.otpValidation,
                            onFieldSubmitted: (_) {
                              _onSubmit();
                            },
                          ),
                        );
                      }),
                  ValueListenableBuilder<String>(
                      valueListenable: countDownText,
                      builder: (context, value, _) {
                        return RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "Didn't get the code? ",
                                  style: context.textTheme.bodySmall),
                              TextSpan(
                                  text: value,
                                  recognizer: timer.isActive
                                      ? null
                                      : (TapGestureRecognizer()..onTap = _resendOtp),
                                  style: context.textTheme.titleSmall!.copyWith(
                                      decoration: TextDecoration.underline,
                                      decorationColor: ColorConstantDark.primary,
                                      color: ColorConstantDark.primary))
                            ],
                          ),
                        );
                      }),
                  SizedBox(
                    height: 40.h,
                  ),
                  CustomGradientButton(text: 'Submit', onPressed: _onSubmit),
                  SizedBox(
                    height: 40.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _resendOtp() {
    _formKey.currentState!.reset();
    _autoValidation.value = AutovalidateMode.disabled;
    FocusScope.of(context).unfocus();
    otp.controller.clear();
    loader.value = true;
    DI
        .i<AuthenticationProvider>()
        .resendVerificationCode(dto: widget.dto, loader: loader, startTimer: startTimer);
  }

  _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      loader.value = true;
      await DI.i<AuthenticationProvider>().verifySmsCode(
            widget.dto,
            otp.getText(),
            widget.shopDto,
            widget.timingModel,
          );
      loader.value = false;
    } else {
      _autoValidation.value = AutovalidateMode.onUserInteraction;
    }
  }
}
