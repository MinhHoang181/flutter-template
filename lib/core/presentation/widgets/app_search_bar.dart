import 'package:core_extension/core_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icon/icon.dart';
import 'package:template/app/app.dart';
import 'package:template/gen/locale_keys.gen.dart';

import '../../theme/app_colors/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';
import '../../utils/debouncer.dart';
import 'app_button/app_button.dart';
import 'app_icon.dart';
import 'form/app_input_decoration.dart';

class AppSearchBar extends StatefulWidget {
  const AppSearchBar({
    super.key,
    this.controller,
    this.initValue,
    this.timeDelay = const Duration(milliseconds: 500),
    this.onChanged,
    this.readOnly = false,
    this.hintText,
    this.onTap,
    this.keyboardType,
    this.inputFormatters,
  });

  final String? initValue;

  final Duration timeDelay;

  final TextEditingController? controller;

  final void Function(String value)? onChanged;

  final bool readOnly;

  final String? hintText;

  final void Function()? onTap;

  final TextInputType? keyboardType;

  final List<TextInputFormatter>? inputFormatters;

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  late final TextEditingController _controller;

  String? _value;

  late bool _canClear;

  late final Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _debouncer = Debouncer(milliseconds: widget.timeDelay.inMilliseconds);

    _controller =
        widget.controller ?? TextEditingController(text: widget.initValue);
    if (widget.initValue != null) {
      _controller.text = widget.initValue!;
    }
    _canClear = _controller.text.isNotEmpty;
    _controller.addListener(_onTextChange);
  }

  @override
  void didUpdateWidget(covariant AppSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initValue != widget.initValue &&
        widget.initValue.validate() != _value.validate()) {
      _controller.text = widget.initValue.validate();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChange);
    _debouncer.dispose();
    super.dispose();
  }

  void _onTextChange() {
    final String newValue = _controller.text.trim();

    if (_value.validate() == newValue.validate()) return;
    _value = newValue;

    final bool canClear = _value?.isNotEmpty ?? false;
    if (_canClear != canClear) {
      setState(() {
        _canClear = canClear;
      });
    }

    // Trigger the debounced callback to notify listeners about search term updates.
    _debouncer.run(() {
      widget.onChanged?.call(newValue);
    });
  }

  /// Clear the current search value and notify listeners.
  void _clear() {
    _debouncer.dispose();

    _controller.text = '';
    _canClear = false;

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      maxLines: 1,
      minLines: 1,
      autocorrect: false,
      decoration: AppInputDecoration.basic(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s4,
          vertical: AppSpacing.s2,
        ),
        hintText:
            widget.hintText ??
            context.text(
              LocaleKeys.core.search_bar.hint,
              defaultValue: 'Tìm kiếm',
            ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(AppRadius.full),
          borderSide: BorderSide(color: AppColors.gray100, width: 1),
        ),
        filled: true,
        fillColor: AppColors.gray50,
        prefixIcon: const AppIcon(
          icon: PhosphorIconsRegular.magnifyingGlass,
          size: 16,
          color: AppColors.gray800,
        ),
        suffixIcon: _canClear
            ? AppButton.icon(
                style: AppIconButtonStyle.subtlest,
                onPressed: _clear,
                size: AppButtonSize.small,
                icon: const AppIcon(icon: PhosphorIconsRegular.x, size: null),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
