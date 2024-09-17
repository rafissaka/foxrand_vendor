import 'package:flutter/material.dart';
import 'package:vendor/contants/colors.dart';



class CustomAnimatedTextFormField extends StatefulWidget {
  final String labelText;
  final IconData iconData;
  final String? Function(String?)? validator;
  final FocusNode focusNode;
  final TextEditingController controller;
  const CustomAnimatedTextFormField(
      {super.key,
      required this.labelText,
      required this.validator,
      required this.focusNode,
      required this.iconData,
      required this.controller});

  @override
  State<CustomAnimatedTextFormField> createState() =>
      _CustomAnimatedTextFormFieldState();
}

class _CustomAnimatedTextFormFieldState
    extends State<CustomAnimatedTextFormField> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.7).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    widget.focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _animationController.dispose();
    widget.focusNode.removeListener(_handleFocusChange);
    super.dispose();
  }

  void _handleFocusChange() {
    if (widget.focusNode.hasFocus) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final scale = _scaleAnimation.value;

        return Transform.scale(
          scale: scale,
          child: TextFormField(
            controller: widget.controller,
            validator: widget.validator,
            focusNode: widget.focusNode,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xffffe2db),
              labelText: widget.labelText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  color: AppColors.primaryColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2.0,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2.0,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2.0,
                ),
              ),
              prefixIcon: Icon(
                widget.iconData,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
