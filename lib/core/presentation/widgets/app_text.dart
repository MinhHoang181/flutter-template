import 'dart:ui' as ui show TextHeightBehavior;

import 'package:flutter/material.dart';

/// Text widget
class AppText extends StatelessWidget {
  /// Create text widget
  const AppText(
    this.text, {
    super.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    TextOverflow? overflow = TextOverflow.ellipsis,
    this.textScaler,
    int? maxLines = 1,
    this.textWidthBasis,
    this.locale,
    this.softWrap,
    this.semanticsLabel,
    this.textHeightBehavior,
    this.selectionColor,
  }) : textSpan = null,
       maxLines = (maxLines == null || maxLines > 0) ? maxLines : 1,
       overflow = (maxLines == null) ? TextOverflow.visible : overflow;

  /// Create text widget with [TextSpan]
  const AppText.rich(
    this.textSpan, {
    super.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    TextOverflow? overflow = TextOverflow.ellipsis,
    this.textScaler,
    int? maxLines = 1,
    this.textWidthBasis,
    this.locale,
    this.softWrap,
    this.semanticsLabel,
    this.textHeightBehavior,
    this.selectionColor,
  }) : text = null,
       maxLines = (maxLines == null || maxLines > 0) ? maxLines : 1,
       overflow = (maxLines == null) ? TextOverflow.visible : overflow;

  /// The text to display.
  ///
  /// This will be null if a [textSpan] is provided instead.
  final String? text;

  /// The text to display as a [InlineSpan].
  ///
  /// This will be null if [data] is provided instead.
  final InlineSpan? textSpan;

  /// If non-null, the style to use for this text.
  ///
  /// If the style's "inherit" property is true, the style will be merged with
  /// the closest enclosing [DefaultTextStyle]. Otherwise, the style will
  /// replace the closest enclosing [DefaultTextStyle].
  final TextStyle? style;

  /// {@macro flutter.painting.textPainter.strutStyle}
  final StrutStyle? strutStyle;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The directionality of the text.
  ///
  /// This decides how [textAlign] values like [TextAlign.start] and
  /// [TextAlign.end] are interpreted.
  ///
  /// This is also used to disambiguate how to render bidirectional text. For
  /// example, if the [data] is an English phrase followed by a Hebrew phrase,
  /// in a [TextDirection.ltr] context the English phrase will be on the left
  /// and the Hebrew phrase to its right, while in a [TextDirection.rtl]
  /// context, the English phrase will be on the right and the Hebrew phrase on
  /// its left.
  ///
  /// Defaults to the ambient [Directionality], if any.
  final TextDirection? textDirection;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale.
  ///
  /// It's rarely necessary to set this property. By default its value
  /// is inherited from the enclosing app with `Localizations.localeOf(context)`.
  ///
  /// See [RenderParagraph.locale] for more information.
  final Locale? locale;

  /// Whether the text should break at soft line breaks.
  ///
  /// If false, the glyphs in the text will be positioned as if there was unlimited horizontal space.
  final bool? softWrap;

  /// How visual overflow should be handled.
  ///
  /// If this is null [TextStyle.overflow] will be used, otherwise the value
  /// from the nearest [DefaultTextStyle] ancestor will be used.
  final TextOverflow? overflow;

  /// {@macro flutter.painting.textPainter.textScaler}
  final TextScaler? textScaler;

  /// An optional maximum number of lines for the text to span, wrapping if necessary.
  /// If the text exceeds the given number of lines, it will be truncated according
  /// to [overflow].
  ///
  /// If this is 1, text will not wrap. Otherwise, text will be wrapped at the
  /// edge of the box.
  ///
  /// If this is null, but there is an ambient [DefaultTextStyle] that specifies
  /// an explicit number for its [DefaultTextStyle.maxLines], then the
  /// [DefaultTextStyle] value will take precedence. You can use a [RichText]
  /// widget directly to entirely override the [DefaultTextStyle].
  final int? maxLines;

  /// An alternative semantics label for this text.
  ///
  /// If present, the semantics of this widget will contain this value instead
  /// of the actual text. This will overwrite any of the semantics labels applied
  /// directly to the [TextSpan]s.
  ///
  /// This is useful for replacing abbreviations or shorthands with the full
  /// text value:
  ///
  /// ```dart
  /// const Text(r'$$', semanticsLabel: 'Double dollars')
  /// ```
  final String? semanticsLabel;

  /// {@macro flutter.painting.textPainter.textWidthBasis}
  final TextWidthBasis? textWidthBasis;

  /// {@macro dart.ui.textHeightBehavior}
  final ui.TextHeightBehavior? textHeightBehavior;

  /// The color to use when painting the selection.
  ///
  /// This is ignored if [SelectionContainer.maybeOf] returns null
  /// in the [BuildContext] of the [Text] widget.
  ///
  /// If null, the ambient [DefaultSelectionStyle] is used (if any); failing
  /// that, the selection color defaults to [DefaultSelectionStyle.defaultColor]
  /// (semi-transparent grey).
  final Color? selectionColor;

  @override
  Widget build(BuildContext context) {
    if (textSpan != null) {
      return richTextBuilder(context);
    }

    return textBuilder(context);
  }

  /// Builds the [Text.rich] widget
  @protected
  Widget richTextBuilder(BuildContext context) {
    return Text.rich(
      textSpan!,
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      softWrap: softWrap ?? maxLines == null,
      overflow: overflow,
      textScaler: textScaler,
      maxLines: maxLines,
      textWidthBasis: textWidthBasis,
      selectionColor: selectionColor,
      locale: locale,
    );
  }

  /// Builds the [Text] widget
  @protected
  Widget textBuilder(BuildContext context) {
    return Text(
      text ?? '',
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      softWrap: softWrap ?? maxLines == null,
      overflow: overflow,
      textScaler: textScaler,
      maxLines: maxLines,
      textWidthBasis: textWidthBasis,
      selectionColor: selectionColor,
      locale: locale,
    );
  }
}
