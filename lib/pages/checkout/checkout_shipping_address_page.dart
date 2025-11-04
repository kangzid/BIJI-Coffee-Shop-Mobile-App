// lib/pages/checkout/checkout_shipping_address_page.dart
import 'package:flutter/material.dart';
import 'checkout_stepper.dart';
import 'checkout_coupon_apply_page.dart';

class CheckoutShippingAddressPage extends StatefulWidget {
  const CheckoutShippingAddressPage({Key? key}) : super(key: key);

  @override
  State<CheckoutShippingAddressPage> createState() =>
      _CheckoutShippingAddressPageState();
}

class _CheckoutShippingAddressPageState extends State<CheckoutShippingAddressPage> {
  final TextEditingController nameCtrl =
      TextEditingController(text: 'Samuel Witwicky');
  final TextEditingController zipCtrl = TextEditingController();
  final TextEditingController countryCtrl = TextEditingController();
  final TextEditingController stateCtrl = TextEditingController();
  final TextEditingController cityCtrl = TextEditingController();
  bool saveAddress = false;

  @override
  void dispose() {
    nameCtrl.dispose();
    zipCtrl.dispose();
    countryCtrl.dispose();
    stateCtrl.dispose();
    cityCtrl.dispose();
    super.dispose();
  }

  void _onNext() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const CheckoutCouponApplyPage()),
    );
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

  Widget _labelledField(String label, TextEditingController ctrl, {String? hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey.shade500)),
        const SizedBox(height: 8),
        TextField(
          controller: ctrl,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: CheckoutStepper(step: 0, onBack: () => Navigator.of(context).maybePop()),
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
                    _labelledField('Card Holder Name', nameCtrl),
                    _labelledField('Zip/postal Code', zipCtrl),
                    _labelledField('Country', countryCtrl, hint: 'Choose your country'),
                    _labelledField('State', stateCtrl, hint: 'Enter here'),
                    _labelledField('City', cityCtrl, hint: 'Enter here'),

                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Checkbox(
                          value: saveAddress,
                          onChanged: (v) => setState(() => saveAddress = v ?? false),
                        ),
                        const SizedBox(width: 8),
                        const Text('Save shipping address', style: TextStyle(fontWeight: FontWeight.w700)),
                      ],
                    ),

                    const SizedBox(height: 120),
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
