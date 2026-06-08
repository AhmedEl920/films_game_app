import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:game_app/core/widget/custom_elevated_button.dart';

class LuckyCardWidget extends StatefulWidget {
  final String luckyCardText;
  final VoidCallback onClose;

  const LuckyCardWidget({
    Key? key,
    required this.luckyCardText,
    required this.onClose,
  }) : super(key: key);

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
                  width: 250,
                  height: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/card2.png',
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
                  width: 250,
                  height: 350,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.amber, width: 3),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.luckyCardText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'لابد من تنفيذ الكارت',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 16),
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
