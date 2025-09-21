part of '../app_theme.dart';

class AppButtonTheme extends ButtonThemeData {
  const AppButtonTheme({required ColorScheme colorScheme})
    : super(
        /// Màu sắc của button
        colorScheme: colorScheme,

        /// Kiểu chữ của button
        textTheme: ButtonTextTheme.primary,

        /// Chiều rộng tối thiểu của button
        minWidth: 88.0,

        /// Chiều cao của button
        height: 36.0,

        /// Padding của button
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4, vertical: AppSpacing.s3),

        /// Kiểu shape của button
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(AppRadius.lg)),

        /// Kiểu layout của button
        layoutBehavior: ButtonBarLayoutBehavior.padded,

        /// Căn chỉnh dropdown
        alignedDropdown: false,

        /// Màu sắc của button
        buttonColor: null,

        /// Màu sắc của button khi disabled
        disabledColor: null,

        /// Màu sắc của button khi focus
        focusColor: null,

        /// Màu sắc của button khi hover
        hoverColor: null,

        /// Màu sắc của button khi highlight
        highlightColor: null,

        /// Màu sắc của button khi splash
        splashColor: null,

        /// Kiểu material tap target size của button
        materialTapTargetSize: MaterialTapTargetSize.padded,
      );
}
