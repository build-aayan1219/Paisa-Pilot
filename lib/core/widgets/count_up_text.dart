import 'package:flutter/material.dart';
import '../formatters/currency_formatter.dart';

class CountUpText extends StatefulWidget {
  final num value;
  final TextStyle? style;
  final Duration duration;
  final Curve curve;
  final bool isCurrency;
  final String prefix;
  final String suffix;

  const CountUpText({
    super.key,
    required this.value,
    this.style,
    this.duration = const Duration(milliseconds: 600),
    this.curve = Curves.easeOutCubic,
    this.isCurrency = true,
    this.prefix = '',
    this.suffix = '',
  });

  @override
  State<CountUpText> createState() => _CountUpTextState();
}

class _CountUpTextState extends State<CountUpText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _oldValue = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: 0.0, end: widget.value.toDouble()).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );
    _oldValue = widget.value.toDouble();
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant CountUpText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _oldValue = oldWidget.value.toDouble();
      _animation = Tween<double>(
        begin: _oldValue,
        end: widget.value.toDouble(),
      ).animate(
        CurvedAnimation(parent: _controller, curve: widget.curve),
      );
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) {
      final formatted = widget.isCurrency
          ? CurrencyFormatter.format(widget.value)
          : widget.value.toString();
      return Text(
        '${widget.prefix}$formatted${widget.suffix}',
        style: widget.style,
      );
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final current = _animation.value;
        final formatted = widget.isCurrency
            ? CurrencyFormatter.format(current)
            : current.toInt().toString();

        return Text(
          '${widget.prefix}$formatted${widget.suffix}',
          style: widget.style,
        );
      },
    );
  }
}
