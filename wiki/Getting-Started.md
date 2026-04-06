# Getting Started

## Installation

Add `marquee_pro` to your `pubspec.yaml`:

```yaml
dependencies:
  marquee_pro: ^1.0.0
```

Then fetch packages:

```bash
flutter pub get
```

## Import

```dart
import 'package:marquee_pro/marquee_pro.dart';
```

## Your First Marquee

```dart
import 'package:flutter/material.dart';
import 'package:marquee_pro/marquee_pro.dart';

class DemoTicker extends StatelessWidget {
  const DemoTicker({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Marquee(
        text: 'Welcome to marquee_pro.',
        direction: MarqueeDirection.rightToLeft,
        speed: 60,
        blankSpace: 24,
      ),
    );
  }
}
```

## Content Modes

Use one of the following:

### Plain text

```dart
Marquee(
  text: 'Shipping is free on all orders today.',
  direction: MarqueeDirection.rightToLeft,
  speed: 64,
)
```

### Rich text

```dart
Marquee(
  direction: MarqueeDirection.leftToRight,
  speed: 56,
  richText: const TextSpan(
    children: [
      TextSpan(
        text: 'Launch week ',
        style: TextStyle(fontWeight: FontWeight.w700, color: Colors.blue),
      ),
      TextSpan(
        text: '50% OFF',
        style: TextStyle(fontWeight: FontWeight.w900, color: Colors.red),
      ),
    ],
  ),
)
```

### Custom widget

```dart
Marquee(
  direction: MarqueeDirection.leftToRight,
  speed: 52,
  blankSpace: 18,
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: const [
      Icon(Icons.local_fire_department),
      SizedBox(width: 10),
      Chip(label: Text('Flash Sale')),
      SizedBox(width: 10),
      Chip(label: Text('Free Shipping')),
    ],
  ),
)
```

## Programmatic Control

```dart
final controller = MarqueeController();

Marquee(
  controller: controller,
  text: 'Controlled marquee',
  direction: MarqueeDirection.rightToLeft,
  speed: 60,
);
```

Available controller actions:

- `controller.pause()`
- `controller.resume()`
- `controller.restart()`

## Common Layout Advice

- Wrap the widget in a parent with a known height.
- For horizontal marquees, use a fixed-height parent like `SizedBox` or
  `Container`.
- For vertical marquees, give the widget enough height to reveal the scrolling
  content.
- If you use `onlyIfOverflow`, make sure the marquee is inside a widget with
  real layout constraints.

