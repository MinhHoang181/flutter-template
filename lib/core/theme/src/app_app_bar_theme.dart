part of '../app_theme.dart';

class AppAppBarTheme extends AppBarThemeData {
  AppAppBarTheme({
    required ColorScheme colorScheme,
    required TextTheme textTheme,
  }) : super(
         /// Căn giữa tiêu đề
         centerTitle: true,

         /// Chiều cao của thanh công cụ trong AppBar
         toolbarHeight: kToolbarHeight,

         /// Khoảng cách xung quanh widget tiêu đề
         titleSpacing: null,

         /// Màu nền của thanh ứng dụng
         backgroundColor: colorScheme.surface,

         /// Màu chữ và icon trên thanh ứng dụng
         foregroundColor: colorScheme.onSurface,

         /// Màu tint cho hiệu ứng nâng cao Material 3
         surfaceTintColor: colorScheme.surfaceTint,

         /// Màu của bóng đổ được tạo bởi thanh ứng dụng
         shadowColor: null,

         /// Kiểu chữ cho tiêu đề thanh ứng dụng
         titleTextStyle: textTheme.titleLarge?.copyWith(
           color: colorScheme.onSurface,
           fontWeight: FontWeight.w600,
         ),

         /// Kiểu chữ cho văn bản trong thanh công cụ
         toolbarTextStyle: null,

         /// Theme cho các icon trong thanh ứng dụng (nút back, leading)
         iconTheme: IconThemeData(color: colorScheme.onSurface, size: 24),

         /// Theme cho các icon hành động trong thanh ứng dụng
         actionsIconTheme: IconThemeData(
           color: colorScheme.onSurface,
           size: 24,
         ),

         /// Độ nâng cao của thanh ứng dụng so với parent widget
         elevation: 0,

         /// Kiểu overlay cho system UI (thanh trạng thái, thanh điều hướng)
         systemOverlayStyle: null,

         /// Khoảng cách xung quanh các icon hành động
         actionsPadding: null,

         /// Kiểu shape cho thanh ứng dụng
         shape: null,
       );

  /// Hằng số: Chiều cao chuẩn của thanh công cụ theo Material Design
  static const double height = kToolbarHeight;
}

extension AppAppBarThemeExtension on BuildContext {
  double get appBarHeight =>
      Theme.of(this).appBarTheme.toolbarHeight ?? AppAppBarTheme.height;

  AppBarThemeData get appBarTheme => Theme.of(this).appBarTheme;
}
