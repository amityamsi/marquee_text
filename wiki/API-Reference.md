# API Reference

## Main Types

### `Marquee`

The main scrolling widget.

### `MarqueeController`

Used to pause, resume, and restart a marquee from outside the widget tree.

### `MarqueeDirection`

Direction presets:

- `MarqueeDirection.rightToLeft`
- `MarqueeDirection.leftToRight`
- `MarqueeDirection.bottomToTop`
- `MarqueeDirection.topToBottom`

## `Marquee` Constructor

### Content

- `text`
  Use for a plain string.
- `richText`
  Use for a `TextSpan` tree.
- `child`
  Use for any custom widget.

Exactly one of these must be provided.

### Text Styling

- `style`
  Base text style used with `text`.
- `textScaleFactor`
  Text scaling used when building text content.
- `textDirection`
  Text direction for text and rich text rendering.

### Motion

- `direction`
  Preferred high-level direction setting. Also determines the effective axis.
- `scrollAxis`
  Used when `direction` is not provided.
- `speed`
  Positive speed value for directional scrolling setups.
- `velocity`
  Raw velocity value. Defaults to `50.0`.
- `blankSpace`
  Space between repeated items.
- `startPadding`
  Leading offset before the first visible pass.

### Timing

- `startAfter`
  Delay before motion begins.
- `pauseAfterRound`
  Pause duration after each completed round.
- `numberOfRounds`
  Stops after a fixed number of loops when set.
- `startPaused`
  Starts in paused mode.

### Animation Curves

- `accelerationDuration`
  Duration of the acceleration phase.
- `accelerationCurve`
  Curve used while accelerating.
- `decelerationDuration`
  Duration of the deceleration phase.
- `decelerationCurve`
  Curve used while slowing down.

### Interaction

- `pauseOnHover`
  Pauses while the pointer is over the widget.
- `pauseOnTap`
  Toggles pause when tapped.
- `controller`
  Optional external control handle.

### Fading Edges

- `fadingEdgeStartFraction`
  Fade amount at the leading edge.
- `fadingEdgeEndFraction`
  Fade amount at the trailing edge.
- `showFadingOnlyWhenScrolling`
  Disables fade visuals while paused.

Note: fading edges are not applied on web in the current implementation.

### Overflow and Alignment

- `onlyIfOverflow`
  Only scrolls when content is larger than the available main-axis space.
- `crossAxisAlignment`
  Alignment across the non-scrolling axis.

### Color Animation

- `colorCycle`
  A list of two or more colors used for animated foreground color changes.
- `colorCycleDuration`
  Full cycle duration.
- `enableColorTransition`
  Interpolates between colors when true; otherwise jumps between them.

### Callbacks

- `onRoundCompleted`
  Called after each full round.
- `onDone`
  Called once the configured `numberOfRounds` completes.

## `MarqueeController`

### `pause()`

Pauses the marquee and keeps it paused until resumed.

### `resume()`

Resumes scrolling.

### `restart()`

Restarts the marquee from the beginning.

### `isAttached`

Returns `true` when the controller is connected to a `Marquee`.

### `startPaused`

Internal state reflecting whether the controller currently requests a paused
start/resume state.

