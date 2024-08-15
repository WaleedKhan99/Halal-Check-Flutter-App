import 'dart:io';
import 'package:flutter/material.dart';
import 'package:halal_check/domain/authentication/models/authDTO.dart';
import 'package:halal_check/provider/authentication_provider.dart';
import 'package:halal_check/screens/screen_layout.dart';
import 'package:halal_check/services/di_services.dart';
import 'package:halal_check/services/navigation_services.dart';
import 'package:halal_check/shared/validator/validator.dart';
import 'package:halal_check/shared/widget/custom_textform_field.dart';
import '../../shared/component/heading_subtitle.dart';
import '../../shared/component/profile_image_picker.dart';
import '../../shared/widget/custom_gradient_button.dart';

class UserRegistrationScreen extends StatefulWidget {
  static String route = '/user_registration_screen';

  final bool isShopOwner;
  const UserRegistrationScreen({super.key, this.isShopOwner = false});

  @override
  State<UserRegistrationScreen> createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  late InputDescriptor fullName, email, password, confirmPassword, phoneNumber;
  late ValueNotifier<bool> obscureText, confirmPasswordObscureText, loader;
  late GlobalKey<FormState> _formKey;
  late ValueNotifier<AutovalidateMode> _validationMode;
  File? profileImage;

  @override
  void initState() {
    super.initState();
    obscureText = ValueNotifier(true);
    confirmPasswordObscureText = ValueNotifier(true);
    loader = ValueNotifier(false);
    _formKey = GlobalKey<FormState>();
    _validationMode = ValueNotifier(AutovalidateMode.disabled);
    fullName = InputDescriptor(
        label: 'Full name',
        hint: 'Insert your Full name here',
        keyBoardType: TextInputType.name);
    email = InputDescriptor(
        label: 'Email',
        hint: 'Insert your email here',
        keyBoardType: TextInputType.emailAddress);
    password = InputDescriptor(
        label: 'Password',
        hint: 'Insert your Password here',
        keyBoardType: TextInputType.visiblePassword);
    confirmPassword = InputDescriptor(
        label: 'Confirm Password',
        hint: 'Insert your Password here',
        keyBoardType: TextInputType.visiblePassword);
    phoneNumber = InputDescriptor(
        label: 'Phone Number', hint: '+43', keyBoardType: TextInputType.phone);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      loader: loader,
      loaderText: 'Please wait...',
      appBarTitle: 'Register',
      body: ValueListenableBuilder<AutovalidateMode>(
          valueListenable: _validationMode,
          builder: (context, validationMode, _) {
            return Form(
              key: _formKey,
              autovalidateMode: validationMode,
              child: GestureDetector(
                onTap: () =>
                    FocusScope.of(context).requestFocus(new FocusNode()),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: HeaderSubtitle(
                        headerText: 'Personal Details',
                        subtitle: 'Create your HalalCheck account',
                      ),
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    ProfileImagePickerWidget(
                      image: profileImage,
                      onChange: (image) => profileImage = image,
                    ),
                    CustomTextField(
                      descriptor: fullName,
                      validator: ValidatorFunction.emptyValidationCheck,
                    ),
                    CustomTextField(
                      descriptor: email,
                      validator: ValidatorFunction.emailValidation,
                    ),
                    ValueListenableBuilder<bool>(
                        valueListenable: obscureText,
                        builder: (context, isObscure, _) {
                          return CustomTextField(
                              descriptor: password,
                              obscureText: isObscure,
                              validator: ValidatorFunction.passwordValidation,
                              suffixIcon: IconButton(
                                icon: Icon(isObscure
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded),
                                onPressed: () {
                                  obscureText.value = !isObscure;
                                },
                              ));
                        }),
                    ValueListenableBuilder<bool>(
                        valueListenable: confirmPasswordObscureText,
                        builder: (context, isObscure, _) {
                          return CustomTextField(
                              descriptor: confirmPassword,
                              obscureText: isObscure,
                              validator: (value) =>
                                  ValidatorFunction.confirmPasswordValidation(
                                      value, password.getText()),
                              suffixIcon: IconButton(
                                icon: Icon(isObscure
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded),
                                onPressed: () {
                                  confirmPasswordObscureText.value = !isObscure;
                                },
                              ));
                        }),
                    CustomTextField(
                      descriptor: phoneNumber,
                      validator: ValidatorFunction.phoneNumberValidation,
                      onFieldSubmitted: (_) {
                        onRegisterTap();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomGradientButton(
                        text: widget.isShopOwner ? 'Next' : 'Register',
                        onPressed: onRegisterTap),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  onRegisterTap() {
    if (_formKey.currentState!.validate() && profileImage != null) {
      FocusScope.of(context).unfocus();
      loader.value = true;
      final userDto = AuthDto(
          name: fullName.getText(),
          email: email.getText(),
          password: password.getText(),
          phoneNumber: phoneNumber.getText(),
          profileImage: profileImage);
      DI.i<AuthenticationProvider>().checkCredentialAvailablityAndVerifyPhone(
          dto: userDto, isShowOwner: widget.isShopOwner, loader: loader);
    } else {
      if (profileImage == null) {
        DI.i<NavigationService>().showSnackBar(message: 'Select Profile image');
      }
      _validationMode.value = AutovalidateMode.onUserInteraction;
    }
  }
}
