# Examples and Recipes

## News Ticker

```dart
SizedBox(
  height: 52,
  child: Marquee(
    text: 'Breaking news: service maintenance starts at 11:30 PM.',
    direction: MarqueeDirection.rightToLeft,
    speed: 64,
    blankSpace: 24,
    fadingEdgeStartFraction: 0.08,
    fadingEdgeEndFraction: 0.08,
    style: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w700,
    ),
  ),
)
```

## Promo Banner With Rich Text

```dart
SizedBox(
  height: 52,
  child: Marquee(
    direction: MarqueeDirection.leftToRight,
    speed: 58,
    blankSpace: 28,
    richText: const TextSpan(
      children: [
        TextSpan(
          text: 'Weekend Deal ',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F766E),
          ),
        ),
        TextSpan(
          text: '50% OFF',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Color(0xFF7C3AED),
          ),
        ),
        TextSpan(
          text: ' on premium plans.',
          style: TextStyle(color: Color(0xFF374151)),
        ),
      ],
    ),
  ),
)
```

## Finance Ticker With Custom Widgets

```dart
SizedBox(
  height: 60,
  child: Marquee(
    direction: MarqueeDirection.leftToRight,
    speed: 52,
    blankSpace: 20,
    child: const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.trending_up, color: Color(0xFF34D399)),
        SizedBox(width: 10),
        Chip(label: Text('BTC +2.3%')),
        SizedBox(width: 10),
        Chip(label: Text('ETH +1.1%')),
        SizedBox(width: 10),
        Chip(label: Text('SOL +4.8%')),
      ],
    ),
  ),
)
```

## Vertical Feed

```dart
SizedBox(
  height: 120,
  child: Marquee(
    text: 'Tokyo 09:15  •  London 01:15  •  New York 20:15',
    direction: MarqueeDirection.bottomToTop,
    speed: 34,
    blankSpace: 18,
    style: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w700,
    ),
  ),
)
```

## Pause On Hover

```dart
Marquee(
  text: 'Hover me to pause.',
  direction: MarqueeDirection.rightToLeft,
  speed: 60,
  pauseOnHover: true,
)
```

## Toggle Pause On Tap

```dart
Marquee(
  text: 'Tap to pause and tap again to resume.',
  direction: MarqueeDirection.rightToLeft,
  speed: 60,
  pauseOnTap: true,
)
```

## Controlled Marquee

```dart
final controller = MarqueeController();

Column(
  children: [
    SizedBox(
      height: 52,
      child: Marquee(
        controller: controller,
        text: 'Controller demo',
        direction: MarqueeDirection.rightToLeft,
        speed: 64,
      ),
    ),
    Row(
      children: [
        ElevatedButton(
          onPressed: controller.pause,
          child: const Text('Pause'),
        ),
        ElevatedButton(
          onPressed: controller.resume,
          child: const Text('Resume'),
        ),
        ElevatedButton(
          onPressed: controller.restart,
          child: const Text('Restart'),
        ),
      ],
    ),
  ],
)
```

## Animated Color Cycle

```dart
Marquee(
  text: 'System alert: maintenance starts at 11:30 PM.',
  direction: MarqueeDirection.rightToLeft,
  speed: 64,
  colorCycle: const [
    Colors.red,
    Colors.orange,
    Colors.green,
    Colors.blue,
  ],
  colorCycleDuration: const Duration(seconds: 4),
)
```

## Stop After N Rounds

```dart
Marquee(
  text: 'This message will stop after three rounds.',
  direction: MarqueeDirection.rightToLeft,
  speed: 56,
  numberOfRounds: 3,
  onDone: () {
    debugPrint('Marquee finished');
  },
)
```

