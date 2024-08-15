import 'package:flutter/material.dart';
import 'package:halal_check/app_constants/image_constant.dart';
import 'package:halal_check/domain/authentication/models/loginDTO.dart';
import 'package:halal_check/provider/authentication_provider.dart';
import 'package:halal_check/screens/authentication/forgot_password_screen.dart';
import 'package:halal_check/screens/screen_layout.dart';
import 'package:halal_check/shared/component/heading_subtitle.dart';
import 'package:halal_check/shared/validator/validator.dart';
import 'package:halal_check/shared/widget/custom_gradient_button.dart';
import 'package:halal_check/shared/widget/custom_textform_field.dart';
import 'package:halal_check/theme/color_constant.dart';
import 'package:halal_check/theme/component_theme/custom_textstyle_theme.dart';

import '../../services/di_services.dart';

class LoginScreen extends StatefulWidget {
  static String route = '/login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late InputDescriptor email, password;
  late ValueNotifier<bool> obscureText, loader;
  late GlobalKey<FormState> _formKey;
  late ValueNotifier<AutovalidateMode> _validationMode;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obscureText = ValueNotifier(true);
    loader = ValueNotifier(false);
    _validationMode = ValueNotifier(AutovalidateMode.disabled);
    _formKey = GlobalKey<FormState>();
    email = InputDescriptor(
        label: 'Email',
        hint: 'Enter email',
        keyBoardType: TextInputType.emailAddress);
    password = InputDescriptor(
        label: 'Password',
        hint: 'Enter password',
        keyBoardType: TextInputType.visiblePassword);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      loader: loader,
      appBarTitle: 'Login',
      body: ValueListenableBuilder<AutovalidateMode>(
          valueListenable: _validationMode,
          builder: (context, validationMode, _) {
            return Form(
              key: _formKey,
              autovalidateMode: validationMode,
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Image.asset(
                    ImageConstant.halalCheckLogo,
                    height: 150,
                    width: 150,
                  ),
                  Text('Halal Check',
                      style: context.textTheme.titleLarge!.copyWith(
                          color: ColorConstantLight.primary, fontSize: 24)),
                  const SizedBox(
                    height: 40,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: HeaderSubtitle(
                      headerText: 'Welcome Back!',
                      subtitle: 'Log In to your HalalCheck account',
                    ),
                  ),
                  const SizedBox(
                    height: 26,
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
                            addBottomPadding: false,
                            onFieldSubmitted: (_) {
                              _onLogin();
                            },
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
                  const SizedBox(
                    height: 6,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ForgotPasswordScreen()));
                        },
                        child: Text(
                          'Forgot Password',
                          style: context.textTheme.displaySmall!
                              .copyWith(decoration: TextDecoration.underline),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomGradientButton(text: 'Login', onPressed: _onLogin),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            );
          }),
    );
  }

  _onLogin() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      loader.value = true;
      await DI.i<AuthenticationProvider>().loginWithAuthCredentials(
          LoginDTO(email: email.getText(), password: password.getText()));
      loader.value = false;
    } else {
      _validationMode.value = AutovalidateMode.onUserInteraction;
    }
  }
}
