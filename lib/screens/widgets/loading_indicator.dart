import 'package:flutter/material.dart';
import 'dart:math' as math;

class FancyLoadingIndicator extends StatefulWidget {
  final Color? primaryColor;
  final Color? secondaryColor;
  final double size;
  final String? message;
  final bool showMessage;

  const FancyLoadingIndicator({
    super.key,
    this.primaryColor,
    this.secondaryColor,
    this.size = 200,
    this.message,
    this.showMessage = true,
  });

  @override
  State<FancyLoadingIndicator> createState() => _FancyLoadingIndicatorState();
}

class _FancyLoadingIndicatorState extends State<FancyLoadingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late List<AnimationController> _dotControllers;
  late List<Animation<double>> _dotAnimations;

  @override
  void initState() {
    super.initState();

    // Rotation animation
    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    // Pulse animation
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    // Dot animations
    _dotControllers = List.generate(
      3,
          (index) => AnimationController(
        duration: Duration(milliseconds: 600 + (index * 200)),
        vsync: this,
      )..repeat(reverse: true),
    );

    _dotAnimations = _dotControllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        ),
      );
    }).toList();

    // Start dot animations with delays
    for (var i = 0; i < _dotControllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (mounted) {
          _dotControllers[i].forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    for (var controller in _dotControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = widget.primaryColor ?? Theme.of(context).primaryColor;
    final secondaryColor = widget.secondaryColor ?? primaryColor.withOpacity(0.3);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // Outer rotating ring
              AnimatedBuilder(
                animation: _rotationController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotationController.value * 2 * math.pi,
                    child: Container(
                      width: widget.size,
                      height: widget.size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: SweepGradient(
                          colors: [
                            primaryColor.withOpacity(0.0),
                            primaryColor.withOpacity(0.5),
                            primaryColor.withOpacity(0.0),
                          ],
                          stops: const [0.0, 0.5, 1.0],
                          transform: const GradientRotation(math.pi / 2),
                        ),
                      ),
                    ),
                  );
                },
              ),
              // Pulsing inner circle
              ScaleTransition(
                scale: _pulseAnimation,
                child: Container(
                  width: widget.size * 0.7,
                  height: widget.size * 0.7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        primaryColor.withOpacity(0.2),
                        secondaryColor.withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
              ),
              // Center dot with glow
              Container(
                width: widget.size * 0.15,
                height: widget.size * 0.15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (widget.showMessage) ...[
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.message ?? 'Loading',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                // Animated dots
                ...List.generate(3, (index) {
                  return FadeTransition(
                    opacity: _dotAnimations[index],
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Text(
                        '.',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

// Usage example: LoadingOverlay widget that can be used to show loading state
class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? loadingMessage;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.loadingMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.white.withOpacity(0.8),
            child: FancyLoadingIndicator(
              message: loadingMessage,
              primaryColor: Theme.of(context).primaryColor,
              size: 120,
            ),
          ),
      ],
    );
  }
}