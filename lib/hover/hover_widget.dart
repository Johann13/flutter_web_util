import 'dart:html' as html;

import 'package:flutter/material.dart';

typedef HoverBuilder<T> = Widget Function(BuildContext context, T value);

/// The body tag need the id of 'app-container'!
class MousePointer extends StatefulWidget {
  final Widget child;
  final String hoverPointer;

  const MousePointer({Key key, @required this.child, this.hoverPointer})
      : super(key: key);

  @override
  _MousePointerState createState() => _MousePointerState();
}

class _MousePointerState extends State<MousePointer> {
  static final _appContainer =
      html.window.document.getElementById('app-container');

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onExit: (e) {
        _appContainer.style.cursor = 'default';
      },
      onEnter: (e) {
        _appContainer.style.cursor = widget.hoverPointer ?? 'pointer';
      },
      child: widget.child,
    );
  }
}

class HoverWidget<T> extends StatefulWidget {
  final T value;
  final T hoverValue;
  final HoverBuilder<T> builder;
  final String hoverPointer;

  const HoverWidget({
    Key key,
    @required this.value,
    @required this.hoverValue,
    @required this.builder,
    this.hoverPointer = 'pointer',
  }) : super(key: key);

  @override
  _HoverWidgetState<T> createState() => _HoverWidgetState<T>();
}

class _HoverWidgetState<T> extends State<HoverWidget<T>> {
  bool _hover = false;
  static final _appContainer =
      html.window.document.getElementById('app-container');

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onExit: (e) {
        setState(() {
          _hover = false;
        });
        _appContainer.style.cursor = 'default';
      },
      onEnter: (e) {
        setState(() {
          _hover = true;
        });
        _appContainer.style.cursor = widget.hoverPointer ?? 'pointer';
      },
      child: widget.builder(context, _value),
    );
  }

  T get _value {
    if (_hover) {
      return widget.hoverValue;
    }
    return widget.value;
  }
}

class HoverIntWidget extends HoverWidget<int> {
  const HoverIntWidget({
    Key key,
    @required int value,
    @required int hoverValue,
    @required HoverBuilder<int> builder,
  }) : super(
          key: key,
          value: value,
          hoverValue: hoverValue,
          builder: builder,
        );
}

class HoverDoubleWidget extends HoverWidget<double> {
  const HoverDoubleWidget({
    Key key,
    @required double value,
    @required double hoverValue,
    @required HoverBuilder<double> builder,
  }) : super(
          key: key,
          value: value,
          hoverValue: hoverValue,
          builder: builder,
        );
}

class HoverBoolWidget extends HoverWidget<bool> {
  const HoverBoolWidget(
      {Key key, @required HoverBuilder<bool> builder, String hoverPointer})
      : super(
          key: key,
          value: false,
          hoverValue: true,
          builder: builder,
          hoverPointer: hoverPointer,
        );
}

class HoverColorWidget extends HoverWidget<Color> {
  const HoverColorWidget({
    Key key,
    @required Color value,
    @required Color hoverValue,
    @required HoverBuilder<Color> builder,
  }) : super(
          key: key,
          value: value,
          hoverValue: hoverValue,
          builder: builder,
        );
}

class HoverTextStyleWidget extends HoverWidget<TextStyle> {
  const HoverTextStyleWidget({
    Key key,
    @required TextStyle value,
    @required TextStyle hoverValue,
    @required HoverBuilder<TextStyle> builder,
  }) : super(
          key: key,
          value: value,
          hoverValue: hoverValue,
          builder: builder,
        );
}

class HoverPaddingWidget extends HoverWidget<EdgeInsets> {
  const HoverPaddingWidget({
    Key key,
    @required EdgeInsets value,
    @required EdgeInsets hoverValue,
    @required HoverBuilder<EdgeInsets> builder,
  }) : super(
          key: key,
          value: value,
          hoverValue: hoverValue,
          builder: builder,
        );
}

class HoverText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Color hoverColor;
  final TextStyle hover;
  final GestureTapCallback onTap;
  final String hoverPointer;

  const HoverText({
    Key key,
    @required this.text,
    @required this.style,
    this.hoverColor,
    this.hover,
    this.onTap,
    this.hoverPointer = 'pointer',
  }) : super(key: key);

  @override
  __HoverTextState createState() => __HoverTextState();
}

class __HoverTextState extends State<HoverText> {
  bool hover = false;
  static final _appContainer =
      html.window.document.getElementById('app-container');

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) {
        setState(() {
          hover = true;
        });
        _appContainer.style.cursor = widget.hoverPointer;
      },
      onExit: (e) {
        setState(() {
          hover = false;
        });
        _appContainer.style.cursor = 'default';
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.text,
          style: style.copyWith(
            fontWeight: FontWeight.w700,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  TextStyle get style {
    if (hover) {
      if (widget.hover != null) {
        return widget.hover;
      } else if (widget.hoverColor != null) {
        return widget.style.copyWith(
          color: widget.hoverColor,
        );
      }
    }
    return widget.style;
  }
}
