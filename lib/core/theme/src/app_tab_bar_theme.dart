part of '../app_theme.dart';

class AppTabBarTheme extends TabBarThemeData {
  AppTabBarTheme({required ColorScheme colorScheme, required TextTheme textTheme})
    : super(
        /// Decoration cho gạch dưới tab
        indicator: BoxDecoration(color: colorScheme.primary, borderRadius: const BorderRadius.all(AppRadius.sm)),

        /// Màu gạch dưới tab
        indicatorColor: null,

        /// Kích thước gạch dưới (label/tab)
        indicatorSize: TabBarIndicatorSize.tab,

        /// Màu đường phân cách giữa các tab
        dividerColor: null,

        /// Chiều cao đường phân cách
        dividerHeight: null,

        /// Màu text tab được chọn
        labelColor: colorScheme.onPrimary,

        /// Padding xung quanh text tab
        labelPadding: const EdgeInsets.symmetric(vertical: AppSpacing.s3, horizontal: AppSpacing.s4),

        /// TextStyle cho tab được chọn
        labelStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.onPrimary, fontWeight: FontWeight.w500),

        /// Màu text tab không được chọn
        unselectedLabelColor: colorScheme.onSurfaceVariant,

        /// TextStyle cho tab không được chọn
        unselectedLabelStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w500,
        ),

        /// Màu overlay khi tap tab
        overlayColor: null,

        /// Hiệu ứng splash khi tap
        splashFactory: null,

        /// Con trỏ chuột khi hover
        mouseCursor: null,

        /// Căn chỉnh các tab (start/center)
        tabAlignment: null,

        /// Tỷ lệ scale text
        textScaler: null,

        /// Animation cho gạch dưới
        indicatorAnimation: null,

        /// Bo góc hiệu ứng splash
        splashBorderRadius: null,
      );
}
