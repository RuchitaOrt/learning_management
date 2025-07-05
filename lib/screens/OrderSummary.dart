import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';

import '../widgets/CustomDropdown.dart';

/*class OrderSummaryScreen extends StatefulWidget {
  static const String route = "/order-summary-screen";
  const OrderSummaryScreen({super.key});

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  String? _selectedPaymentMethod;
  final TextEditingController _couponController = TextEditingController();
  final TextEditingController _upiIdController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvcController = TextEditingController();
  final TextEditingController _cardNameController = TextEditingController();
  bool _saveCard = false;
  String? _selectedBank;
  String? _selectedWallet;

  @override
  Widget build(BuildContext context) {
    final paymentProvider = Provider.of<PaymentProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: LearningColors.white,
        title: Text(
          'Order Summary',
          style: LMSStyles.tsblackTileBold,
        ),
        centerTitle: true,
        backgroundColor: LearningColors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: LearningColors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => PaymentProvider(),
        child: Container(
          decoration: AppDecorations.gradientBackground,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: SingleChildScrollView(
            child: Consumer<PaymentProvider>(
              builder: (context, paymentProvider, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Course Info Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: LearningColors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Naval Operations Course',
                            style: LMSStyles.tsblackTileBold2,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Centre for Maritime Education and Training (CMET)',
                            style: LMSStyles.tsHeading.copyWith(
                              color: LearningColors.neutral500,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 16,
                                color: LearningColors.neutral400,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '6 weeks • 42 hours',
                                style: LMSStyles.tsHeading,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Payment Methods Section (NEWLY ADDED)
                    Text(
                      'Payment Method',
                      style: LMSStyles.tsSubHeadingBold,
                    ),
                    const SizedBox(height: 16),
                    Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: LearningColors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _buildPaymentMethod(
                              icon: Icons.account_balance_wallet,
                              title: 'UPI',
                              subtitle: 'Pay using any UPI app',
                              value: 'upi',
                              context: context,
                            ),
                            const Divider(height: 24),
                            _buildPaymentMethod(
                              icon: Icons.credit_card,
                              title: 'Debit/Credit Card',
                              subtitle: 'Pay using Visa, Mastercard, etc.',
                              value: 'card',
                              context: context,
                            ),
                            const Divider(height: 24),
                            _buildPaymentMethod(
                              icon: Icons.account_balance,
                              title: 'Net Banking',
                              subtitle: 'Direct bank transfer',
                              value: 'netbanking',
                              context: context,
                            ),
                            const Divider(height: 24),
                            _buildPaymentMethod(
                              icon: Icons.wallet,
                              title: 'Wallet',
                              subtitle: 'Paytm, PhonePe, etc.',
                              value: 'wallet',
                              context: context,
                            ),
                          ],
                        )
                    ),
                    const SizedBox(height: 24),

                    Text(
                      'Coupon Code',
                      style: LMSStyles.tsSubHeadingBold,
                    ),
                    const SizedBox(height: 16),

                    // Coupon Code Section
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: LearningColors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _couponController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter coupon code',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: LearningColors.neutral300,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_couponController.text.isNotEmpty) {
                                      paymentProvider.applyCoupon(
                                        _couponController.text,
                                        0.2,
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: LearningColors.darkBlue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text('Apply'),
                                ),
                              ),
                            ],
                          ),
                          if (paymentProvider.appliedCoupon != null) ...[
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.check_circle,
                                    color: LearningColors.secondary550, size: 16),
                                const SizedBox(width: 8),
                                Text(
                                  'Coupon ${paymentProvider.appliedCoupon} applied '
                                      '(${(paymentProvider.couponDiscount * 100).toInt()}% discount)',
                                  style: LMSStyles.tsHeading.copyWith(
                                    color: LearningColors.secondary550,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    paymentProvider.removeCoupon();
                                    _couponController.clear();
                                  },
                                  child: Text(
                                    'Remove',
                                    style: LMSStyles.tsHeading.copyWith(
                                      color: LearningColors.darkBlue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Order Summary Section
                    Text(
                      'Order Summary',
                      style: LMSStyles.tsSubHeadingBold,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: LearningColors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildPriceRow(
                            'Original Price',
                            'INR 8000',
                            isDiscounted: true,
                          ),
                          const SizedBox(height: 12),
                          if (paymentProvider.appliedCoupon != null)
                            _buildPriceRow(
                              'Coupon Discount (${(paymentProvider.couponDiscount * 100).toInt()}%)',
                              '-INR ${(8000 * paymentProvider.couponDiscount).toInt()}',
                              isDiscount: true,
                            ),
                          if (paymentProvider.appliedCoupon != null)
                            const SizedBox(height: 12),
                          _buildPriceRow(
                            'Total Amount',
                            'INR ${8000 - (8000 * paymentProvider.couponDiscount).toInt()}',
                            isTotal: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Pay Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: LearningColors.darkBlue,
                          padding: EdgeInsets.symmetric(vertical: 14), // internal padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                        child: Text(
                          'Pay INR 7200',
                          style: LMSStyles.tsWhiteNeutral50W600162,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Money Back Guarantee
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: LearningColors.secondary100.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: LearningColors.secondary550.withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.verified_user_outlined,
                            color: LearningColors.secondary550,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '30-Day Money-Back Guarantee',
                                  style: LMSStyles.tsSubHeading.copyWith(
                                    color: LearningColors.secondary800,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Not satisfied? Get a full refund within 30 days. Simple and straightforward!',
                                  style: LMSStyles.tsHeading.copyWith(
                                    color: LearningColors.neutral500,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethod({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
    required BuildContext context,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _selectedPaymentMethod = value;
            });
          },
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: LearningColors.lightBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: LearningColors.darkBlue,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: LMSStyles.tsHeadingbold,
                    ),
                    Text(
                      subtitle,
                      style: LMSStyles.tsHeading.copyWith(
                        color: LearningColors.neutral500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Radio<String>(
                value: value,
                groupValue: _selectedPaymentMethod,
                onChanged: (String? value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                },
                activeColor: LearningColors.darkBlue,
              ),
            ],
          ),
        ),
        if (_selectedPaymentMethod == value) ...[
          const SizedBox(height: 16),
          // UPI Details
          if (value == 'upi')
            Column(
              children: [
                TextField(
                  controller: _upiIdController,
                  decoration: InputDecoration(
                    hintText: 'Enter your UPI ID / VPA',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: LearningColors.neutral300,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: LearningColors.darkBlue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Proceed to Pay', style: LMSStyles.tsWhiteNeutral50W600162,),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter your UPI ID / VPA and click "Proceed" to initiate the transaction.',
                  style: LMSStyles.tsHeading.copyWith(
                    color: LearningColors.neutral500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),

          // Card Details
          if (value == 'card')
            Column(
              children: [
                TextField(
                  controller: _cardNumberController,
                  decoration: InputDecoration(
                    hintText: '1234 5678 9012 3456',
                    prefixIcon: const Icon(Icons.credit_card),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/visa.png', width: 24),
                        const SizedBox(width: 8),
                        Image.asset('assets/mastercard.png', width: 24),
                        const SizedBox(width: 8),
                        Image.asset('assets/amex.png', width: 24),
                        const SizedBox(width: 8),
                        Image.asset('assets/rupay.png', width: 24),
                      ],
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _expiryController,
                        decoration: InputDecoration(
                          hintText: 'MM/YY',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        keyboardType: TextInputType.datetime,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: _cvcController,
                        decoration: InputDecoration(
                          hintText: 'CVC',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _cardNameController,
                  decoration: InputDecoration(
                    hintText: 'Name on card',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: _saveCard,
                      onChanged: (value) {
                        setState(() {
                          _saveCard = value ?? false;
                        });
                      },
                      activeColor: LearningColors.darkBlue,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Securely save this card for my later purchase',
                      style: LMSStyles.tsHeading.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),

          // Net Banking
          if (value == 'netbanking')
            Column(
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedBank,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  hint: const Text('Select your bank'),
                  items: [
                    'State Bank of India',
                    'HDFC Bank',
                    'ICICI Bank',
                    'Axis Bank',
                    'Kotak Mahindra Bank',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedBank = value;
                    });
                  },
                ),
              ],
            ),

          // Wallet
          if (value == 'wallet')
            Column(
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedWallet,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  hint: const Text('Select your wallet'),
                  items: [
                    'Paytm',
                    'PhonePe',
                    'Google Pay',
                    'Amazon Pay',
                    'MobiKwik',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedWallet = value;
                    });
                  },
                ),
              ],
            ),
          const SizedBox(height: 16),
        ],
      ],
    );
  }

  Widget _buildPriceRow(String label, String value, {
    bool isDiscounted = false,
    bool isDiscount = false,
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? LMSStyles.tsblackTileBold2
              : isDiscount
              ? LMSStyles.tsHeadingbold.copyWith(
            color: LearningColors.secondary550,
          )
              : LMSStyles.tsHeadingbold,
        ),
        Text(
          value,
          style: isTotal
              ? LMSStyles.tsblackTileBold2
              : isDiscounted
              ? LMSStyles.tsHeadingbold.copyWith(
            color: LearningColors.neutral300,
            decoration: TextDecoration.lineThrough,
          )
              : LMSStyles.tsHeadingbold.copyWith(
            color: LearningColors.secondary550,
          ),
        ),
      ],
    );
  }
}*/



class OrderSummaryScreen extends StatefulWidget {
  static const String route = "/order-summary-screen";
  const OrderSummaryScreen({super.key});

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  String? _selectedPaymentMethod; // Track selected payment method
  final TextEditingController _upiIdController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvcController = TextEditingController();
  final TextEditingController _cardNameController = TextEditingController();
  final TextEditingController _couponController = TextEditingController();
  String? _appliedCoupon;
  double _couponDiscount = 0;
  bool _saveCard = false;
  String? _selectedBank;
  String? _selectedWallet;

  void _applyCoupon() {
    if (_couponController.text.isNotEmpty) {
      setState(() {
        _appliedCoupon = _couponController.text;
        // Example: 20% discount
        _couponDiscount = 0.2;
      });
    }
  }

  void _removeCoupon() {
    setState(() {
      _appliedCoupon = null;
      _couponDiscount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: LearningColors.white,
        title: Text(
          'Order Summary',
          style: LMSStyles.tsblackTileBold,
        ),
        centerTitle: true,
        backgroundColor: LearningColors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: LearningColors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: AppDecorations.gradientBackground,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Course Info Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: LearningColors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Naval Operations Course',
                      style: LMSStyles.tsblackTileBold2,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Centre for Maritime Education and Training (CMET)',
                      style: LMSStyles.tsHeading.copyWith(
                        fontSize: 14,
                        color: LearningColors.neutral500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: LearningColors.neutral400,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '6 weeks • 42 hours',
                          style: LMSStyles.tsHeading,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Payment Methods Section (NEWLY ADDED)
              Text(
                'Payment Method',
                style: LMSStyles.tsSubHeadingBold,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: LearningColors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildPaymentMethod(
                      icon: Icons.account_balance_wallet,
                      title: 'UPI',
                      subtitle: 'Pay using any UPI app',
                      value: 'upi',
                      context: context,
                    ),
                    const Divider(height: 24),
                    _buildPaymentMethod(
                      icon: Icons.credit_card,
                      title: 'Debit/Credit Card',
                      subtitle: 'Pay using Visa, Mastercard, etc.',
                      value: 'card',
                      context: context,
                    ),
                    const Divider(height: 24),
                    _buildPaymentMethod(
                      icon: Icons.account_balance,
                      title: 'Net Banking',
                      subtitle: 'Direct bank transfer',
                      value: 'netbanking',
                      context: context,
                    ),
                    const Divider(height: 24),
                    _buildPaymentMethod(
                      icon: Icons.wallet,
                      title: 'Wallet',
                      subtitle: 'Paytm, PhonePe, etc.',
                      value: 'wallet',
                      context: context,
                    ),
                  ],
                )
              ),
              const SizedBox(height: 24),

              Text(
                'Coupon Code',
                style: LMSStyles.tsSubHeadingBold,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: LearningColors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Theme(
                             data: Theme.of(context).copyWith(
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: LearningColors.darkBlue, // blinking cursor
                selectionColor: Colors.blue.withOpacity(0.3), // text highlight
                selectionHandleColor: LearningColors.darkBlue, // balloon/handle color
              ),
            ),
                            child: TextField(cursorColor: LearningColors.darkBlue,
                              controller: _couponController,
                              decoration: InputDecoration(
                                hintText: 'Enter coupon code',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: LearningColors.neutral300,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _applyCoupon,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: LearningColors.darkBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Apply', style: LMSStyles.tsWhiteNeutral50W600162,),
                          ),
                        ),
                      ],
                    ),
                    if (_appliedCoupon != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: LearningColors.secondary550, size: 16),
                          const SizedBox(width: 8),
                          Text(
                            'Coupon $_appliedCoupon applied (${(_couponDiscount * 100).toInt()}% discount)',
                            style: LMSStyles.tsHeading.copyWith(
                              color: LearningColors.secondary550,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: _removeCoupon,
                            child: Text(
                              'Remove',
                              style: LMSStyles.tsHeading.copyWith(
                                color: LearningColors.darkBlue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Order Summary',
                style: LMSStyles.tsSubHeadingBold,
              ),
              const SizedBox(height: 16),

              // Price Details
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: LearningColors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildPriceRow(
                      'Original Price',
                      'INR 8000',
                      isDiscounted: true,
                    ),
                    const SizedBox(height: 12),
                    if (_appliedCoupon != null)
                      _buildPriceRow(
                        'Coupon Discount (${(_couponDiscount * 100).toInt()}%)',
                        '-INR ${(8000 * _couponDiscount).toInt()}',
                        isDiscount: true,
                      ),
                    if (_appliedCoupon != null)
                      const SizedBox(height: 12),
                    _buildPriceRow(
                      'Total Amount',
                      'INR ${8000 - (8000 * _couponDiscount).toInt()}',
                      isTotal: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Terms and Conditions
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: LMSStyles.tsHeading.copyWith(
                    color: LearningColors.neutral500,
                    fontSize: 12,
                  ),
                  children: [
                    const TextSpan(text: 'By completing your purchase, you agree to our '),
                    TextSpan(
                      text: 'Terms of Use',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {},
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // TODO: Handle Privacy Policy tap
                        },
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Pay Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LearningColors.darkBlue,
                    padding: EdgeInsets.symmetric(vertical: 14), // internal padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                    'Pay INR 7200',
                    style: LMSStyles.tsWhiteNeutral50W600162,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Money Back Guarantee
              SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: LearningColors.secondary100.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: LearningColors.secondary550.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.verified_user_outlined,
                        color: LearningColors.secondary550,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '30-Day Money-Back Guarantee',
                              style: LMSStyles.tsSubHeading.copyWith(
                                color: LearningColors.secondary800,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Not satisfied? Get a full refund within 30 days. Simple and straightforward!',
                              style: LMSStyles.tsHeading.copyWith(
                                color: LearningColors.neutral500,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethod({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
    required BuildContext context,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _selectedPaymentMethod = value;
            });
          },
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: LearningColors.lightBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: LearningColors.darkBlue,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: LMSStyles.tsHeadingbold.copyWith(fontSize: 16),
                    ),
                    Text(
                      subtitle,
                      style: LMSStyles.tsHeading.copyWith(
                        color: LearningColors.neutral500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Radio<String>(
                value: value,
                groupValue: _selectedPaymentMethod,
                onChanged: (String? value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                },
                activeColor: LearningColors.darkBlue,
              ),
            ],
          ),
        ),
        if (_selectedPaymentMethod == value) ...[
          const SizedBox(height: 16),
          // UPI Details
          if (value == 'upi')
            Column(
              children: [
                Theme(
                   data: Theme.of(context).copyWith(
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: LearningColors.darkBlue, // blinking cursor
                selectionColor: Colors.blue.withOpacity(0.3), // text highlight
                selectionHandleColor: LearningColors.darkBlue, // balloon/handle color
              ),
            ),
                  child: TextField(
                    cursorColor: LearningColors.darkBlue,
                    controller: _upiIdController,
                    decoration: InputDecoration(
                      hintText: 'Enter your UPI ID / VPA',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: LearningColors.neutral300,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: LearningColors.darkBlue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Proceed to Pay', style: LMSStyles.tsWhiteNeutral50W600162,),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter your UPI ID / VPA and click "Proceed" to initiate the transaction.',
                  style: LMSStyles.tsHeading.copyWith(
                    color: LearningColors.neutral500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),

          // Card Details
          if (value == 'card')
            Column(
              children: [
                Theme(
                   data: Theme.of(context).copyWith(
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: LearningColors.darkBlue, // blinking cursor
                selectionColor: Colors.blue.withOpacity(0.3), // text highlight
                selectionHandleColor: LearningColors.darkBlue, // balloon/handle color
              ),
            ),
                  child: TextField(
                    cursorColor: LearningColors.darkBlue,
                    controller: _cardNumberController,
                    decoration: InputDecoration(
                      hintText: '1234 5678 9012 3456',
                      prefixIcon: const Icon(Icons.credit_card),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Visa_Inc._logo.svg/2560px-Visa_Inc._logo.svg.png',
                            width: 24,
                            height: 24,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 8),
                          Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/1280px-Mastercard-logo.svg.png',
                            width: 24,
                            height: 24,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 8),
                          Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/3/30/American_Express_logo.svg/1200px-American_Express_logo.svg.png',
                            width: 24,
                            height: 24,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 8),
                          Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/RuPay.svg/1200px-RuPay.svg.png',
                            width: 24,
                            height: 24,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: LearningColors.darkBlue, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: LearningColors.darkBlue, width: 1.0),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade200, width: 1.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Theme(
                         data: Theme.of(context).copyWith(
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: LearningColors.darkBlue, // blinking cursor
                selectionColor: Colors.blue.withOpacity(0.3), // text highlight
                selectionHandleColor: LearningColors.darkBlue, // balloon/handle color
              ),
            ),
                        child: TextField(
                          cursorColor: LearningColors.darkBlue,
                          controller: _expiryController,
                          decoration: InputDecoration(
                            hintText: 'MM/YY',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: LearningColors.darkBlue, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: LearningColors.darkBlue, width: 1.0),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade200, width: 1.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Theme(
                         data: Theme.of(context).copyWith(
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: LearningColors.darkBlue, // blinking cursor
                selectionColor: Colors.blue.withOpacity(0.3), // text highlight
                selectionHandleColor: LearningColors.darkBlue, // balloon/handle color
              ),
            ),
                        child: TextField(
                          cursorColor: LearningColors.darkBlue,
                          controller: _cvcController,
                          decoration: InputDecoration(
                            hintText: 'CVC',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: LearningColors.darkBlue, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: LearningColors.darkBlue, width: 1.0),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade200, width: 1.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          obscureText: true,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Theme(
                   data: Theme.of(context).copyWith(
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: LearningColors.darkBlue, // blinking cursor
                selectionColor: Colors.blue.withOpacity(0.3), // text highlight
                selectionHandleColor: LearningColors.darkBlue, // balloon/handle color
              ),
            ),
                  child: TextField(
                    cursorColor: LearningColors.darkBlue,
                    controller: _cardNameController,
                    decoration: InputDecoration(
                      hintText: 'Name on card',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: LearningColors.darkBlue, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: LearningColors.darkBlue, width: 1.0),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade200, width: 1.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: _saveCard,
                      onChanged: (value) {
                        setState(() {
                          _saveCard = value ?? false;
                        });
                      },
                      activeColor: LearningColors.darkBlue,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Securely save this card for my later purchase',
                      style: LMSStyles.tsHeading.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),

          // Net Banking
          if (value == 'netbanking')
            Column(
              children: [
                CustomDropdown<String>(
                  value: _selectedBank,
                  hintText: 'Select your bank',
                  items: const [
                    'State Bank of India',
                    'HDFC Bank',
                    'ICICI Bank',
                    'Axis Bank',
                    'Kotak Mahindra Bank',
                  ],
                  onChanged: (newValue) {
                    setState(() {
                      _selectedBank = newValue;
                    });
                  },
                  height: 50, // Slightly taller for form fields
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ],
            ),

// Wallet
          if (value == 'wallet')
            Column(
              children: [
                CustomDropdown<String>(
                  value: _selectedWallet,
                  hintText: 'Select your wallet',
                  items: const [
                    'Paytm',
                    'PhonePe',
                    'Google Pay',
                    'Amazon Pay',
                    'MobiKwik',
                  ],
                  onChanged: (newValue) {
                    setState(() {
                      _selectedWallet = newValue;
                    });
                  },
                  height: 50, // Slightly taller for form fields
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ],
            ),
          const SizedBox(height: 16),
        ],
      ],
    );
  }

  // EXISTING METHOD - UNCHANGED
  Widget _buildPriceRow(String label, String value, {
    bool isDiscounted = false,
    bool isDiscount = false,
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? LMSStyles.tsblackTileBold2
              : isDiscount
              ? LMSStyles.tsHeadingbold.copyWith(
            color: LearningColors.secondary550,
          )
              : LMSStyles.tsHeadingbold,
        ),
        Text(
          value,
          style: isTotal
              ? LMSStyles.tsblackTileBold2
              : isDiscounted
              ? LMSStyles.tsHeadingbold.copyWith(
            color: LearningColors.neutral300,
            decoration: TextDecoration.lineThrough,
          )
              : LMSStyles.tsHeadingbold.copyWith(
            color: LearningColors.secondary550,
          ),
        ),
      ],
    );
  }
}
