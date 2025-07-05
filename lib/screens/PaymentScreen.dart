import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';

class CourseEnrollmentScreen extends StatefulWidget {
  static const String route = '/course-enrollment';
  const CourseEnrollmentScreen({super.key});

  @override
  State<CourseEnrollmentScreen> createState() => _CourseEnrollmentScreenState();
}

class _CourseEnrollmentScreenState extends State<CourseEnrollmentScreen> {
  String selectedPayment = 'UPI';
  String upiSubOption = 'QR';
  String? selectedBank;
  String? selectedWallet;
  bool saveCard = false;

  TextEditingController upiController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController nameOnCardController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Enrollment', style: LMSStyles.tsblackTileBold),
        centerTitle: true,
        backgroundColor: LearningColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: LearningColors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Billing address', style: LMSStyles.tsSubHeadingBold),
            const SizedBox(height: 12),
            _buildInfoItem('Country', 'India'),
            _buildInfoItem('State / Union Territory', 'Maharashtra'),
            const Divider(height: 32, thickness: 1),

            Text('Payment method', style: LMSStyles.tsSubHeadingBold),
            const SizedBox(height: 16),

            _buildRadioTile('UPI'),
            if (selectedPayment == 'UPI') _buildUPIOptions(),

            _buildRadioTile('Cards'),
            if (selectedPayment == 'Cards') _buildCardOptions(),

            _buildRadioTile('Net Banking'),
            if (selectedPayment == 'Net Banking') _buildNetBankingOptions(),

            _buildRadioTile('Mobile Wallet'),
            if (selectedPayment == 'Mobile Wallet') _buildWalletOptions(),

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle payment submission
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: LearningColors.primaryBlue500,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Pay', style: LMSStyles.tsWhiteNeutral50W600162.copyWith(fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• $label', style: LMSStyles.tsblackNeutralbold),
          const SizedBox(width: 8),
          Expanded(child: Text(value, style: LMSStyles.tsSubHeading)),
        ],
      ),
    );
  }

  Widget _buildRadioTile(String title) {
    return RadioListTile(
      activeColor: LearningColors.primaryBlue500,
      title: Text(title, style: LMSStyles.tsSubHeading),
      value: title,
      groupValue: selectedPayment,
      onChanged: (value) {
        setState(() {
          selectedPayment = value.toString();
        });
      },
    );
  }

  Widget _buildUPIOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ChoiceChip(
              label: Text('QR Code'),
              selected: upiSubOption == 'QR',
              onSelected: (val) => setState(() => upiSubOption = 'QR'),
            ),
            const SizedBox(width: 12),
            ChoiceChip(
              label: Text('Enter UPI ID'),
              selected: upiSubOption == 'UPI',
              onSelected: (val) => setState(() => upiSubOption = 'UPI'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (upiSubOption == 'UPI') _buildTextField(upiController, 'Enter UPI ID / VPA'),
      ],
    );
  }

  Widget _buildCardOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(cardNumberController, 'Card Number'),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildTextField(expiryController, 'Expiry (MM/YY)')),
            const SizedBox(width: 12),
            Expanded(child: _buildTextField(cvvController, 'CVV')),
          ],
        ),
        const SizedBox(height: 12),
        _buildTextField(nameOnCardController, 'Name on Card'),
        const SizedBox(height: 12),
        CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: LearningColors.primaryBlue500,
          value: saveCard,
          onChanged: (val) => setState(() => saveCard = val ?? false),
          title: Text('Securely save this card for my later purchase', style: LMSStyles.tsHeading),
        ),
      ],
    );
  }

  Widget _buildNetBankingOptions() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        labelText: 'Select Bank',
      ),
      value: selectedBank,
      onChanged: (value) => setState(() => selectedBank = value),
      items: ['HDFC Bank', 'SBI Bank', 'ICICI Bank'].map((bank) {
        return DropdownMenuItem(value: bank, child: Text(bank));
      }).toList(),
    );
  }

  Widget _buildWalletOptions() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        labelText: 'Select Wallet',
      ),
      value: selectedWallet,
      onChanged: (value) => setState(() => selectedWallet = value),
      items: ['Airtel Money', 'Amazon Pay'].map((wallet) {
        return DropdownMenuItem(value: wallet, child: Text(wallet));
      }).toList(),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return Theme(
       data: Theme.of(context).copyWith(
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: LearningColors.darkBlue, // blinking cursor
                selectionColor: Colors.blue.withOpacity(0.3), // text highlight
                selectionHandleColor: LearningColors.darkBlue, // balloon/handle color
              ),
            ),
      child: TextFormField(
        cursorColor: LearningColors.darkBlue,
        controller: controller,
        decoration: InputDecoration(
          labelText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
