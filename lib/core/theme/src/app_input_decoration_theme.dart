part of '../app_theme.dart';

class AppInputDecorationTheme extends InputDecorationTheme {
  AppInputDecorationTheme({required ColorScheme colorScheme, required TextTheme textTheme})
    : super(
        /// Kiểu chữ của label
        labelStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface, fontWeight: FontWeight.w500),

        /// Kiểu chữ của floating label
        floatingLabelStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface, fontWeight: FontWeight.w500),

        /// Kiểu chữ của helper
        helperStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant, fontWeight: FontWeight.w500),

        /// Số dòng tối đa của helper
        helperMaxLines: null,

        /// Kiểu chữ của hint
        hintStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant, fontWeight: FontWeight.w500),

        /// Thời gian mờ của hint
        hintFadeDuration: null,

        /// Kiểu chữ của error
        errorStyle: textTheme.bodySmall?.copyWith(color: colorScheme.error, fontWeight: FontWeight.w500),

        /// Số dòng tối đa của error
        errorMaxLines: null,

        /// Kiểu behavior của floating label
        floatingLabelBehavior: FloatingLabelBehavior.always,

        /// Kiểu alignment của floating label
        floatingLabelAlignment: FloatingLabelAlignment.start,

        /// Kiểu dense của input
        isDense: false,

        /// Padding của content
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4, vertical: AppSpacing.s3),

        /// Kiểu collapsed của input
        isCollapsed: false,

        /// Màu của icon
        iconColor: null,

        /// Kiểu chữ của prefix
        prefixStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant, fontWeight: FontWeight.w500),

        /// Màu của icon của prefix
        prefixIconColor: null,

        /// Constraints của icon của prefix
        prefixIconConstraints: null,

        /// Kiểu chữ của suffix
        suffixStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant, fontWeight: FontWeight.w500),

        /// Màu của icon của suffix
        suffixIconColor: null,

        /// Constraints của icon của suffix
        suffixIconConstraints: null,

        /// Kiểu chữ của counter
        counterStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant, fontWeight: FontWeight.w500),

        /// Kiểu filled của input
        filled: false,

        /// Màu của fill của input
        fillColor: null,

        /// Kiểu border của input
        activeIndicatorBorder: null,

        /// Kiểu border của input
        outlineBorder: null,

        /// Màu của focus của input
        focusColor: null,

        /// Màu của hover của input
        hoverColor: null,

        /// Kiểu border của error của input
        errorBorder: null,

        /// Kiểu border của focused của input
        focusedBorder: null,

        /// Kiểu border của focused error của input
        focusedErrorBorder: null,

        /// Kiểu border của disabled của input
        disabledBorder: null,

        /// Kiểu border của enabled của input
        enabledBorder: null,

        /// Kiểu border của input
        border: null,

        /// Kiểu align label with hint của input
        alignLabelWithHint: false,

        /// Constraints của input
        constraints: null,
      );
}
