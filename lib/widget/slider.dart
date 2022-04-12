import 'package:flutter/material.dart';
import 'dart:async';

class Position {
  final double top;
  final double bottom;
  final double left;
  final double right;

  const Position({this.top = 8.0, this.bottom = 8.0, this.left = 8.0, this.right = 8.0});
}

class Sliders extends StatefulWidget {
  final SlidersController? carouselController;
  final List<Widget>? children;

  final double height;
  final EdgeInsetsGeometry margin;

  ///Returns [children]`s [lenght].
  int get childrenCount => children!.length;

  ///The transition animation timing curve. Default is [Curves.ease]
  final Curve animationCurve;

  ///The transition animation duration. Default is 250ms.
  final Duration animationDuration;

  ///The amount of time each frame is displayed. Default is 2s.
  final Duration displayDuration;

  final bool autoPlay;
  final bool repeat;

  final Alignment dotAlignment;
  final Position dotPosition;
  final Widget placeholder;

  Sliders({
    Key? key,
    this.height = 210.0,
    this.carouselController,
    EdgeInsetsGeometry? margins,
    this.children,
    this.animationCurve = Curves.bounceOut,
    this.animationDuration = const Duration(milliseconds: 2000),
    this.displayDuration = const Duration(seconds: 7),
    this.autoPlay = true,
    this.repeat = true,
    this.dotAlignment = Alignment.bottomCenter,
    this.dotPosition = const Position(),
    Widget? placeholder,
  })  : assert(children == null || carouselController == null),
        margin = margins ?? const EdgeInsets.all(0.0),
        placeholder = placeholder ?? Container(),
        super(key: key);

  @override
  State createState() => _SlidersState();
}

class _SlidersState extends State<Sliders> with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();

  Timer? _timer;

  double dotSize = 4.0;
  double dotIncreaseSize = 1.4;

  double get dotSpacing => dotSize * (dotIncreaseSize + 1);
  SlidersController? _controller;

  ///Actual index of the displaying Widget
  int get actualIndex => !_pageController.hasClients ? 0 : _pageController.page!.round();

  ///Returns the calculated value of the next index.
  int get nextIndex {
    var nextIndexValue = actualIndex;

    if (nextIndexValue < _controller!.widgets.length - 1) {
      nextIndexValue++;
    } else {
      nextIndexValue = 0;
    }
    return nextIndexValue;
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.carouselController ?? SlidersController(widgets: widget.children!);
    _controller!.addListener(_updateFromWidget);
  }

  _updateFromWidget() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _timer?.cancel();
  }

  Widget createCarouselPlaceHolder() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(width: constraints.maxWidth, height: widget.height, child: widget.placeholder);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_controller!.widgets.isEmpty) return createCarouselPlaceHolder();

    if (widget.autoPlay) startAnimating();

    _pageController.addListener(() => setState(() {}));

    return Container(
        height: widget.height,
        margin: widget.margin,
        child: Stack(children: [
          PageView(
            controller: _pageController,
            physics: const AlwaysScrollableScrollPhysics(),
            children: _controller!.widgets
                .map((widget) => SizedBox(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: widget,
                      ),
                    ))
                .toList(),
          ),
          Positioned(
              top: widget.dotPosition.top,
              bottom: widget.dotPosition.bottom,
              left: widget.dotPosition.left,
              right: widget.dotPosition.right,
              child: Container(
                alignment: widget.dotAlignment,
                child: Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: List<Widget>.generate(_controller!.widgets.length, _buildDot)),
              )),
        ]));
  }

  Widget _buildDot(int index) {
    double currentPage = !_pageController.hasClients ? 0.0 : _pageController.page ?? 0.0;
    double zoom = (currentPage).floor() == index
        ? ((1.0 - (currentPage - index)) * (dotIncreaseSize - 1)) + 1
        : (currentPage + 1).floor() == index
            ? ((currentPage + 1.0 - index) * (dotIncreaseSize - 1)) + 1
            : 1.0;

    return SizedBox(
      width: dotSpacing,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Material(
            color: Colors.grey,
            type: MaterialType.circle,
            child: SizedBox(
              width: dotSize * (zoom + 0.2),
              height: dotSize * (zoom + 0.2),
            ),
          ),
          Material(
            color: Theme.of(context).cardColor,
            type: MaterialType.circle,
            child: SizedBox(
              width: dotSize * zoom,
              height: dotSize * zoom,
              child: InkWell(
                onTap: () => onPageSelected(index),
              ),
            ),
          )
        ],
      ),
    );
  }

  void startAnimating() {
    _timer?.cancel();

    //Every widget.displayDuration (time) the tabbar controller will animate to the next index.
    _timer = Timer.periodic(
      widget.displayDuration,
      (_) {
        if (!widget.repeat) {
          if (nextIndex == 0) _timer!.cancel();

          if (!_timer!.isActive) return;
        }

        _pageController.animateToPage(nextIndex, curve: widget.animationCurve, duration: widget.animationDuration);
      },
    );
  }

  onPageSelected(int index) {
    _pageController.animateToPage(index, duration: widget.animationDuration, curve: widget.animationCurve);
  }
}

class SlidersController extends ValueNotifier<SlidersEditingValue> {
  List<Widget> get widgets => value.widgets ?? [const SizedBox()];

  set widgets(List<Widget> widgets) {
    value = value.copyWith(widgets: widgets);
  }

  SlidersController({List<Widget>? widgets}) : super(widgets == null ? SlidersEditingValue.empty : SlidersEditingValue(widgets: widgets));

  SlidersController.fromValue(SlidersEditingValue value) : super(value);

  void clear() {
    value = SlidersEditingValue.empty;
  }
}

class SlidersEditingValue {
  const SlidersEditingValue({this.widgets});

  final List<Widget>? widgets;

  static const SlidersEditingValue empty = SlidersEditingValue();

  SlidersEditingValue copyWith({List<Widget>? widgets}) {
    return SlidersEditingValue(widgets: widgets ?? this.widgets);
  }

  SlidersEditingValue.fromValue(SlidersEditingValue copy) : widgets = copy.widgets;

  @override
  String toString() => '$runtimeType(widgets: \u2524$widgets\u251C)';

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (other is! SlidersEditingValue) return false;
    final SlidersEditingValue typedOther = other;
    return typedOther.widgets == widgets;
  }

  @override
  int get hashCode => hashValues(widgets.hashCode, widgets.hashCode);
}
