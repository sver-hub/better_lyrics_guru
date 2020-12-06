import 'package:flutter/material.dart';

@immutable
class CustomFlatButton extends StatelessWidget {
  const CustomFlatButton({
    Key key,
    @required this.child,
    this.color,
    this.textColor,
    this.height = 50.0,
    this.borderRadius = 100.0,
    this.loading = false,
    this.onTap,
  }) : super(key: key);
  final Widget child;
  final Color color;
  final Color textColor;
  final double height;
  final double borderRadius;
  final bool loading;
  final VoidCallback onTap;

  Widget _buildSpinner(BuildContext context) {
    final ThemeData data = Theme.of(context);
    return Theme(
      data: data.copyWith(accentColor: Colors.white70),
      child: SizedBox(
        width: 28,
        height: 28,
        child: CircularProgressIndicator(
          strokeWidth: 3.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        child: Container(
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: color,
          ),
          child: Center(
            child: loading ? _buildSpinner(context) : child,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
