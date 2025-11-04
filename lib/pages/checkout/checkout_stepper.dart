// lib/pages/checkout/checkout_stepper.dart
import 'package:flutter/material.dart';

class CheckoutStepper extends StatelessWidget implements PreferredSizeWidget {
  final int step; // 0: Payment, 1: Shipping, 2: Coupon
  final VoidCallback? onBack;

  const CheckoutStepper({Key? key, required this.step, this.onBack})
      : super(key: key);

  static const _labels = ['Shipping Address', 'Payment Method', 'Coupon Apply'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      bottom: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // App bar row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Row(
              children: [
                InkWell(
                  onTap: onBack ?? () => Navigator.of(context).maybePop(),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back, size: 26),
                  ),
                ),
                const Spacer(),
                const Text(
                  'Checkout',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                )
              ],
            ),
          ),

          // Labels row (faded except current)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              children: List.generate(_labels.length, (index) {
                final active = index == step;
                return Expanded(
                  child: Center(
                    child: Text(
                      _labels[index],
                      style: TextStyle(
                        fontWeight: active ? FontWeight.w800 : FontWeight.w500,
                        color: active ? Colors.black87 : Colors.grey.shade400,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 12),
          // line + circle in center (step indicator)
          SizedBox(
            height: 36,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // base line
                Positioned.fill(
                  top: 18,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Divider(
                      thickness: 2,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
                // half-colored overlay showing progress (we simply darken center)
                Positioned.fill(
                  top: 18,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Align(
                      alignment: Alignment( (step - 1) * 0.0, 0), // not used but kept
                      child: FractionallySizedBox(
                        widthFactor: 0.34,
                        child: Divider(
                          thickness: 3,
                          color: const Color(0xFF523946),
                        ),
                      ),
                    ),
                  ),
                ),

                // center circle
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: const Color(0xFF523946),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(140);
}
