import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halal_check/theme/color_constant.dart';
import 'package:halal_check/theme/component_theme/custom_textstyle_theme.dart';

class InputDescriptor {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  final String? label, hint;
  final TextInputType keyBoardType;

  InputDescriptor({
    String initialValue = '',
    this.hint,
    this.label,
    this.keyBoardType = TextInputType.text,
  }) {
    _controller = TextEditingController(text: initialValue);
    _focusNode = FocusNode();
  }

  FocusNode get focus => _focusNode;

  TextEditingController get controller => _controller;

  dispose() {
    _controller.dispose();
    _focusNode.dispose();
  }

  String getText() {
    return _controller.text.trim();
  }
}

class CustomTextField extends StatelessWidget {
  final InputDescriptor descriptor;
  final void Function(String)? onChanged;
  final bool addBottomPadding;
  final int? maxlines, maxLength;
  final String? errorMessage;
  final String? initialValue;
  final bool obscureText, enabled;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onFieldSubmitted;
  final bool readOnly, autofocus;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon, trailing;
  final Color? fillColor;
  final double? radius, spaceBetweenHeight; // New parameter for custom border radius
  final InputBorder? enabledBorder;

  const CustomTextField({
    required this.descriptor,
    this.onChanged,
    this.errorMessage,
    this.spaceBetweenHeight,
    this.initialValue,
    this.obscureText = false,
    this.enabled = true,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters = const [],
    this.onFieldSubmitted,
    this.readOnly = false,
    this.autofocus = false,
    this.onTap,
    this.validator,
    this.suffixIcon,
    this.addBottomPadding = true,
    this.maxLength,
    this.maxlines,
    this.prefixIcon,
    this.trailing,
    this.fillColor,
    this.radius, // Initialize the new parameter
    this.enabledBorder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Define border radius here
    // ignore: unused_local_variable
    final BorderRadius borderRadiusValue = BorderRadius.circular(radius ?? 0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (descriptor.label != null || trailing != null) ...[
          Row(
            children: [
              if (descriptor.label != null)
                Text(
                  descriptor.label!,
                  style: context.textTheme.labelMedium!,
                ),
              if (trailing != null) ...[
                const Spacer(),
                trailing!,
              ],
            ],
          ),
          SizedBox(
            height: spaceBetweenHeight ?? 8,
          )
        ],
        InkWell(
          onTap: onTap,
          child: TextFormField(
            controller: initialValue != null ? null : descriptor.controller,
            focusNode: descriptor.focus,
            onChanged: onChanged,
            readOnly: readOnly,
            autofocus: autofocus,
            inputFormatters: inputFormatters,
            keyboardType: descriptor.keyBoardType,
            textInputAction: textInputAction,
            initialValue: initialValue,
            validator: validator,
            obscureText: obscureText,
            enabled: enabled,
            onFieldSubmitted: onFieldSubmitted,
            obscuringCharacter: '*',
            maxLines: maxlines ?? 1,
            maxLength: maxLength,
            decoration: InputDecoration(
              filled: true,
              fillColor: fillColor,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              hintText: descriptor.hint,
              focusedErrorBorder: _border,
              disabledBorder: _border,
              errorText: errorMessage,
              enabledBorder: _border,
              focusedBorder: _border,
              errorBorder: _border,
              border: _border,
            ),
          ),
        ),
        if (addBottomPadding)
          const SizedBox(
            height: 18,
          ),
      ],
    );
  }

  InputBorder get _border {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? 100.r),
      borderSide: const BorderSide(
        color: ColorConstantLight.border,
      ),
    );
  }
}
