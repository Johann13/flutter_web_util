import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SimpleWebRoute extends PageRoute {
  final String title;
  final WidgetBuilder builder;

  SimpleWebRoute({
    @required RouteSettings settings,
    @required this.title,
    @required this.builder,
  }) : super(settings: settings);

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 200);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Title(
      title: this.title,
      color: Theme.of(context).primaryColor,
      child: builder(context),
    );
  }
}