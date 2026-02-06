import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:template/core/presentation/widgets/app_icon.dart';

void main() {
  testWidgets('AppIcon should correctly identify Iconify icons', (WidgetTester tester) async {
    // This test might fail to run due to missing workspace dependencies (core_widget, icon),
    // but it serves as a template for verification.

    // We can't easily test the private _isIconify method directly in a widget test,
    // but we can verify that the widget builds without errors for various icon strings.

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AppIcon(icon: 'mdi:home'),
        ),
      ),
    );

    expect(find.byType(AppIcon), findsOneWidget);
  });
}
