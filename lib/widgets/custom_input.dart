import 'package:extended_phone_number_input/phone_number_controller.dart';
import 'package:extended_phone_number_input/phone_number_input.dart';
import 'package:faza_app/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';
import '../helper/storage_helper.dart';

// ignore: must_be_immutable
class CustomInput extends StatefulWidget {
  CustomInput({
    Key? key,
    this.icon,
    this.isObscure,
    this.title = '',
    required this.hint,
    required this.textInputType,
    this.controller,
    this.formValidator,
    this.isEnabled = true,
    this.minLines = 1,
    this.onTap,
    this.onChange,
    this.autoFocus = false,
  }) : super(key: key);

  IconData? icon;
  bool? isObscure;
  String? title = '';
  String hint;
  TextInputType textInputType;
  TextEditingController? controller;
  FormFieldValidator? formValidator;
  bool? isEnabled;
  bool? autoFocus = false;
  int? minLines;
  Function()? onTap;
  Function(String)? onChange;
  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool isPasswordShow = true;

  showOrHidePassword() {
    setState(() {
      isPasswordShow = !isPasswordShow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: widget.autoFocus ?? false,
      onTap: widget.onTap,
      onChanged: widget.onChange,
      minLines: widget.isObscure ?? false ? 1 : widget.minLines,
      maxLines: widget.isObscure ?? false ? 1 : 7,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.formValidator,
      controller: widget.controller,
      keyboardType: widget.textInputType,
      cursorColor: AppColors.primaryColor,
      obscureText: widget.isObscure ?? false ? isPasswordShow : false,
      enabled: widget.isEnabled,
      decoration: InputDecoration(
          fillColor: AppColors.backgroundColor,
          contentPadding: const EdgeInsets.all(kPadding / 2),
          suffixIcon: widget.icon == null
              ? null
              : Icon(
                  widget.icon,
                  color: AppColors.greyBackground,
                ),
          label: widget.title == "" ? null : Text(widget.title ?? ""),
          labelStyle: const TextStyle(
            color: AppColors.black50,
          ),
          hintText: widget.hint,
          hintStyle: const TextStyle(
            color: AppColors.black50,
          ),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
            borderSide: const BorderSide(
              color: AppColors.black50,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
            borderSide: const BorderSide(
              color: AppColors.backgroundColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
            borderSide: const BorderSide(
              color: AppColors.black50,
            ),
          )),
    );
  }
}

// ignore: must_be_immutable
class CustomPhoneInput extends StatefulWidget {
  CustomPhoneInput({
    Key? key,
    this.controller,
    required this.onCountryChange,
    this.onValueChange,
    this.formValidator,
    this.autoFocus,
    this.initialCountryCode,
  }) : super(key: key);

  TextEditingController? controller;
  FormFieldValidator? formValidator;
  Function(Country)? onCountryChange;
  Function(String)? onValueChange;
  String? initialCountryCode;
  bool? autoFocus;

  @override
  State<CustomPhoneInput> createState() => _CustomPhoneInputState();
}

class _CustomPhoneInputState extends State<CustomPhoneInput> {
  @override
  Widget build(BuildContext context) {
    // return Directionality(
    //   textDirection: TextDirection.ltr,
    //   child: InternationalPhoneNumberInput(
    //     autoValidateMode: AutovalidateMode.onUserInteraction,
    //     locale: Get.locale.toString() == 'en_US' ? 'en' : 'ar',
    //     // maxLength: 9,
    //     countries: const [
    //       "AE",
    //       "QA",
    //       "OM",
    //       "KW",
    //       "BH",
    //       "SA",
    //       // "PK", don't show i confirmed from client
    //     ],
    //     hintText: "SEARCH_COUNTRY".tr,
    //     errorMessage: "INVALID_MOBILE_NUMBER".tr,
    //     keyboardType: TextInputType.phone,
    //     // initialValue: PhoneNumber(isoCode: countryISO),
    //     selectorConfig: const SelectorConfig(
    //       selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
    //     ),
    //     onInputChanged: (value) {
    //       // print(value.isoCode);
    //       // countryISO = value.isoCode ?? "SA";
    //     },
    //   ),
    // );

    //? ============== SECOND ==============
    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(8)),
      child: PhoneNumberInput(
        initialCountry: 'SA',
        includedCountries: const ["SA"],
        showSelectedFlag: false,
        controller: PhoneNumberInputController(context),
        locale: StorageService.getcurrentLanguage(),
        searchHint: "SEARCH_COUNTRY_CODE".tr,
        errorText: "INVALID_MOBILE_NUMBER".tr,
        hint: "5xxxxxxxxx".tr,
        onChanged: widget.onValueChange,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        enabledBorder: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
          borderSide: const BorderSide(
            color: AppColors.black50,
          ),
        ),
      ),
    );

    //? ============== FIRST ==============
    // return Directionality(
    //   textDirection: TextDirection.ltr,
    //   child: IntlPhoneField(
    //     validator: (value) {
    //       return null;
    //     },
    //     autovalidateMode: AutovalidateMode.onUserInteraction,
    //     invalidNumberMessage: "INVALID_MOBILE_NUMBER".tr,
    //     onCountryChanged: widget.onCountryChange,
    //     autofocus: widget.autoFocus ?? false,
    //     controller: widget.controller,
    //     flagsButtonPadding: const EdgeInsets.only(left: 5),
    //     dropdownIconPosition: IconPosition.trailing,
    //     cursorColor: AppColors.greyBackground,
    //     keyboardType: TextInputType.phone,
    //     initialValue: "",
    //     dropdownIcon: const Icon(
    //       EvaIcons.arrowIosDownwardOutline,
    //       color: AppColors.black50,
    //       size: 18,
    //     ),
    //     textAlign: TextAlign.left,
    //     pickerDialogStyle: PickerDialogStyle(
    //       searchFieldInputDecoration: customInputDecoration(
    //         hint: "SEARCH_COUNTRY".tr,
    //       ),
    //       countryCodeStyle: const TextStyle(),
    //     ),
    //     initialCountryCode: widget.initialCountryCode ?? initialCountry,
    //     decoration: customInputDecoration(
    //       hint: "ENTER_YOUR_PHONE_NUMBER".tr,
    //     ),
    //   ),
    // );
  }
}

// ignore: must_be_immutable
class CustomVerificationInput extends StatelessWidget {
  CustomVerificationInput({
    Key? key,
    required this.onSubmitted,
    this.onChange,
    this.textEditingController,
  }) : super(key: key);

  Function(String) onSubmitted;
  Function(String)? onChange;
  TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        appContext: context,
        length: 6,
        animationType: AnimationType.scale,
        cursorColor: AppColors.greyBackground,
        cursorHeight: 20,
        // errorAnimationController: errorController,
        controller: textEditingController,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.underline,
          activeColor: AppColors.grey,
          selectedColor: AppColors.grey,
          inactiveColor: AppColors.grey,
          fieldHeight: 50,
          fieldWidth: 40,
          activeFillColor: Colors.white,
        ),
        keyboardType: TextInputType.number,
        autoFocus: true,
        onSubmitted: onSubmitted,
        onCompleted: onSubmitted,
        beforeTextPaste: (text) {
          return true;
        },
        onChanged: onChange ?? (String value) {},
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomLocationInput extends StatelessWidget {
  CustomLocationInput({
    Key? key,
    required this.controller,
    this.latLngDetailFunction,
    this.itemClickFunction,
    this.onTrailingIconClick,
  }) : super(key: key);

  TextEditingController controller;
  Function(Prediction)? latLngDetailFunction;
  Function(Prediction)? itemClickFunction;
  Function()? onTrailingIconClick;

  @override
  Widget build(BuildContext context) {
    return GooglePlaceAutoCompleteTextField(
      textEditingController: controller,
      googleAPIKey: API_KEY,
      inputDecoration: customInputDecoration(
        hint: "Enter the location",
        trailingIcon: Icons.location_on_outlined,
        onTrailingIconClick: onTrailingIconClick,
      ),
      debounceTime: 400,
      countries: const ["PS", "SA"],
      isLatLngRequired: true,
      getPlaceDetailWithLatLng: latLngDetailFunction,
      itemClick: itemClickFunction,
    );
  }
}

// ===================================

InputDecoration customInputDecoration({
  IconData? leadingIcon,
  IconData? trailingIcon,
  String? title,
  String? hint,
  Color? borderColor,
  Function()? onTrailingIconClick,
}) {
  return InputDecoration(
    counterText: "",
    fillColor: AppColors.white,
    contentPadding: const EdgeInsets.all(kPadding / 2),
    prefixIcon: leadingIcon == null
        ? null
        : Icon(
            leadingIcon,
            color: AppColors.greyBackground,
          ),
    suffixIcon: trailingIcon == null
        ? null
        : IconButton(
            splashRadius: 5,
            onPressed: onTrailingIconClick,
            icon: Icon(
              trailingIcon,
              color: AppColors.greyBackground,
            ),
          ),
    label: title == null ? null : Text(title),
    labelStyle: const TextStyle(
      color: AppColors.black50,
    ),
    hintText: hint,
    hintStyle: const TextStyle(
      color: AppColors.black50,
    ),
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kBorderRadius),
      borderSide: BorderSide(
        color: borderColor ?? AppColors.black50,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kBorderRadius),
      borderSide: BorderSide(
        color: borderColor ?? AppColors.backgroundColor,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kBorderRadius),
      borderSide: BorderSide(
        color: borderColor ?? AppColors.black50,
      ),
    ),
  );
}
