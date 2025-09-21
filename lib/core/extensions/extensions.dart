import 'dart:convert' show jsonDecode;
import 'dart:math';
import 'dart:ui' as ui show TextDirection;

import 'package:collection/collection.dart' show CanonicalizedMap;
import 'package:diacritic/diacritic.dart' as diacritic;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Color,
        Colors,
        Locale,
        Size,
        StrutStyle,
        TextAlign,
        TextPainter,
        TextScaler,
        TextStyle,
        TextSpan,
        Widget,
        SizedBox,
        MultiChildRenderObjectWidget,
        SingleChildRenderObjectWidget,
        SliverPadding,
        Padding,
        Visibility,
        LimitedBox,
        BoxConstraints,
        EdgeInsetsGeometry,
        Container,
        Text;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider, StateStreamableSource;
import 'package:intl/intl.dart' show DateFormat, NumberFormat;
import 'package:template/core/utils/methods.dart';

part 'src/bloc_extension.dart';
part 'src/boolean_extensions.dart';
part 'src/color_extensions.dart';
part 'src/context.dart';
part 'src/datetime_extensions.dart';
part 'src/iterable_extensions.dart';
part 'src/map_extensions.dart';
part 'src/num_extensions.dart';
part 'src/object_extensions.dart';
part 'src/string_extensions.dart';
part 'src/widget_extensions.dart';
