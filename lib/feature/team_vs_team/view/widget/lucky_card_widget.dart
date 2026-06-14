import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_app/core/constant/app_color.dart';
import 'package:game_app/core/constant/app_image.dart';
import 'package:game_app/core/widget/custom_elevated_button.dart';

class LuckyCardWidget extends StatefulWidget {
  final String luckyCardText;
  final VoidCallback onClose;

  const LuckyCardWidget({
    super.key,
    required this.luckyCardText,
    required this.onClose,
  });

  @override
  State<LuckyCardWidget> createState() => _LuckyCardWidgetState();
}

class _LuckyCardWidgetState extends State<LuckyCardWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  final GlobalKey<FlipCardState> _cardKey = GlobalKey<FlipCardState>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _close() {
    _controller.reverse().then((_) {
      widget.onClose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.6),
      child: SlideTransition(
        position: _offsetAnimation,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FlipCard(
                key: _cardKey,
                front: Container(
                  width: 250.w,
                  height: 350.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                     AppImage.cardImage2,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.amber,
                        child: const Center(
                          child: Icon(Icons.star, color: Colors.white, size: 100),
                        ),
                      ),
                    ),
                  ),
                ),
                back: Container(
                  width: 250.w,
                  height: 350.h,
                  decoration: BoxDecoration(
                    color:  AppColors.accent.withOpacity(
                                            0.9,
                                          ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.black, width: 3),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.luckyCardText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black,fontFamily: 'Amiri'),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'لابد من تنفيذ الكارت',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white,fontFamily: 'Amiri'),
              ),
              const SizedBox(height: 8),
              CustomElevatedButton(
                text: 'إلغاء',
                backgroundColor: Colors.red,
                onPressed: _close,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
