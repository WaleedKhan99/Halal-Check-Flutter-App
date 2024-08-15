import 'dart:async';
import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_places_flutter/model/prediction.dart';

import 'package:halal_check/app_constants/icons_constants.dart';
import 'package:halal_check/screens/registration/shop_timing_screen.dart';
import 'package:halal_check/screens/registration/widgets/shop_timings_bottom_sheet.dart';
import 'package:halal_check/screens/screen_layout.dart';
import 'package:halal_check/services/navigation_services.dart';
import 'package:halal_check/shared/helper/helper_function.dart';
import 'package:halal_check/shared/validator/validator.dart';
import 'package:halal_check/shared/widget/custom_text.dart';
import 'package:halal_check/shared/widget/custom_textform_field.dart';
import 'package:halal_check/shared/widget/tap_widget.dart';
import 'package:halal_check/theme/color_constant.dart';
import 'package:halal_check/theme/component_theme/custom_textstyle_theme.dart';

import '../../domain/authentication/models/authDTO.dart';
import '../../domain/authentication/models/shop_detail_DTO.dart';
import '../../domain/shop_details/model/shop_timing_model.dart';
import '../../provider/authentication_provider.dart';
import '../../services/di_services.dart';
import '../../services/google_apis/place_api/place_api_provider.dart';
import '../../shared/component/heading_subtitle.dart';
import '../../shared/widget/custom_gradient_button.dart';

class ShopDetailRegistrationScreen extends StatefulWidget {
  static String route = '/shop_registration_screen';
  final AuthDto dto;

  // final AuthDto? dto;

  const ShopDetailRegistrationScreen({super.key, required this.dto});

  // const ShopDetailRegistrationScreen({super.key, this.dto});

  @override
  State<ShopDetailRegistrationScreen> createState() =>
      _ShopDetailRegistrationScreenState();
}

class _ShopDetailRegistrationScreenState
    extends State<ShopDetailRegistrationScreen> {
  final ValueNotifier<List<File>> _images = ValueNotifier([]);
  final ValueNotifier<bool> _isCheckedNotifier = ValueNotifier<bool>(false);
  final _placeAPIProvider = DI.i<PlaceApiProvider>();

  late InputDescriptor shopName,
      searchAddress,
      shopAddress,
      shopCity,
      shopPostalCode,
      shopDistrict,
      shopCountry,
      companyName,
      halalCertificate,
      companyLogo,
      companyPictures,
      companyDescription,
      shopCategory,
      shopTiming;
  File? logoImage, halalCertificateImage;
  late ValueNotifier<bool> loader;
  late GlobalKey<FormState> _formKey;
  late ValueNotifier<AutovalidateMode> _autoValidation;
  late ValueNotifier<ShopTimingModel> _timingModel;

  @override
  void initState() {
    super.initState();
    loader = ValueNotifier(false);
    _formKey = GlobalKey<FormState>();
    _autoValidation = ValueNotifier(AutovalidateMode.disabled);

    _timingModel = ValueNotifier(ShopTimingModel.initializeTiming());

    shopName = InputDescriptor(
        label: 'Shop name',
        hint: 'Insert your Shop name here',
        keyBoardType: TextInputType.name);
    searchAddress = InputDescriptor(
        label: 'Search',
        hint: 'Search address here',
        keyBoardType: TextInputType.text);
    shopAddress = InputDescriptor(
        label: 'Shop Address',
        hint: 'Insert your shop address here',
        keyBoardType: TextInputType.streetAddress);
    shopCity = InputDescriptor(
        label: 'Shop City',
        hint: 'Insert your city here',
        keyBoardType: TextInputType.text);
    shopPostalCode = InputDescriptor(
        label: 'Shop postal code',
        hint: 'Insert your shop postal code here',
        keyBoardType: TextInputType.number);
    shopDistrict = InputDescriptor(
        label: 'Shop District',
        hint: 'Insert your shop district here',
        keyBoardType: TextInputType.text);
    shopCountry = InputDescriptor(
        label: 'Shop Country',
        hint: 'Select your shop country here',
        keyBoardType: TextInputType.name);
    companyName = InputDescriptor(
        label: 'Company Name',
        hint: 'Insert your Company here',
        keyBoardType: TextInputType.name);
    companyLogo = InputDescriptor(
        label: 'Company Logo',
        hint: 'Upload your logo here',
        keyBoardType: TextInputType.name);
    companyPictures = InputDescriptor(
        label: 'Company Pictures (Max 8 Pictures)',
        hint: 'Upload pictures here',
        keyBoardType: TextInputType.name);
    companyDescription = InputDescriptor(
        label: 'Company Description',
        hint: 'Write Description',
        keyBoardType: TextInputType.text);
    halalCertificate = InputDescriptor(
        label: 'Halal Certificate',
        hint: 'Upload your HC here',
        keyBoardType: TextInputType.name);
    shopTiming = InputDescriptor(
        label: 'Opening Days & Time',
        hint: 'Select your open days here',
        keyBoardType: TextInputType.name);
    shopCategory =
        InputDescriptor(label: 'Category', hint: 'Select shop category here');
  }

  final List<String> _categoryList = [
    'Cars',
    'Beauty and Spas',
    'Electronics',
    'Fitness',
    'Leisure and Kids',
    'Jeweler',
    'Art and Entertainment',
    'Restaurant',
    'Shop',
    'Local Services',
    'Medicine',
    'Travel',
    'Pets',
    'Furniture'
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      appBarTitle: 'Register',
      loaderText: 'Please wait...',
      loader: loader,
      body: ValueListenableBuilder<AutovalidateMode>(
        valueListenable: _autoValidation,
        builder: (context, validation, _) {
          return Form(
            key: _formKey,
            autovalidateMode: validation,
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: HeaderSubtitle(
                    headerText: 'Company & Shop Details',
                    subtitle: 'Create your HalalCheck account',
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                CustomTextField(
                  descriptor: shopName,
                  validator: ValidatorFunction.emptyValidationCheck,
                ),
                // ==================== Search Field ====================
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      descriptor: searchAddress,
                      validator: ValidatorFunction.emptyValidationCheck,
                      enabled: !_isCheckedNotifier.value,
                      onChanged: (value) {
                        if (!_isCheckedNotifier.value) {
                          threshHolding(value);
                        }
                      },
                    ),
                    ValueListenableBuilder<List<Prediction>>(
                      valueListenable: _placeAPIProvider.predictionsNotifier,
                      builder: (context, predictions, _) {
                        return predictions.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: predictions.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                        predictions[index].description ?? ""),
                                    onTap: () {
                                      searchAddress.controller.text =
                                          predictions[index].description ?? "";
                                      // We can Clear the predictions list by updating the ValueNotifier
                                      _placeAPIProvider
                                          .predictionsNotifier.value = [];
                                    },
                                  );
                                },
                              )
                            : Container();
                      },
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _isCheckedNotifier.value,
                          onChanged: (newValue) {
                            setState(() {
                              _isCheckedNotifier.value = newValue ?? false;
                              if (_isCheckedNotifier.value) {
                                // If checked, clear the search address
                                searchAddress.controller.clear();
                              }
                            });
                          },
                        ),
                        const LabelText(
                          labeltext:
                              "Choose between manual entry\nor autocomplete search.",
                          labelcolor: Colors.grey,
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // =======================================================
                CustomTextField(
                  descriptor: shopAddress,
                  validator: ValidatorFunction.emptyValidationCheck,
                  enabled: _isCheckedNotifier.value,
                ),
                CustomTextField(
                  descriptor: shopCity,
                  validator: ValidatorFunction.emptyValidationCheck,
                  enabled: _isCheckedNotifier.value,
                ),
                CustomTextField(
                  descriptor: shopPostalCode,
                  validator: ValidatorFunction.emptyValidationCheck,
                  enabled: _isCheckedNotifier.value,
                ),
                CustomTextField(
                  descriptor: shopDistrict,
                  validator: ValidatorFunction.emptyValidationCheck,
                  enabled: _isCheckedNotifier.value,
                ),
                CustomTextField(
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      showPhoneCode: false,
                      countryListTheme: CountryListThemeData(
                        flagSize: 20.r,
                        bottomSheetHeight: 0.6.sh,
                        backgroundColor: Colors.white,
                      ),
                      onSelect: (Country value) {
                        shopCountry.controller.text =
                            value.displayNameNoCountryCode;
                      },
                    );
                  },
                  enabled: _isCheckedNotifier.value,
                  readOnly: true,
                  descriptor: shopCountry,
                  validator: ValidatorFunction.emptyValidationCheck,
                ),
                CustomTextField(
                  descriptor: companyName,
                  validator: ValidatorFunction.emptyValidationCheck,
                ),
                CustomTextField(
                  descriptor: halalCertificate,
                  readOnly: true,
                  enabled: false,
                  validator: ValidatorFunction.emptyValidationCheck,
                  onTap: () {
                    HelperFunction.getImageWithFileName(
                      showFilePicker: true,
                      title: 'Select file source',
                      subTitle: 'Select source for your halal certificate',
                      onChange: (fileName, file) {
                        halalCertificateImage = file;
                        halalCertificate.controller.text = fileName;
                      },
                    );
                  },
                  suffixIcon: const CustomGradientButton(
                    text: 'Upload',
                    width: 100,
                  ),
                ),
                CustomTextField(
                  descriptor: companyLogo,
                  readOnly: true,
                  enabled: false,
                  validator: ValidatorFunction.emptyValidationCheck,
                  onTap: () {
                    HelperFunction.getImageWithFileName(
                      showFilePicker: false,
                      title: 'Select image source',
                      subTitle: 'Select source for your company logo',
                      onChange: (fileName, file) {
                        logoImage = file;
                        companyLogo.controller.text = fileName;
                      },
                    );
                  },
                  suffixIcon: const CustomGradientButton(
                    text: 'Upload',
                    width: 100,
                  ),
                ),
                CustomTextField(
                  descriptor: companyPictures,
                  readOnly: true,
                  enabled: false,
                  onTap: () async {
                    _images.value = [];
                    List<File> images = await HelperFunction.pickImages(8);
                    _images.value = [...images];
                  },
                  suffixIcon: const CustomGradientButton(
                    text: 'Upload',
                    width: 100,
                  ),
                ),
                CustomTextField(
                  maxlines: 6,
                  radius: 12.r,
                  descriptor: companyDescription,
                  validator: ValidatorFunction.emptyValidationCheck,
                ),

                ValueListenableBuilder(
                  valueListenable: _timingModel,
                  builder: (context, timing, _) {
                    return CustomTextField(
                      descriptor: shopTiming,
                      readOnly: true,
                      enabled: false,
                      spaceBetweenHeight: 0,
                      onTap: () async {
                        final response = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ShopTimingScreen(
                                shopTiming: timing,
                              );
                            },
                          ),
                        );
                        if (response != null) {
                          _timingModel.value = response;
                        }
                      },
                      suffixIcon: const CustomGradientButton(
                        text: 'Open hours',
                        width: 100,
                      ),
                      trailing: TapWidget(
                        padding: EdgeInsets.all(8.r),
                        child: const Text('see timings'),
                        onTap: () {
                          DI.i<NavigationService>().showBottomsheet(
                                child: ShopTimingsBottomSheet(
                                  shopTiming: timing,
                                ),
                              );
                        },
                      ),
                    );
                  },
                ),

                CustomTextField(
                  descriptor: shopCategory,
                  readOnly: true,
                  enabled: false,
                  validator: ValidatorFunction.emptyValidationCheck,
                  suffixIcon: const Icon(Icons.arrow_drop_down),
                  onTap: () {
                    DI.i<NavigationService>().showBottomsheet(
                          child: Expanded(
                            child: ListView.builder(
                              itemCount: _categoryList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    shopCategory.controller.text =
                                        _categoryList[index].toString();
                                  },
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title:
                                        Text(_categoryList[index].toString()),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),

                ValueListenableBuilder(
                  valueListenable: _images,
                  builder: (context, images, _) {
                    return images.isEmpty
                        ? const SizedBox.shrink()
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 8.h),
                                child: Text(
                                  'Shop Pictures',
                                  style: context.textTheme.labelMedium!,
                                ),
                              ),
                              GridView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.only(bottom: 40.h),
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1,
                                  // mainAxisSpacing: 3.r,
                                  // crossAxisSpacing: 3.r,
                                ),
                                itemCount: images.length,
                                itemBuilder: (context, i) => Stack(
                                  children: [
                                    Image.file(
                                      images[i],
                                      width: 172.r,
                                      height: 172.r,
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      top: 10.r,
                                      right: 10.r,
                                      child: TapWidget(
                                        circle: true,
                                        padding: EdgeInsets.all(5.r),
                                        color: ColorConstantLight.trash,
                                        onTap: () {
                                          // Update the state by removing the item at index i
                                          List<File> currentImages =
                                              List.from(_images.value);
                                          currentImages.removeAt(i);
                                          _images.value = currentImages;
                                        },
                                        child: SvgPicture.asset(
                                            IconsConstant.trash),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                  },
                ),

                CustomGradientButton(
                  text: 'Register',
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        _images.value.isNotEmpty) {
                      FocusScope.of(context).unfocus();
                      loader.value = true;
                      final shopDto = ShopDetailDTO(
                        category: shopCategory.getText(),
                        name: shopName.getText(),
                        search: searchAddress.getText(),
                        address: shopAddress.getText(),
                        city: shopCity.getText(),
                        postalCode: shopPostalCode.getText(),
                        district: shopDistrict.getText(),
                        country: shopCountry.getText(),
                        description: companyDescription.getText(),
                        companyName: companyName.getText(),
                        certificate: halalCertificateImage!,
                        shopPictures: _images.value,
                        logo: logoImage!,
                      );
                      DI.i<AuthenticationProvider>().sentVerificationCode(
                          // ====================================
                          dto: widget.dto,
                          // dto: widget.dto!,
//                           // ====================================

                          shopDto: shopDto,
                          timingModel: _timingModel.value,
                          loader: loader);
                    } else if (_images.value.isEmpty) {
                      DI.i<NavigationService>().showToast(
                          message: 'please upload at least one shop picture');
                    } else {
                      _autoValidation.value =
                          AutovalidateMode.onUserInteraction;
                    }
                  },
                ),

                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Timer? timer;

  void threshHolding(String vl) {
    vl = vl.trim();
    if (timer != null && timer!.isActive) timer!.cancel();
    timer = Timer(const Duration(milliseconds: 500), () {
      _placeAPIProvider.placeAutoCompete(vl);
      timer!.cancel();
    });
  }
}



// =========================================================================================


