import 'package:flutter/widgets.dart';

enum ScreenSize {
  Desktop,
  Laptop,
  TabletPortrait,
  TabletLandscape,
  MobilePortrait,
  MobileLandscape,
}

typedef Widget ResponsiveBuilder(BuildContext context);

typedef Widget ScreenSizeBuilder(BuildContext context, ScreenSize size);

class ScreenSizeWidget extends StatelessWidget {
  final ScreenSizeBuilder builder;

  ScreenSizeWidget({
    @required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    ScreenSize size;
    double maxWidth = MediaQuery.of(context).size.width;
    Orientation orientation = MediaQuery.of(context).orientation;
    bool portrait = orientation == Orientation.portrait;
    bool landscape = orientation == Orientation.landscape;
    if (maxWidth >= 1281) {
      size = ScreenSize.Desktop;
    } else if (maxWidth >= 1025) {
      size = ScreenSize.Laptop;
    } else if (maxWidth >= 768 && portrait) {
      size = ScreenSize.TabletPortrait;
    } else if (maxWidth >= 768 && landscape) {
      size = ScreenSize.TabletLandscape;
    } else if (maxWidth >= 481 && landscape) {
      size = ScreenSize.MobileLandscape;
    } else {
      size = ScreenSize.MobilePortrait;
    }
    return builder(context, size);
  }
}

class ResponsiveWidget extends StatelessWidget {
  final ResponsiveBuilder desktop;
  final ResponsiveBuilder laptop;

  final ResponsiveBuilder tablet;
  final ResponsiveBuilder tabletPortrait;
  final ResponsiveBuilder tabletLandscape;

  final ResponsiveBuilder mobile;
  final ResponsiveBuilder mobilePortrait;
  final ResponsiveBuilder mobileLandscape;

  ResponsiveWidget({
    @required this.desktop,
    this.laptop,
    this.tablet,
    this.tabletPortrait,
    this.tabletLandscape,
    this.mobile,
    this.mobilePortrait,
    this.mobileLandscape,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenSizeWidget(
      builder: (BuildContext context, ScreenSize size) {
        switch (size) {
          case ScreenSize.Laptop:
            if (laptop != null) {
              return laptop(context);
            }
            return desktop(context);
            break;
          case ScreenSize.TabletPortrait:
            if (tabletPortrait != null) {
              return tabletPortrait(context);
            }
            if (tablet != null) {
              return tablet(context);
            }
            break;
          case ScreenSize.TabletLandscape:
            if (tabletLandscape != null) {
              return tabletLandscape(context);
            }
            if (tablet != null) {
              return tablet(context);
            }
            break;
          case ScreenSize.MobilePortrait:
            if (mobilePortrait != null) {
              return mobilePortrait(context);
            }
            if (mobile != null) {
              return mobile(context);
            }
            break;
          case ScreenSize.MobileLandscape:
            if (mobileLandscape != null) {
              return mobileLandscape(context);
            }
            if (mobile != null) {
              return mobile(context);
            }
            break;
          default:
            return desktop(context);
            break;
        }
        return desktop(context);
      },
    );
  }
}

class BigPostGridView extends StatelessWidget {
  final Key key;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController controller;
  final bool primary;
  final ScrollPhysics physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry padding;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double cacheExtent;
  final int semanticChildCount;

  BigPostGridView({
    this.key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    @required this.itemBuilder,
    this.itemCount,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.semanticChildCount,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenSizeWidget(
      builder: (context, size) {
        double a = 1;
        if (size == ScreenSize.Desktop || size == ScreenSize.Laptop) {
          a = 3.0;
        } else if (size == ScreenSize.TabletLandscape ||
            size == ScreenSize.TabletPortrait) {
          a = 4.0;
        } else {
          a = 5.0;
        }
        return GridView.builder(
          key: key,
          scrollDirection: scrollDirection,
          reverse: reverse,
          controller: controller,
          primary: primary,
          physics: physics,
          shrinkWrap: shrinkWrap,
          padding: padding,
          itemBuilder: itemBuilder,
          itemCount: itemCount,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          cacheExtent: cacheExtent,
          semanticChildCount: semanticChildCount,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (MediaQuery.of(context).size.width / 300).floor(),
            childAspectRatio: a,
          ),
        );
      },
    );
  }
}

class ScreenSizeProvider extends StatefulWidget {
  final Widget child;

  ScreenSizeProvider({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScreenSizeProviderState();

  static ScreenSize of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(_RepoProvider) as _RepoProvider)
          .size;

  static bool isMobile(BuildContext context) {
    return isMobilePortrait(context) || isMobileLandscape(context);
  }

  static bool isMobilePortrait(BuildContext context) {
    return of(context) == ScreenSize.MobilePortrait;
  }

  static bool isMobileLandscape(BuildContext context) {
    return of(context) == ScreenSize.MobileLandscape;
  }

  static bool isTablet(BuildContext context) {
    return isTabletLandscape(context) || isTabletPortrait(context);
  }

  static bool isTabletLandscape(BuildContext context) {
    return of(context) == ScreenSize.TabletLandscape;
  }

  static bool isTabletPortrait(BuildContext context) {
    return of(context) == ScreenSize.TabletPortrait;
  }

  static bool isLaptop(BuildContext context) {
    return of(context) == ScreenSize.Laptop;
  }

  static bool isDesktop(BuildContext context) {
    return of(context) == ScreenSize.Desktop;
  }
}

class _ScreenSizeProviderState extends State<ScreenSizeProvider> {
  ScreenSize size;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    double maxWidth = MediaQuery.of(context).size.width;
    Orientation orientation = MediaQuery.of(context).orientation;
    bool portrait = orientation == Orientation.portrait;
    bool landscape = orientation == Orientation.landscape;
    if (maxWidth >= 1281) {
      size = ScreenSize.Desktop;
    } else if (maxWidth >= 1025) {
      size = ScreenSize.Laptop;
    } else if (maxWidth >= 768 && portrait) {
      size = ScreenSize.TabletPortrait;
    } else if (maxWidth >= 768 && landscape) {
      size = ScreenSize.TabletLandscape;
    } else if (maxWidth >= 481 && landscape) {
      size = ScreenSize.MobileLandscape;
    } else {
      size = ScreenSize.MobilePortrait;
    }
    //print('_ScreenSizeProviderState.didChangeDependencies ${size}');
  }

  @override
  Widget build(BuildContext context) {
    return _RepoProvider(
      size: size,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class _RepoProvider extends InheritedWidget {
  final ScreenSize size;

  _RepoProvider({Key key, @required Widget child, @required this.size})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(_RepoProvider oldWidget) =>
      size != oldWidget.size; //true;
}
