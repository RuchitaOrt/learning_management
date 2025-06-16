import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';
import 'package:learning_mgt/Utils/lms_styles.dart';

class OrderSummaryScreen extends StatelessWidget {
  static const String route = "/order-summary-screen";
  const OrderSummaryScreen({super.key});

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

            // Order Summary Section
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
                  // Original Price
                  _buildPriceRow(
                    'Original Price',
                    'INR 8000',
                    isDiscounted: true,
                  ),
                  const SizedBox(height: 12),

                  // Discount
                  _buildPriceRow(
                    'Discount (30% off)',
                    '-INR 7200',
                    isDiscount: true,
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1),
                  const SizedBox(height: 12),

                  // Total
                  _buildPriceRow(
                    'Total Amount',
                    'INR 7200',
                    isTotal: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Terms and Conditions
            Text(
              'By completing your purchase, you agree to our Terms of Use and Privacy Policy.',
              style: LMSStyles.tsHeading.copyWith(
                color: LearningColors.neutral500,
                fontSize: 12,
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
        ),
      ),
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
}