library marquee_pro;

import 'dart:async';

import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

typedef MarqueeRoundCallback = void Function(int round);

enum MarqueeDirection {
  rightToLeft,
  leftToRight,
  bottomToTop,
  topToBottom,
}

extension on MarqueeDirection {
  Axis get axis {
    switch (this) {
      case MarqueeDirection.rightToLeft:
      case MarqueeDirection.leftToRight:
        return Axis.horizontal;
      case MarqueeDirection.bottomToTop:
      case MarqueeDirection.topToBottom:
        return Axis.vertical;
    }
  }

  double get sign {
    switch (this) {
      case MarqueeDirection.rightToLeft:
      case MarqueeDirection.bottomToTop:
        return 1.0;
      case MarqueeDirection.leftToRight:
      case MarqueeDirection.topToBottom:
        return -1.0;
    }
  }
}

abstract class _MarqueeControllerActions {
  void pause();

  void resume();

  void restart();
}

class MarqueeController {
  _MarqueeControllerActions? _actions;
  bool _startPaused = false;

  bool get startPaused => _startPaused;

  bool get isAttached => _actions != null;

  void _attach(_MarqueeControllerActions actions) {
    _actions = actions;
  }

  void _detach(_MarqueeControllerActions actions) {
    if (identical(_actions, actions)) {
      _actions = null;
    }
  }

  void pause() {
    _startPaused = true;
    _actions?.pause();
  }

  void resume() {
    _startPaused = false;
    _actions?.resume();
  }

  void restart() {
    _startPaused = false;
    _actions?.restart();
  }
}

class _IntegralCurve extends Curve {
  static double delta = 0.01;

  _IntegralCurve._(this.original, this.integral, this._values);

  final Curve original;
  final double integral;
  final Map<double, double> _values;

  factory _IntegralCurve(Curve original) {
    double integral = 0.0;
    final values = <double, double>{};

    for (double t = 0.0; t <= 1.0; t += delta) {
      integral += original.transform(t) * delta;
      values[t] = integral;
    }
    values[1.0] = integral;

    for (final double t in values.keys) {
      values[t] = values[t]! / integral;
    }

    return _IntegralCurve._(original, integral, values);
  }

  @override
  double transform(double t) {
    if (t < 0) return 0.0;
    for (final key in _values.keys) {
      if (key > t) return _values[key]!;
    }
    return 1.0;
  }
}

class Marquee extends StatefulWidget {
  Marquee({
    super.key,
    this.text,
    this.richText,
    this.child,
    this.controller,
    this.style,
    this.textScaleFactor,
    this.textDirection = TextDirection.ltr,
    this.direction,
    this.scrollAxis = Axis.horizontal,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.blankSpace = 0.0,
    this.speed,
    this.velocity = 50.0,
    this.startAfter = Duration.zero,
    this.pauseAfterRound = Duration.zero,
    this.showFadingOnlyWhenScrolling = true,
    this.fadingEdgeStartFraction = 0.0,
    this.fadingEdgeEndFraction = 0.0,
    this.numberOfRounds,
    this.onlyIfOverflow = false,
    this.pauseOnHover = false,
    this.pauseOnTap = false,
    this.startPaused = false,
    this.startPadding = 0.0,
    this.accelerationDuration = Duration.zero,
    Curve accelerationCurve = Curves.decelerate,
    this.decelerationDuration = Duration.zero,
    Curve decelerationCurve = Curves.decelerate,
    this.colorCycle,
    this.colorCycleDuration = const Duration(seconds: 4),
    this.enableColorTransition = true,
    this.onRoundCompleted,
    this.onDone,
  })  : assert(
          ((text != null && text.isNotEmpty) ? 1 : 0) +
                  (richText != null ? 1 : 0) +
                  (child != null ? 1 : 0) ==
              1,
          'Provide exactly one of text, richText, or child.',
        ),
        assert(!blankSpace.isNaN),
        assert(blankSpace >= 0, 'The blankSpace needs to be positive or zero.'),
        assert(blankSpace.isFinite),
        assert(!(speed != null && speed <= 0.0), 'The speed must be positive.'),
        assert(!velocity.isNaN),
        assert(velocity != 0.0, 'The velocity cannot be zero.'),
        assert(velocity.isFinite),
        assert(
          pauseAfterRound >= Duration.zero,
          "The pauseAfterRound cannot be negative as time travel isn't invented yet.",
        ),
        assert(
          fadingEdgeStartFraction >= 0 && fadingEdgeStartFraction <= 1,
          'The fadingEdgeStartFraction value should be between 0 and 1.',
        ),
        assert(
          fadingEdgeEndFraction >= 0 && fadingEdgeEndFraction <= 1,
          'The fadingEdgeEndFraction value should be between 0 and 1.',
        ),
        assert(numberOfRounds == null || numberOfRounds > 0),
        assert(
          accelerationDuration >= Duration.zero,
          "The accelerationDuration cannot be negative as time travel isn't invented yet.",
        ),
        assert(
          decelerationDuration >= Duration.zero,
          "The decelerationDuration must be positive or zero as time travel isn't invented yet.",
        ),
        assert(
          colorCycle == null || colorCycle.length != 1,
          'Use at least two colors for colorCycle, or leave it null.',
        ),
        accelerationCurve = _IntegralCurve(accelerationCurve),
        decelerationCurve = _IntegralCurve(decelerationCurve);

  final String? text;
  final InlineSpan? richText;
  final Widget? child;
  final MarqueeController? controller;
  final TextStyle? style;
  final double? textScaleFactor;
  final TextDirection textDirection;
  final MarqueeDirection? direction;
  final Axis scrollAxis;
  final CrossAxisAlignment crossAxisAlignment;
  final double blankSpace;
  final double? speed;
  final double velocity;
  final Duration startAfter;
  final Duration pauseAfterRound;
  final int? numberOfRounds;
  final bool onlyIfOverflow;
  final bool pauseOnHover;
  final bool pauseOnTap;
  final bool startPaused;
  final bool showFadingOnlyWhenScrolling;
  final double fadingEdgeStartFraction;
  final double fadingEdgeEndFraction;
  final double startPadding;
  final Duration accelerationDuration;
  final _IntegralCurve accelerationCurve;
  final Duration decelerationDuration;
  final _IntegralCurve decelerationCurve;
  final List<Color>? colorCycle;
  final Duration colorCycleDuration;
  final bool enableColorTransition;
  final MarqueeRoundCallback? onRoundCompleted;
  final VoidCallback? onDone;

  Axis get effectiveAxis => direction?.axis ?? scrollAxis;

  double get effectiveVelocity {
    final baseSpeed = speed ?? velocity.abs();
    if (direction != null) {
      return baseSpeed * direction!.sign;
    }
    return velocity;
  }

  @override
  State<Marquee> createState() => _MarqueeState();
}

class _MarqueeState extends State<Marquee>
    with TickerProviderStateMixin
    implements _MarqueeControllerActions {
  final ScrollController _scrollController = ScrollController();
  // A hidden measuring copy is used for custom child marquees so scroll
  // distances can be calculated before the visible animation starts.
  final GlobalKey _measureKey = GlobalKey();
  late final AnimationController _movementController =
      AnimationController(vsync: this);
  late final AnimationController _colorController =
      AnimationController(vsync: this);

  late double _startPosition;
  late double _accelerationTarget;
  late double _linearTarget;
  late double _decelerationTarget;
  late Duration _totalDuration;
  Duration? _linearDuration;

  bool _running = false;
  bool _isOnPause = false;
  bool _isPaused = false;
  bool _manualPauseRequested = false;
  bool _hoverPauseActive = false;
  bool _tapPauseActive = false;
  int _roundCounter = 0;
  int _sessionId = 0;
  double? _childExtent;
  Completer<void>? _resumeCompleter;
  Completer<void>? _activeAnimationCompleter;
  VoidCallback? _animationTickListener;
  AnimationStatusListener? _animationStatusListener;

  bool get _hasColorCycle =>
      (widget.colorCycle?.length ?? 0) >= 2 &&
      widget.colorCycleDuration > Duration.zero;

  bool get _isDone => widget.numberOfRounds == null
      ? false
      : widget.numberOfRounds == _roundCounter;

  bool get _showFading =>
      !widget.showFadingOnlyWhenScrolling ? true : !(_isOnPause || _isPaused);

  @override
  void initState() {
    super.initState();
    widget.controller?._attach(this);
    _manualPauseRequested =
        widget.startPaused || (widget.controller?.startPaused ?? false);
    _isPaused = _manualPauseRequested;
    if (_isPaused) {
      _resumeCompleter = Completer<void>();
    }
    _syncColorAnimation();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _captureChildExtent();
      if (!_running) {
        _restartLoop();
      }
    });
  }

  @override
  void didUpdateWidget(covariant Marquee oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?._detach(this);
      widget.controller?._attach(this);
    }

    _syncColorAnimation();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _captureChildExtent();
    });

    final shouldPause =
        widget.startPaused || (widget.controller?.startPaused ?? false);
    if (shouldPause != _manualPauseRequested) {
      _setManualPaused(shouldPause);
    }

    if (oldWidget.text != widget.text ||
        oldWidget.richText != widget.richText ||
        oldWidget.style != widget.style ||
        oldWidget.textScaleFactor != widget.textScaleFactor ||
        oldWidget.textDirection != widget.textDirection ||
        oldWidget.direction != widget.direction ||
        oldWidget.scrollAxis != widget.scrollAxis ||
        oldWidget.blankSpace != widget.blankSpace ||
        oldWidget.speed != widget.speed ||
        oldWidget.velocity != widget.velocity ||
        oldWidget.startPadding != widget.startPadding ||
        oldWidget.onlyIfOverflow != widget.onlyIfOverflow ||
        oldWidget.crossAxisAlignment != widget.crossAxisAlignment ||
        oldWidget.startAfter != widget.startAfter ||
        oldWidget.numberOfRounds != widget.numberOfRounds ||
        oldWidget.accelerationDuration != widget.accelerationDuration ||
        oldWidget.decelerationDuration != widget.decelerationDuration ||
        oldWidget.child != widget.child) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _restartLoop();
        }
      });
    }
  }

  @override
  void dispose() {
    _running = false;
    widget.controller?._detach(this);
    _cancelActiveAnimation();
    _movementController.dispose();
    _colorController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _syncColorAnimation() {
    if (!_hasColorCycle) {
      _colorController.stop();
      return;
    }

    _colorController.duration = widget.colorCycleDuration;
    if (!_isPaused && !_colorController.isAnimating) {
      _colorController.repeat();
    }
  }

  Future<void> _scroll(int sessionId) async {
    await _waitUntilResumed(sessionId);
    if (!_isSessionActive(sessionId)) return;

    await _delayWithPause(widget.startAfter, sessionId);

    while (_isSessionActive(sessionId) &&
        _scrollController.hasClients &&
        !_isDone) {
      await _makeRoundTrip(sessionId);
      if (!_isSessionActive(sessionId)) return;

      _roundCounter++;
      widget.onRoundCompleted?.call(_roundCounter);

      if (_isDone) {
        widget.onDone?.call();
        return;
      }

      if (widget.pauseAfterRound > Duration.zero) {
        if (mounted) {
          setState(() => _isOnPause = true);
        } else {
          _isOnPause = true;
        }

        await _delayWithPause(widget.pauseAfterRound, sessionId);
        if (!_isSessionActive(sessionId)) return;

        if (mounted) {
          setState(() => _isOnPause = false);
        } else {
          _isOnPause = false;
        }
      }
    }
  }

  void _initialize() {
    // Scroll distances are derived from the measured content extent so the
    // same animation pipeline works for text, rich spans, and custom widgets.
    final contentExtent = _measureSpanExtent();
    if (contentExtent <= 0) {
      _startPosition = 0.0;
      _accelerationTarget = 0.0;
      _linearTarget = 0.0;
      _decelerationTarget = 0.0;
      _totalDuration = Duration.zero;
      _linearDuration = Duration.zero;
      return;
    }

    final totalLength = contentExtent + widget.blankSpace;
    final velocity = widget.effectiveVelocity;
    final accelerationLength = widget.accelerationCurve.integral *
        velocity *
        widget.accelerationDuration.inMilliseconds /
        1000.0;
    final decelerationLength = widget.decelerationCurve.integral *
        velocity *
        widget.decelerationDuration.inMilliseconds /
        1000.0;
    final linearLength =
        (totalLength - accelerationLength.abs() - decelerationLength.abs()) *
            (velocity > 0 ? 1 : -1);

    _startPosition = 2 * totalLength - widget.startPadding;
    _accelerationTarget = _startPosition + accelerationLength;
    _linearTarget = _accelerationTarget + linearLength;
    _decelerationTarget = _linearTarget + decelerationLength;

    _totalDuration = widget.accelerationDuration +
        widget.decelerationDuration +
        Duration(milliseconds: (linearLength / velocity * 1000).abs().toInt());
    _linearDuration = _totalDuration -
        widget.accelerationDuration -
        widget.decelerationDuration;

    assert(
      _totalDuration > Duration.zero,
      'The total duration for one round must stay positive.',
    );
    assert(
      _linearDuration! >= Duration.zero,
      'Acceleration and deceleration phases overlap for the current settings.',
    );
  }

  void _captureChildExtent() {
    if (widget.child == null) return;
    final context = _measureKey.currentContext;
    if (context == null) return;
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return;
    final nextExtent = widget.effectiveAxis == Axis.horizontal
        ? renderBox.size.width
        : renderBox.size.height;
    if (_childExtent == nextExtent) return;
    setState(() {
      _childExtent = nextExtent;
    });
  }

  Future<void> _makeRoundTrip(int sessionId) async {
    if (!_scrollController.hasClients) return;
    _scrollController.jumpTo(_startPosition);
    if (!_running) return;

    await _animateTo(
      _accelerationTarget,
      widget.accelerationDuration,
      widget.accelerationCurve,
      sessionId,
    );
    if (!_isSessionActive(sessionId)) return;

    await _animateTo(_linearTarget, _linearDuration, Curves.linear, sessionId);
    if (!_isSessionActive(sessionId)) return;

    await _animateTo(
      _decelerationTarget,
      widget.decelerationDuration,
      widget.decelerationCurve.flipped,
      sessionId,
    );
  }

  Future<void> _animateTo(
    double target,
    Duration? duration,
    Curve curve,
    int sessionId,
  ) async {
    if (!_scrollController.hasClients || !_isSessionActive(sessionId)) return;

    await _waitUntilResumed(sessionId);
    if (!_isSessionActive(sessionId)) return;

    if (duration == null || duration <= Duration.zero) {
      _scrollController.jumpTo(target);
      return;
    }

    _cancelActiveAnimation();
    _movementController.duration = duration;

    final animation = Tween<double>(
      begin: _scrollController.position.pixels,
      end: target,
    ).animate(CurvedAnimation(parent: _movementController, curve: curve));

    final completer = Completer<void>();
    _activeAnimationCompleter = completer;

    _animationTickListener = () {
      if (!_scrollController.hasClients || !_isSessionActive(sessionId)) return;
      final pixels = animation.value.clamp(
        _scrollController.position.minScrollExtent,
        _scrollController.position.maxScrollExtent,
      );
      _scrollController.jumpTo(pixels);
    };
    _animationStatusListener = (status) {
      if (status == AnimationStatus.completed && !completer.isCompleted) {
        completer.complete();
      }
    };

    _movementController.addListener(_animationTickListener!);
    _movementController.addStatusListener(_animationStatusListener!);
    _movementController.forward(from: 0.0);
    await completer.future;
    _detachAnimationCallbacks();
  }

  void _cancelActiveAnimation() {
    _movementController.stop();
    if (_activeAnimationCompleter != null &&
        !_activeAnimationCompleter!.isCompleted) {
      _activeAnimationCompleter!.complete();
    }
    _activeAnimationCompleter = null;
    _detachAnimationCallbacks();
  }

  void _detachAnimationCallbacks() {
    if (_animationTickListener != null) {
      _movementController.removeListener(_animationTickListener!);
      _animationTickListener = null;
    }
    if (_animationStatusListener != null) {
      _movementController.removeStatusListener(_animationStatusListener!);
      _animationStatusListener = null;
    }
  }

  double _measureSpanExtent() {
    if (widget.child != null) {
      return _childExtent ?? 0.0;
    }

    final painter = TextPainter(
      text: _baseInlineSpan(),
      textDirection: widget.textDirection,
      textScaler: widget.textScaleFactor != null
          ? TextScaler.linear(widget.textScaleFactor!)
          : TextScaler.noScaling,
      maxLines: 1,
    )..layout();

    return widget.effectiveAxis == Axis.horizontal
        ? painter.width
        : painter.height;
  }

  bool _isSessionActive(int sessionId) =>
      mounted && _running && _sessionId == sessionId;

  Future<void> _waitUntilResumed(int sessionId) async {
    while (_isSessionActive(sessionId) && _isPaused) {
      _resumeCompleter ??= Completer<void>();
      await _resumeCompleter!.future;
    }
  }

  Future<void> _delayWithPause(Duration duration, int sessionId) async {
    if (duration <= Duration.zero) return;

    final stopwatch = Stopwatch()..start();
    while (_isSessionActive(sessionId) && stopwatch.elapsed < duration) {
      if (_isPaused) {
        stopwatch.stop();
        await _waitUntilResumed(sessionId);
        if (!_isSessionActive(sessionId)) return;
        stopwatch.start();
        continue;
      }

      final remaining = duration - stopwatch.elapsed;
      final slice = remaining > const Duration(milliseconds: 16)
          ? const Duration(milliseconds: 16)
          : remaining;
      await Future<void>.delayed(slice);
    }
  }

  void _restartLoop() {
    _running = true;
    _roundCounter = 0;
    _sessionId++;
    _cancelActiveAnimation();

    if (!_scrollController.hasClients) return;

    _initialize();
    final sessionId = _sessionId;
    final shouldScroll = _shouldScrollForCurrentConstraints();
    _scrollController.jumpTo(shouldScroll ? _startPosition : 0.0);

    if (shouldScroll) {
      unawaited(_scroll(sessionId));
    } else if (mounted) {
      setState(() => _isOnPause = false);
    }
  }

  bool _shouldScrollForCurrentConstraints() {
    if (widget.child != null && (_childExtent == null || _childExtent == 0.0)) {
      return false;
    }

    if (!widget.onlyIfOverflow) return true;
    final size = context.size;
    if (size == null) return true;

    final mainAxisExtent =
        widget.effectiveAxis == Axis.horizontal ? size.width : size.height;
    return _measureSpanExtent() > mainAxisExtent;
  }

  void _syncPausedState() {
    final nextValue =
        _manualPauseRequested || _hoverPauseActive || _tapPauseActive;
    if (_isPaused == nextValue) return;

    if (mounted) {
      setState(() => _isPaused = nextValue);
    } else {
      _isPaused = nextValue;
    }

    if (nextValue) {
      _resumeCompleter ??= Completer<void>();
      _movementController.stop();
      _colorController.stop();
    } else {
      if (_resumeCompleter != null && !_resumeCompleter!.isCompleted) {
        _resumeCompleter!.complete();
      }
      _resumeCompleter = null;
      if (_movementController.duration != null &&
          _movementController.value < 1.0 &&
          !_movementController.isAnimating &&
          _animationTickListener != null) {
        unawaited(_movementController.forward());
      }
      if (_hasColorCycle && !_colorController.isAnimating) {
        _colorController.repeat();
      }
    }
  }

  void _setManualPaused(bool value) {
    if (_manualPauseRequested == value) return;
    _manualPauseRequested = value;
    _syncPausedState();
  }

  void _setHoverPaused(bool value) {
    if (_hoverPauseActive == value) return;
    _hoverPauseActive = value;
    _syncPausedState();
  }

  void _toggleTapPause() {
    _tapPauseActive = !_tapPauseActive;
    _syncPausedState();
  }

  @override
  void pause() => _setManualPaused(true);

  @override
  void resume() => _setManualPaused(false);

  @override
  void restart() {
    _manualPauseRequested = false;
    _hoverPauseActive = false;
    _tapPauseActive = false;
    _syncPausedState();
    _restartLoop();
  }

  Color? _currentAnimatedColor() {
    if (!_hasColorCycle) return null;
    final colors = widget.colorCycle!;
    final progress = _colorController.value * colors.length;
    final index = progress.floor() % colors.length;
    final nextIndex = (index + 1) % colors.length;
    final t = progress - progress.floorToDouble();

    if (!widget.enableColorTransition) {
      return colors[index];
    }

    return Color.lerp(colors[index], colors[nextIndex], t);
  }

  InlineSpan _baseInlineSpan() {
    if (widget.richText != null) {
      return widget.richText!;
    }

    return TextSpan(
      text: widget.text ?? '',
      style: widget.style,
    );
  }

  InlineSpan _spanWithAnimatedColor(InlineSpan span, Color color) {
    if (span is TextSpan) {
      return TextSpan(
        text: span.text,
        style: (span.style ?? const TextStyle()).copyWith(color: color),
        children: span.children
            ?.map((child) => _spanWithAnimatedColor(child, color))
            .toList(),
        recognizer: span.recognizer,
        semanticsLabel: span.semanticsLabel,
        mouseCursor: span.mouseCursor,
        onEnter: span.onEnter,
        onExit: span.onExit,
        locale: span.locale,
        spellOut: span.spellOut,
      );
    }

    return span;
  }

  Widget _buildContent() {
    if (widget.child != null) {
      return widget.child!;
    }

    final animatedColor = _currentAnimatedColor();
    final span = animatedColor == null
        ? _baseInlineSpan()
        : _spanWithAnimatedColor(_baseInlineSpan(), animatedColor);

    return RichText(
      text: span,
      textDirection: widget.textDirection,
      textScaler: widget.textScaleFactor != null
          ? TextScaler.linear(widget.textScaleFactor!)
          : TextScaler.noScaling,
      maxLines: 1,
      overflow: TextOverflow.visible,
    );
  }

  Alignment? _alignmentForAxis(Axis axis) {
    switch (widget.crossAxisAlignment) {
      case CrossAxisAlignment.start:
        return axis == Axis.horizontal
            ? Alignment.topCenter
            : Alignment.centerLeft;
      case CrossAxisAlignment.end:
        return axis == Axis.horizontal
            ? Alignment.bottomCenter
            : Alignment.centerRight;
      case CrossAxisAlignment.center:
        return Alignment.center;
      case CrossAxisAlignment.stretch:
      case CrossAxisAlignment.baseline:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    _initialize();
    final axis = widget.effectiveAxis;
    final alignment = _alignmentForAxis(axis);

    Widget marquee = ListView.builder(
      controller: _scrollController,
      scrollDirection: axis,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        Widget child;
        if (index.isEven) {
          child = _hasColorCycle
              ? AnimatedBuilder(
                  animation: _colorController,
                  builder: (context, _) => _buildContent(),
                )
              : _buildContent();
        } else {
          child = _buildBlankSpace(axis);
        }

        return alignment == null
            ? child
            : Align(alignment: alignment, child: child);
      },
    );

    if (!kIsWeb) {
      marquee = _wrapWithFadingEdgeScrollView(marquee);
    }

    if (widget.pauseOnHover) {
      marquee = MouseRegion(
        onEnter: (_) => _setHoverPaused(true),
        onExit: (_) => _setHoverPaused(false),
        child: marquee,
      );
    }

    if (widget.pauseOnTap) {
      marquee = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _toggleTapPause,
        child: marquee,
      );
    }

    if (widget.child == null) {
      return marquee;
    }

    return Stack(
      children: [
        Offstage(
          child: TickerMode(
            enabled: false,
            child: KeyedSubtree(
              key: _measureKey,
              child: widget.child!,
            ),
          ),
        ),
        marquee,
      ],
    );
  }

  Widget _buildBlankSpace(Axis axis) {
    return SizedBox(
      width: axis == Axis.horizontal ? widget.blankSpace : null,
      height: axis == Axis.vertical ? widget.blankSpace : null,
    );
  }

  Widget _wrapWithFadingEdgeScrollView(Widget child) {
    return FadingEdgeScrollView.fromScrollView(
      gradientFractionOnStart:
          !_showFading ? 0.0 : widget.fadingEdgeStartFraction,
      gradientFractionOnEnd: !_showFading ? 0.0 : widget.fadingEdgeEndFraction,
      child: child as ScrollView,
    );
  }
}
