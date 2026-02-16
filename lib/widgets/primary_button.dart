import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final double width;
  final double height;
  final String? maskAsset;
  final bool showArrow;
  final Color backgroundColor;
  final double borderRadius;

  const PrimaryButton({
    Key? key,
    required this.label,
    this.onTap,
    this.width = 153,
    this.height = 72,
    this.maskAsset,
    this.showArrow = true,
    this.backgroundColor = const Color(0xFF5B67F6),
    this.borderRadius = 28,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          // Base
          Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: [
                BoxShadow(
                  color: backgroundColor.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
          ),

          // Optional mask image overlay
          if (maskAsset != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: Image.asset(
                maskAsset!,
                width: width,
                height: height,
                fit: BoxFit.cover,
              ),
            ),

          // Content
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(borderRadius),
              onTap: onTap,
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    if (showArrow) ...[
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 20,
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
