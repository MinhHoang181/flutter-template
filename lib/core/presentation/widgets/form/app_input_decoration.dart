import 'package:flutter/material.dart';
import '../../../theme/app_colors/app_colors.dart';
import '../../../theme/app_fonts.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_spacing.dart';

class AppInputDecoration {
  AppInputDecoration._();

  static InputDecoration basic({
    bool disabled = false,
    String? hintText,
    Widget? suffixIcon,
    Widget? prefixIcon,
    String? errorText,
    bool? filled = true,
    Color? fillColor,
    InputBorder? border,
    BorderSide? borderSide,
    EdgeInsets? contentPadding = const EdgeInsets.symmetric(
      horizontal: AppSpacing.s4,
      vertical: AppSpacing.s3,
    ),
  }) {
    borderSide ??= const BorderSide(color: AppColors.gray300, width: 1);

    border ??= OutlineInputBorder(
      borderRadius: const BorderRadius.all(AppRadius.lg),
      borderSide: borderSide,
      gapPadding: 2.5,
    );

    return InputDecoration(
      isDense: true,
      // text style
      contentPadding: contentPadding,
      hintText: hintText,
      hintStyle: AppFonts.size14Regular.copyWith(
        color: AppColors.gray400,
        height: 1.25,
      ),
      errorText: errorText,
      errorStyle: AppFonts.size12Regular.copyWith(color: AppColors.red600),
      errorMaxLines: 2,
      counterStyle: AppFonts.size12Regular.copyWith(color: AppColors.gray500),
      // suffix & prefix
      iconColor: AppColors.gray500,
      prefixIconColor: AppColors.gray500,
      suffixIconColor: AppColors.gray500,
      suffix: null,
      suffixIcon: suffixIcon != null
          ? Padding(
              padding: const EdgeInsets.only(
                right: AppSpacing.s4,
                left: AppSpacing.s2,
              ),
              child: suffixIcon,
            )
          : null,
      prefix: null,
      prefixIcon: prefixIcon != null
          ? Padding(
              padding: const EdgeInsets.only(
                right: AppSpacing.s2,
                left: AppSpacing.s4,
              ),
              child: prefixIcon,
            )
          : null,
      suffixIconConstraints: suffixIcon != null
          ? const BoxConstraints(minHeight: 18, minWidth: 18)
          : null,
      prefixIconConstraints: prefixIcon != null
          ? const BoxConstraints(minHeight: 18, minWidth: 18)
          : null,
      // border
      filled: filled,
      fillColor: fillColor ?? (disabled ? AppColors.gray50 : AppColors.white),
      border: border,
      enabledBorder: border,
      focusedBorder: border,
      disabledBorder: border,
      errorBorder: border.copyWith(
        borderSide: borderSide.copyWith(color: AppColors.red600),
      ),
      focusedErrorBorder: border.copyWith(
        borderSide: borderSide.copyWith(color: AppColors.red600),
      ),
    );
  }
}
