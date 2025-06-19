import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:learning_mgt/Utils/learning_colors.dart';

class GraphCard extends StatefulWidget {
  const GraphCard({super.key});

  @override
  State<GraphCard> createState() => _GraphCardState();
}

class _GraphCardState extends State<GraphCard> {
  String selectedRange = 'This Month';

  final List<String> filterOptions = [
    'Today',
    'Yesterday',
    'Previous Week',
    'This Month',
    'Quarter',
    'Year',
    'Custom',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top row with dropdown aligned right
          Row(
            children: [
              const Text(
                "Performance\nOverview",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Container(
                height: 38,
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: LearningColors.darkBlue.withOpacity(0.2), width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedRange,
                    dropdownColor: Colors.white,
                    icon: const Icon(Icons.keyboard_arrow_down, color: LearningColors.darkBlue),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    items: filterOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedRange = newValue!;
                      });
                    },
                  ),
                ),
              ),

            ],
          ),

          const SizedBox(height: 25),

          /// Line Chart
          SizedBox(
            height: 280,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 5,
                minY: 0,
                maxY: 100,
                lineTouchData: LineTouchData(
  touchTooltipData: LineTouchTooltipData(
    // tooltipRoundedRadius: LearningColors.darkBlue, // Background of tooltip box
    getTooltipItems: (List<LineBarSpot> touchedSpots) {
      return touchedSpots.map((barSpot) {
        return LineTooltipItem(
          '${barSpot.y.toInt()}%', // The value displayed
          const TextStyle(
            color: Colors.white, // Text color inside tooltip
            fontWeight: FontWeight.bold,
          ),
        );
      }).toList();
    },
  ),
  handleBuiltInTouches: true,
),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 20,
                  verticalInterval: 1,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.white,
                    strokeWidth: 1,
                  ),
                  getDrawingVerticalLine: (value) => FlLine(
                    color: Colors.white,
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        const style = TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w600
                        );
                        switch (value.toInt()) {
                          case 0:
                            return Text('Mon', style: style);
                          case 1:
                            return Text('Tue', style: style);
                          case 2:
                            return Text('Wed', style: style);
                          case 3:
                            return Text('Thu', style: style);
                          case 4:
                            return Text('Fri', style: style);
                          case 5:
                            return Text('Sat', style: style);
                        }
                        return const Text('');
                      },
                      reservedSize: 30,
                    ),
                  ),
                  leftTitles: AxisTitles(
  sideTitles: SideTitles(
    showTitles: true,
    interval: 20,
    getTitlesWidget: (value, meta) {
      if (value == 0) return const SizedBox.shrink(); // 🧹 hide 0%
      return Text(
        '${value.toInt()}%',
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      );
    },
    reservedSize: 32,
  ),
),

                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 0),
                      FlSpot(1, 40),
                      FlSpot(2, 60),
                      FlSpot(3, 80),
                      FlSpot(4, 90),
                      FlSpot(5, 100),
                    ],
                    isCurved: true,
                    color: LearningColors.darkBlue,
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                        radius: 4,
                        color: Colors.white,
                        strokeWidth: 2,
                        strokeColor: LearningColors.darkBlue,
                      ),
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.shade200.withOpacity(0.4),
                          Colors.transparent,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
