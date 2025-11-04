// lib/pages/checkout/checkout_payment_method_page.dart
import 'package:flutter/material.dart';
import 'checkout_stepper.dart';
import 'checkout_shipping_address_page.dart';

enum PaymentMethod { creditCard, bankTransfer, virtualAccount }

class CheckoutPaymentMethodPage extends StatefulWidget {
  const CheckoutPaymentMethodPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPaymentMethodPage> createState() =>
      _CheckoutPaymentMethodPageState();
}

class _CheckoutPaymentMethodPageState extends State<CheckoutPaymentMethodPage> {
  PaymentMethod? _selected = PaymentMethod.creditCard;

  // controllers for credit card fields
  final TextEditingController _nameCtrl = TextEditingController(text: 'Samuel Witwicky');
  final TextEditingController _cardNumberCtrl =
      TextEditingController(text: '1234 5678 9101 1121');
  final TextEditingController _monthYearCtrl = TextEditingController();
  final TextEditingController _cvvCtrl = TextEditingController();
  final TextEditingController _countryCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _cardNumberCtrl.dispose();
    _monthYearCtrl.dispose();
    _cvvCtrl.dispose();
    _countryCtrl.dispose();
    super.dispose();
  }

  void _onNext() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const CheckoutShippingAddressPage(),
      ),
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
            elevation: 4,
          ),
          onPressed: _onNext,
          child: Row(
            children: [
              const SizedBox(width: 12),
              const Text(
                'NEXT',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
              ),
              const Spacer(),
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                child: const Icon(Icons.play_arrow, size: 22),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _textField(String label, TextEditingController ctrl, {String? hint}) {
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
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _creditCardExpanded() {
    // horizontal sliding mock cards (visual only)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 160,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                width: 300,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6F2E8B), Color(0xFFB96FA9)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Credit Card', style: TextStyle(color: Colors.white)),
                    const Spacer(),
                    Text(
                      _cardNumberCtrl.text,
                      style: const TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 2),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('04 / 25', style: TextStyle(color: Colors.white.withOpacity(0.8))),
                        Text(_nameCtrl.text.toUpperCase(),
                            style: TextStyle(color: Colors.white.withOpacity(0.9))),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: 260,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Credit Card', style: TextStyle(color: Colors.white)),
                    const Spacer(),
                    const Text('1234 **** **** ****',
                        style: TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 2)),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('04 / 25', style: TextStyle(color: Colors.white70)),
                        Text('KEVIN HARD', style: TextStyle(color: Colors.white70)),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _textField('Card Holder Name', _nameCtrl),
        _textField('Card Number', _cardNumberCtrl),
        Row(
          children: [
            Expanded(child: _textField('Month/Year', _monthYearCtrl, hint: 'Enter here')),
            const SizedBox(width: 12),
            Expanded(child: _textField('CVV', _cvvCtrl, hint: 'Enter here')),
          ],
        ),
        _textField('Country', _countryCtrl, hint: 'Choose your country'),
      ],
    );
  }

  Widget _bankTransferExpanded() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        _textField('Card Holder Name', _nameCtrl),
        _textField('Card Number', _cardNumberCtrl),
        Row(
          children: [
            Expanded(child: _textField('Month/Year', _monthYearCtrl, hint: 'Enter here')),
            const SizedBox(width: 12),
            Expanded(child: _textField('CVV', _cvvCtrl, hint: 'Enter here')),
          ],
        ),
        _textField('Country', _countryCtrl, hint: 'Choose your country'),
      ],
    );
  }

  Widget _virtualAccountExpanded() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        _textField('Card Holder Name', _nameCtrl),
        _textField('Card Number', _cardNumberCtrl),
        _textField('Month/Year', _monthYearCtrl, hint: 'Enter here'),
        _textField('CVV', _cvvCtrl, hint: 'Enter here'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(140),
          child: CheckoutStepper(step: 1, onBack: () => Navigator.of(context).maybePop())),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Payment options
                    Row(
                      children: [
                        Radio<PaymentMethod>(
                          value: PaymentMethod.creditCard,
                          groupValue: _selected,
                          onChanged: (v) => setState(() => _selected = v),
                          activeColor: const Color(0xFF523946),
                        ),
                        const SizedBox(width: 8),
                        const Text('Credit Card', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                      ],
                    ),
                    if (_selected == PaymentMethod.creditCard) _creditCardExpanded(),

                    Row(
                      children: [
                        Radio<PaymentMethod>(
                          value: PaymentMethod.bankTransfer,
                          groupValue: _selected,
                          onChanged: (v) => setState(() => _selected = v),
                          activeColor: const Color(0xFF523946),
                        ),
                        const SizedBox(width: 8),
                        const Text('Bank Transfer', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                      ],
                    ),
                    if (_selected == PaymentMethod.bankTransfer) _bankTransferExpanded(),

                    Row(
                      children: [
                        Radio<PaymentMethod>(
                          value: PaymentMethod.virtualAccount,
                          groupValue: _selected,
                          onChanged: (v) => setState(() => _selected = v),
                          activeColor: const Color(0xFF523946),
                        ),
                        const SizedBox(width: 8),
                        const Text('Virtual Account', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                      ],
                    ),
                    if (_selected == PaymentMethod.virtualAccount) _virtualAccountExpanded(),

                    const SizedBox(height: 20),
                    // Total Payment display
                    Row(
                      children: [
                        Text('Total Payment', style: TextStyle(color: Colors.grey.shade500)),
                        const Spacer(),
                        const Text('\$158.0', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
                      ],
                    ),
                    const SizedBox(height: 36),
                  ],
                ),
              ),
            ),

            // NEXT button
            _roundedNextButton(),
          ],
        ),
      ),
    );
  }
}
