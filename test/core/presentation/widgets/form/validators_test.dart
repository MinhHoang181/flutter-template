import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:template/core/presentation/widgets/form/validators.dart';

void main() {
  group('AppPasswordValidator', () {
    test('should return null if value is null', () {
      const validator = AppPasswordValidator();
      final control = FormControl<String>(value: null);
      expect(validator.validate(control), isNull);
    });

    test('should return null if value is empty', () {
      const validator = AppPasswordValidator();
      final control = FormControl<String>(value: '');
      expect(validator.validate(control), isNull);
    });

    test('should return lessThanMin error if length is less than minLength', () {
      const validator = AppPasswordValidator(minLength: 8);
      final control = FormControl<String>(value: '1234567');
      final result = validator.validate(control);
      expect(result, isNotNull);
      expect(result!.containsKey(AppPasswordValidator.lessThanMin), isTrue);
    });

    test('should return noNumber error if containNumber is true and value has no number', () {
      const validator = AppPasswordValidator(containNumber: true);
      final control = FormControl<String>(value: 'abcdefgh');
      final result = validator.validate(control);
      expect(result, isNotNull);
      expect(result!.containsKey(AppPasswordValidator.noNumber), isTrue);
    });

    test('should return noUppercase error if containUppercase is true and value has no uppercase', () {
      const validator = AppPasswordValidator(containUppercase: true);
      final control = FormControl<String>(value: 'abcdefgh1');
      final result = validator.validate(control);
      expect(result, isNotNull);
      expect(result!.containsKey(AppPasswordValidator.noUppercase), isTrue);
    });

    test('should return noLowercase error if containLowercase is true and value has no lowercase', () {
      const validator = AppPasswordValidator(containLowercase: true);
      final control = FormControl<String>(value: 'ABCDEFGH1');
      final result = validator.validate(control);
      expect(result, isNotNull);
      expect(result!.containsKey(AppPasswordValidator.noLowercase), isTrue);
    });

    test('should return noSpecialChar error if containSpecialChar is true and value has no special char', () {
      const validator = AppPasswordValidator(containSpecialChar: true);
      final control = FormControl<String>(value: 'Abcdefgh1');
      final result = validator.validate(control);
      expect(result, isNotNull);
      expect(result!.containsKey(AppPasswordValidator.noSpecialChar), isTrue);
    });

    test('should return null if all requirements are met', () {
      const validator = AppPasswordValidator(
        minLength: 8,
        containNumber: true,
        containUppercase: true,
        containLowercase: true,
        containSpecialChar: true,
      );
      final control = FormControl<String>(value: 'Abcdefgh1!');
      expect(validator.validate(control), isNull);
    });
  });
}
