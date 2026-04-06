# marquee_pro

`marquee_pro` is a Flutter widget package for building smooth, infinitely
scrolling marquee content.

It supports:

- Plain text with `text`
- Rich text with `richText`
- Custom widgets with `child`
- Horizontal and vertical movement
- Pause and resume controls
- Fading edges
- Hover and tap pause
- Round callbacks and completion callbacks
- Optional animated foreground color cycling

## Quick Start

Add the package:

```yaml
dependencies:
  marquee_pro: ^1.0.0
```

Import it:

```dart
import 'package:marquee_pro/marquee_pro.dart';
```

Minimal example:

```dart
Marquee(
  text: 'Breaking news and updates move smoothly across the screen.',
  direction: MarqueeDirection.rightToLeft,
  speed: 70,
)
```

## Best Use Cases

- News tickers
- Announcement bars
- Product promo strips
- Alert banners
- Finance or crypto tickers
- Vertical rotating feeds
- Scrolling tag or chip rows

## Wiki Pages

- [Getting Started](Getting-Started)
- [API Reference](API-Reference)
- [Examples and Recipes](Examples-and-Recipes)
- [Troubleshooting](Troubleshooting)

## Core Concepts

`Marquee` scrolls one repeated content item followed by blank space in a loop.

You must provide exactly one content source:

- `text`
- `richText`
- `child`

Scrolling behavior is controlled with a mix of:

- Direction and axis
- Speed or velocity
- Delay and pause settings
- Overflow rules
- Color animation options

If you want programmatic control, attach a `MarqueeController` and call
`pause()`, `resume()`, or `restart()`.

