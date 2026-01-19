import 'package:reactive_forms/reactive_forms.dart';

import 'validators.dart';

extension AbstractControlExt<T> on AbstractControl<T> {
  bool get isRequired {
    return validators.contains(const RequiredValidator()) ||
        validators.contains(const AppRequiredValidator());
  }
}

extension FormControlExt<T> on FormControl<T> {
  bool get isRequired {
    return validators.contains(const RequiredValidator()) ||
        validators.contains(const AppRequiredValidator());
  }

  bool get needFocus {
    return invalid && enabled;
  }
}
