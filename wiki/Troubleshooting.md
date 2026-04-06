# Troubleshooting

## The marquee is not moving

Check the following:

- The widget has enough layout space to render.
- You provided exactly one of `text`, `richText`, or `child`.
- `speed` is positive if you use it.
- `velocity` is not zero.
- If `onlyIfOverflow` is enabled, confirm that the content is actually larger
  than the available width or height.

## My custom widget marquee does not start immediately

When `child` is used, the package measures a hidden copy of that widget first so
it can calculate scroll distances. This is expected.

## Fading edges are not visible

Check these settings:

- `fadingEdgeStartFraction`
- `fadingEdgeEndFraction`
- `showFadingOnlyWhenScrolling`

Also note that fading edges are not applied on web in the current
implementation.

## The marquee starts paused

This can happen when:

- `startPaused` is `true`
- A connected `MarqueeController` has already requested pause

Resume it with:

```dart
controller.resume();
```

## `onlyIfOverflow` does not seem to work

`onlyIfOverflow` depends on the final rendered size of the marquee. It works
best when the widget is inside a parent with clear constraints such as:

- `SizedBox`
- `Container`
- `Expanded`
- `Flexible`

## What is the difference between `speed` and `velocity`?

Use:

- `speed` when you want a positive motion magnitude paired with a `direction`
- `velocity` when you want direct control over the signed movement value

For the clearest behavior, prefer setting `direction` explicitly.

## Hover pause does not work on mobile

`pauseOnHover` only makes sense on platforms with pointer hover. On touch-first
devices, use `pauseOnTap` or a `MarqueeController`.

## Rich text colors are being overridden

If you enable `colorCycle`, the package applies animated foreground colors to
the text span tree. If you want per-span colors to stay fixed, leave
`colorCycle` unset.

