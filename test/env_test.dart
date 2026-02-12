import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:template/core/constants/env_constants.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  final Map<String, Object?> data = dotenv.env;

  test('Check load env file success', () {
    expect(data.isNotEmpty, true);
  });

  test('Check has environment', () {
    final String? env = data[EnvConstants.ENV] as String?;
    expect(env != null && env.isNotEmpty, true);
  });

  test('Check has api url', () {
    final String? apiUrl = data[EnvConstants.API_URL] as String?;
    expect(apiUrl != null && apiUrl.isNotEmpty, true);
  });
}
