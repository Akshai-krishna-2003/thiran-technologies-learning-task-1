import 'dart:async';
import 'package:flutter/material.dart';

class LoadingWithText extends StatefulWidget {
  final List<String> texts;
  final double? progress;
  final Duration textSwitchDuration;
  final double size;
  final TextStyle? textStyle;
  final Color? progressColor;
  final bool showPercentage;

  const LoadingWithText({
    super.key,
    this.texts = const [
      '.',
      '..',
      '...',
      '....',
    ],
    this.progress,
    this.textSwitchDuration = const Duration(milliseconds: 500),
    this.size = 100,
    this.textStyle,
    this.progressColor,
    this.showPercentage = true,
  });

  @override
  State<LoadingWithText> createState() => _LoadingWithTextState();
}

class _LoadingWithTextState extends State<LoadingWithText> {
  late Timer _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.textSwitchDuration, (_) {
      setState(() {
        _index = (_index + 1) % widget.texts.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTextStyle = widget.textStyle ??
        const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: widget.size,
                height: widget.size,
                child: CircularProgressIndicator(
                  value: widget.progress,
                  strokeWidth: 6,
                  color: widget.progressColor ?? Theme.of(context).primaryColor,
                ),
              ),
              if (widget.showPercentage && widget.progress != null)
                Text(
                  '${(widget.progress! * 100).toStringAsFixed(0)}%',
                  style: effectiveTextStyle,
                ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Downloading flags",
                style: effectiveTextStyle,
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: child,
                ),
                child: Text(
                  widget.texts[_index],
                  key: ValueKey(widget.texts[_index]),
                  style: effectiveTextStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
