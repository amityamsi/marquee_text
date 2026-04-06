# Marquee Text

Marquee Text by CodeMicros is a production-ready Flutter marquee widget for
smooth, infinitely scrolling text, rich spans, and custom widgets.

![Marquee Text Demo](assets/demo.gif)

## Features

- Scroll plain text, `RichText`, or any custom widget.
- Choose left, right, up, or down marquee direction.
- Use `speed` or `velocity` for motion control.
- Add fading edges, pause timing, start delay, and round limits.
- Pause on hover, pause on tap, or control playback with `MarqueeController`.
- Animate foreground colors with `colorCycle`.
- Avoid unnecessary animation with `onlyIfOverflow`.
- Listen for round completion with `onRoundCompleted` and finish state with `onDone`.

## Why This Package

- Better suited for product banners, finance tickers, promo strips, status feeds, and announcement bars.
- Supports more than text-only marquees.
- Designed to be easy to style and integrate into production UI.

## Basic Example

```dart
import 'package:marquee_text/marquee_text.dart';

Marquee(
  text: 'Breaking news and updates move smoothly across the screen.',
  direction: MarqueeDirection.rightToLeft,
  speed: 70,
)
```

## Production Example

```dart
final controller = MarqueeController();

Container(
  height: 52,
  padding: const EdgeInsets.symmetric(horizontal: 12),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(14),
  ),
  child: Marquee(
    controller: controller,
    text: 'Breaking update: service maintenance starts at 11:30 PM.',
    direction: MarqueeDirection.rightToLeft,
    speed: 64,
    blankSpace: 24,
    pauseOnHover: true,
    fadingEdgeStartFraction: 0.08,
    fadingEdgeEndFraction: 0.08,
    style: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w700,
    ),
  ),
)
```

## Rich Text Example

```dart
Marquee(
  direction: MarqueeDirection.leftToRight,
  speed: 56,
  richText: const TextSpan(
    children: [
      TextSpan(
        text: 'Launch week ',
        style: TextStyle(fontWeight: FontWeight.w800, color: Colors.blue),
      ),
      TextSpan(
        text: '50% OFF',
        style: TextStyle(fontWeight: FontWeight.w900, color: Colors.deepPurple),
      ),
      TextSpan(
        text: ' on premium widgets.',
        style: TextStyle(color: Colors.black87),
      ),
    ],
  ),
)
```

## Widget Example

```dart
Marquee(
  direction: MarqueeDirection.leftToRight,
  speed: 52,
  blankSpace: 18,
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: const [
      Icon(Icons.local_fire_department, color: Colors.deepOrange),
      SizedBox(width: 10),
      Chip(label: Text('Flash Sale')),
      SizedBox(width: 10),
      Chip(label: Text('Premium Widgets')),
    ],
  ),
)
```

## Advanced Example

```dart
final controller = MarqueeController();

Marquee(
  controller: controller,
  direction: MarqueeDirection.rightToLeft,
  speed: 96,
  blankSpace: 24,
  onlyIfOverflow: true,
  pauseOnHover: true,
  pauseOnTap: true,
  colorCycle: const [
    Colors.red,
    Colors.orange,
    Colors.green,
    Colors.blue,
  ],
  colorCycleDuration: const Duration(seconds: 4),
  pauseAfterRound: const Duration(milliseconds: 700),
  accelerationDuration: const Duration(milliseconds: 800),
  decelerationDuration: const Duration(milliseconds: 450),
  onRoundCompleted: (round) => debugPrint('Completed round $round'),
  text: 'Interactive marquee with controller support and animated colors.',
)
```

## Support

- Publisher: CodeMicros
- Support: [codemicros.com/support](https://codemicros.com/support)
- Website: [codemicros.com](https://codemicros.com)

## License

This package is distributed under the MIT License.
# marquee_text
