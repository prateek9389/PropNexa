import 'package:flutter/material.dart';
import 'property_post_wizard_screen.dart';

class SellPropertyForm extends StatelessWidget {
  const SellPropertyForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const PropertyPostWizardScreen(mode: PropertyPostMode.sell);
  }
}
