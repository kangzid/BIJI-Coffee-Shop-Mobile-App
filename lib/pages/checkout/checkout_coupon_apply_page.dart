// lib/pages/checkout/checkout_coupon_apply_page.dart
import 'package:flutter/material.dart';
import 'checkout_stepper.dart';

class CheckoutCouponApplyPage extends StatefulWidget {
  const CheckoutCouponApplyPage({Key? key}) : super(key: key);

  @override
  State<CheckoutCouponApplyPage> createState() => _CheckoutCouponApplyPageState();
}

class _CheckoutCouponApplyPageState extends State<CheckoutCouponApplyPage> {
  final TextEditingController couponCtrl =
      TextEditingController(text: '#54856913215');

  void _onNext() {
    // End of flow — in your real app you might go to payment confirmation.
    // For now we just pop back to root.
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Widget _roundedNextButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF523946),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
          ),
          onPressed: _onNext,
          child: Row(
            children: [
              const SizedBox(width: 12),
              const Text('NEXT', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
              const Spacer(),
              const Icon(Icons.play_arrow, size: 22),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    couponCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: CheckoutStepper(step: 2, onBack: () => Navigator.of(context).maybePop()),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text('Enter Coupon Code', style: TextStyle(color: Colors.grey.shade600)),
                    const SizedBox(height: 12),
                    TextField(
                      controller: couponCtrl,
                      decoration: InputDecoration(
                        hintText: '#54856913215',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                    ),
                    const SizedBox(height: 300),
                  ],
                ),
              ),
            ),

            _roundedNextButton(),
          ],
        ),
      ),
    );
  }
}
