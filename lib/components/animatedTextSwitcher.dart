import 'package:flutter/material.dart';

class AnimatedTextSwitcher extends StatefulWidget {
  final Widget child;
  final AnimationController controller;
  AnimatedTextSwitcher({required this.child, required this.controller});

  @override
  State<AnimatedTextSwitcher> createState() => _AnimatedTextSwitcherState();
}

class _AnimatedTextSwitcherState extends State<AnimatedTextSwitcher> {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _controller.reset();
    _controller.forward(); // Trigger the initial animation
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: widget.controller,
            curve: Curves.easeInOut,
          )),
          child: FadeTransition(
            opacity: widget.controller,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
