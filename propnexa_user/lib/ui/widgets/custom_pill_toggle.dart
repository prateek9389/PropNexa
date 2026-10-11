import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class CustomPillToggle extends StatefulWidget {
  final String leftLabel;
  final String rightLabel;
  final Function(int) onToggle;

  const CustomPillToggle({
    super.key,
    required this.leftLabel,
    required this.rightLabel,
    required this.onToggle,
  });

  @override
  State<CustomPillToggle> createState() => _CustomPillToggleState();
}

class _CustomPillToggleState extends State<CustomPillToggle> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() => _selectedIndex = 0);
                widget.onToggle(0);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedIndex == 0 ? AppColors.primaryBlue : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    widget.leftLabel,
                    style: TextStyle(
                      color: _selectedIndex == 0 ? Colors.white : AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() => _selectedIndex = 1);
                widget.onToggle(1);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedIndex == 1 ? AppColors.primaryBlue : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    widget.rightLabel,
                    style: TextStyle(
                      color: _selectedIndex == 1 ? Colors.white : AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
