import 'package:flutter/material.dart';
import 'package:marquee_text/marquee_text.dart';

void main() => runApp(const MarqueeTextExampleApp());

class MarqueeTextExampleApp extends StatelessWidget {
  const MarqueeTextExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marquee Text Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0B6E4F),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F1E8),
        useMaterial3: true,
      ),
      home: const MarqueeExamplePage(),
    );
  }
}

class MarqueeExamplePage extends StatelessWidget {
  const MarqueeExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F1E8),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF8F3E8),
              Color(0xFFEAF6EF),
              Color(0xFFFDF9F1),
            ],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // const _PageHeader(),
              const SizedBox(height: 14),
              _ExampleCard(
                title: 'Breaking News',
                tickerHeight: 60,
                backgroundStyle: _TickerBackgroundStyle.cream,
                child: Marquee(
                  text:
                      'Breaking news: Marquee Text helps you animate long headlines smoothly in Flutter apps.',
                  direction: MarqueeDirection.rightToLeft,
                  speed: 60,
                  blankSpace: 32,
                  pauseAfterRound: const Duration(milliseconds: 700),
                  fadingEdgeStartFraction: 0.08,
                  fadingEdgeEndFraction: 0.08,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              _ExampleCard(
                title: 'Promo Banner',
                tickerHeight: 60,
                backgroundStyle: _TickerBackgroundStyle.mint,
                child: Marquee(
                  direction: MarqueeDirection.leftToRight,
                  speed: 58,
                  blankSpace: 28,
                  richText: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Weekend Deal ',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F766E),
                        ),
                      ),
                      TextSpan(
                        text: '50% OFF',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF7C3AED),
                        ),
                      ),
                      TextSpan(
                        text: ' on premium plans.',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF374151),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              _ExampleCard(
                title: 'Finance Ticker',
                tickerHeight: 60,
                backgroundStyle: _TickerBackgroundStyle.midnight,
                child: Marquee(
                  direction: MarqueeDirection.leftToRight,
                  speed: 52,
                  blankSpace: 20,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.trending_up, color: Color(0xFF34D399)),
                      SizedBox(width: 10),
                      _MiniChip(text: 'BTC +2.3%'),
                      SizedBox(width: 10),
                      _MiniChip(text: 'ETH +1.1%'),
                      SizedBox(width: 10),
                      _MiniChip(text: 'SOL +4.8%'),
                      SizedBox(width: 10),
                      _MiniChip(text: 'AAPL +0.9%'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              _ExampleCard(
                title: 'Live Alert',
                tickerHeight: 60,
                backgroundStyle: _TickerBackgroundStyle.cream,
                child: Marquee(
                  text:
                      'System alert: maintenance starts at 11:30 PM. Save your work before the countdown ends.',
                  direction: MarqueeDirection.rightToLeft,
                  speed: 64,
                  blankSpace: 30,
                  colorCycle: const [
                    Color(0xFFEF4444),
                    Color(0xFFF59E0B),
                    Color(0xFF10B981),
                    Color(0xFF3B82F6),
                  ],
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              _ExampleCard(
                title: 'Vertical Feed',
                tickerHeight: 116,
                backgroundStyle: _TickerBackgroundStyle.midnight,
                child: Marquee(
                  text:
                      'Tokyo 09:15  •  London 01:15  •  New York 20:15  •  Dubai 05:15  •  Singapore 08:15',
                  direction: MarqueeDirection.bottomToTop,
                  speed: 34,
                  blankSpace: 18,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFF8FAFC),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              _ExampleCard(
                title: 'Product Tags',
                tickerHeight: 60,
                backgroundStyle: _TickerBackgroundStyle.mint,
                child: Marquee(
                  direction: MarqueeDirection.rightToLeft,
                  speed: 48,
                  blankSpace: 18,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _MiniChip(text: 'New Arrival'),
                      SizedBox(width: 10),
                      _MiniChip(text: 'Free Shipping'),
                      SizedBox(width: 10),
                      _MiniChip(text: 'Best Seller'),
                      SizedBox(width: 10),
                      _MiniChip(text: 'Limited Drop'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExampleCard extends StatelessWidget {
  const _ExampleCard({
    required this.title,
    required this.tickerHeight,
    required this.backgroundStyle,
    required this.child,
  });

  final String title;
  final double tickerHeight;
  final _TickerBackgroundStyle backgroundStyle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE1D8C8)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x16000000),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: tickerHeight,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: backgroundStyle.decoration,
            child: child,
          ),
        ],
      ),
    );
  }
}

enum _TickerBackgroundStyle {
  cream,
  midnight,
  mint,
}

extension on _TickerBackgroundStyle {
  BoxDecoration get decoration {
    switch (this) {
      case _TickerBackgroundStyle.cream:
        return BoxDecoration(
          color: const Color(0xFFFFFCF7),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE9DFC9)),
        );
      case _TickerBackgroundStyle.midnight:
        return BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF111827),
              Color(0xFF1F2937),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF334155)),
        );
      case _TickerBackgroundStyle.mint:
        return BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE7FFF5),
              Color(0xFFDDF7EC),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFBFE7D4)),
        );
    }
  }
}

class _PageHeader extends StatelessWidget {
  const _PageHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE1D8C8)),
      ),
      child: const Row(
        children: [
          Icon(Icons.view_quilt_rounded, color: Color(0xFF0F766E)),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Marquee Text Examples',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniChip extends StatelessWidget {
  const _MiniChip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5EE),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFB8D9C8)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: Color(0xFF14532D),
        ),
      ),
    );
  }
}
