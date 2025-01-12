import 'package:flutter/material.dart';
import 'package:livora/utils/themes/app_colors.dart';

enum SlideDirection { leftToRight, rightToLeft, topToBottom, bottomToTop }

class SnakeSlideLightEffect extends StatefulWidget {
  final IconData icon;
  final double size;
  final SlideDirection slideDirection;

  const SnakeSlideLightEffect({
    Key? key,
    required this.icon,
    this.size = 100.0,
    this.slideDirection = SlideDirection.leftToRight,
  }) : super(key: key);

  @override
  _SnakeSlideLightEffectState createState() => _SnakeSlideLightEffectState();
}

class _SnakeSlideLightEffectState extends State<SnakeSlideLightEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true); // Repeat indefinitely
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          widget.icon,
          size: widget.size,
          color: Colors.grey[800],
        ),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            // Calculate the begin and end of the gradient depending on the slide direction
            Alignment begin = Alignment(-1.0 + 2.0 * _controller.value, 0.1);
            Alignment end = Alignment(1.0 + 2.0 * _controller.value, 0.1);

            switch (widget.slideDirection) {
              case SlideDirection.rightToLeft:
                begin = Alignment(1.0 - 2.0 * _controller.value, 0.1);
                end = Alignment(-1.0 - 2.0 * _controller.value, 0.1);
                break;
              case SlideDirection.topToBottom:
                begin = Alignment(0.1, -1.0 + 2.0 * _controller.value);
                end = Alignment(0.1, 1.0 + 2.0 * _controller.value);
                break;
              case SlideDirection.bottomToTop:
                begin = Alignment(0.1, 1.0 - 2.0 * _controller.value);
                end = Alignment(0.1, -1.0 - 2.0 * _controller.value);
                break;
              default:
                break;
            }

            return ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [
                    AppColors.multipleColor4,
                    AppColors.multipleColor1,
                    AppColors.multipleColor5,
                  ],
                  stops: [0.0, 0.5, 1.0],
                  begin: begin,
                  end: end,
                ).createShader(bounds);
              },
              child: child,
              blendMode: BlendMode.srcATop,
            );
          },
          child: Icon(
            widget.icon,
            size: widget.size,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
