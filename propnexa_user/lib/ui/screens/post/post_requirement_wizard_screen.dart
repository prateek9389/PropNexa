import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routes/app_routes.dart';

class PostRequirementWizardScreen extends StatefulWidget {
  const PostRequirementWizardScreen({super.key});

  @override
  State<PostRequirementWizardScreen> createState() =>
      _PostRequirementWizardScreenState();
}

class _PostRequirementWizardScreenState
    extends State<PostRequirementWizardScreen> {
  int _currentStep = 1;
  final int _totalSteps = 5;

  // Step 1 State
  String _lookingFor = 'Rent'; // Buy, Rent, Lease
  String _propertyType = 'Apartment';

  // Step 2 State
  final List<String> _selectedLocations = [
    'Sector 62',
    'Sector 63',
    'Noida Extension',
  ];
  bool _searchNearby = true;
  final TextEditingController _locationSearchController =
      TextEditingController();

  // Step 3 State
  String _bhk = '2 BHK';
  String _furnishing = 'Semi Furnished';
  String _propertyAge = '1-5 Years';
  final Set<String> _additionalPreferences = {
    'Car Parking',
    'Power Backup',
    'Garden',
    'Near Metro',
  };

  // Step 4 State
  String _budgetType = 'Monthly Rent';
  RangeValues _budgetRange = const RangeValues(10000, 50000);
  String _moveInTimeline = 'Immediately';
  String _preferredTenure = '1 Year';
  final TextEditingController _notesController = TextEditingController(
    text:
        'Looking for a family-friendly society with good connectivity.',
  );

  // Step 5 State
  bool _aiMatchingEnabled = true;

  @override
  void dispose() {
    _locationSearchController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < _totalSteps) {
      setState(() => _currentStep++);
    } else {
      _showSuccessDialog();
    }
  }

  void _prevStep() {
    if (_currentStep > 1) {
      setState(() => _currentStep--);
    } else {
      Navigator.of(context).pop();
    }
  }

  String _getStepSubtitle() {
    switch (_currentStep) {
      case 1:
        return "Let us know what you're looking for";
      case 2:
        return 'Where do you want to live or invest?';
      case 3:
        return 'Tell us your property preferences';
      case 4:
        return 'Set your budget and timeline';
      case 5:
        return 'Review your details before posting';
      default:
        return "Let us know what you're looking for";
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF2563EB);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
          onPressed: _prevStep,
        ),
        title: Column(
          children: [
            const Text(
              'Post Requirement',
              style: TextStyle(
                color: Color(0xFF0F172A),
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Text(
                _getStepSubtitle(),
                style: const TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 10.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // 5-Step Progress Indicator Bar
          _buildStepProgressBar(primaryBlue),

          // Scrollable Body Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Column(
                children: [
                  _buildCurrentStepContent(primaryBlue),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Bottom Action Bar
          _buildBottomActionBar(primaryBlue),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // STEP PROGRESS BAR
  // ---------------------------------------------------------------------------
  Widget _buildStepProgressBar(Color primaryBlue) {
    final stepLabels = [
      'Basic Details',
      'Location',
      'Preferences',
      'Budget',
      'Review & Post',
    ];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_totalSteps, (index) {
          final stepNum = index + 1;
          final isCompleted = _currentStep > stepNum;
          final isActive = _currentStep == stepNum;

          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isCompleted || isActive
                              ? primaryBlue
                              : const Color(0xFFF1F5F9),
                          border: Border.all(
                            color: isCompleted || isActive
                                ? primaryBlue
                                : const Color(0xFFCBD5E1),
                            width: 1.5,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: isCompleted
                            ? const Icon(Icons.check,
                                size: 16, color: Colors.white)
                            : Text(
                                '$stepNum',
                                style: TextStyle(
                                  color: isActive
                                      ? Colors.white
                                      : const Color(0xFF64748B),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        stepLabels[index],
                        style: TextStyle(
                          fontSize: 8.5,
                          fontWeight:
                              isActive ? FontWeight.w800 : FontWeight.w500,
                          color: isActive
                              ? const Color(0xFF0F172A)
                              : const Color(0xFF94A3B8),
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (index < _totalSteps - 1)
                  Container(
                    width: 14,
                    height: 2,
                    margin: const EdgeInsets.only(bottom: 14),
                    color: _currentStep > stepNum
                        ? primaryBlue
                        : const Color(0xFFE2E8F0),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // STEP ROUTING
  // ---------------------------------------------------------------------------
  Widget _buildCurrentStepContent(Color primaryBlue) {
    switch (_currentStep) {
      case 1:
        return _buildStep1BasicDetails(primaryBlue);
      case 2:
        return _buildStep2Location(primaryBlue);
      case 3:
        return _buildStep3Preferences(primaryBlue);
      case 4:
        return _buildStep4Budget(primaryBlue);
      case 5:
        return _buildStep5Review(primaryBlue);
      default:
        return _buildStep1BasicDetails(primaryBlue);
    }
  }

  // ---------------------------------------------------------------------------
  // STEP 1: BASIC DETAILS
  // ---------------------------------------------------------------------------
  Widget _buildStep1BasicDetails(Color primaryBlue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hero Graphic Banner
        Container(
          width: double.infinity,
          height: 125,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFE0EFFF), Color(0xFFCBE3FD)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFBFDBFE)),
          ),
          child: Stack(
            children: [
              // House graphic background on right
              Positioned(
                right: 0,
                bottom: 0,
                top: 0,
                width: 140,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    'assets/images/post_req_card.jpg',
                    fit: BoxFit.cover,
                    alignment: Alignment.centerLeft,
                    errorBuilder: (_, _, _) => Container(
                      color: const Color(0xFFDBEAFE),
                      child: const Icon(Icons.home_work,
                          color: Color(0xFF2563EB), size: 40),
                    ),
                  ),
                ),
              ),
              // Floating speech bubble on left
              Positioned(
                left: 14,
                top: 14,
                bottom: 14,
                width: 190,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2563EB),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2563EB).withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Tell us your requirements and we\'ll find the best matching properties for you',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      height: 1.35,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        // Section: "I am looking for"
        const Text(
          'I am looking for',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 10),

        Row(
          children: [
            _buildLookingForCard(
              title: 'Buy',
              subtitle: 'I want to buy\na property',
              icon: Icons.home_outlined,
              isSelected: _lookingFor == 'Buy',
              onTap: () => setState(() => _lookingFor = 'Buy'),
              primaryBlue: primaryBlue,
            ),
            const SizedBox(width: 10),
            _buildLookingForCard(
              title: 'Rent',
              subtitle: 'I want to rent\na property',
              icon: Icons.key_rounded,
              isSelected: _lookingFor == 'Rent',
              onTap: () => setState(() => _lookingFor = 'Rent'),
              primaryBlue: primaryBlue,
            ),
            const SizedBox(width: 10),
            _buildLookingForCard(
              title: 'Lease',
              subtitle: 'I want to lease\na property',
              icon: Icons.description_outlined,
              isSelected: _lookingFor == 'Lease',
              onTap: () => setState(() => _lookingFor = 'Lease'),
              primaryBlue: primaryBlue,
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Section: "Property Type"
        const Text(
          'Property Type',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 10),

        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.15,
          children: [
            _buildPropertyTypeTile('Apartment', Icons.apartment_rounded,
                _propertyType == 'Apartment', primaryBlue),
            _buildPropertyTypeTile('House', Icons.home_rounded,
                _propertyType == 'House', primaryBlue),
            _buildPropertyTypeTile('Villa', Icons.holiday_village_rounded,
                _propertyType == 'Villa', primaryBlue),
            _buildPropertyTypeTile('Plot', Icons.landscape_rounded,
                _propertyType == 'Plot', primaryBlue),
            _buildPropertyTypeTile('Independent House', Icons.cottage_rounded,
                _propertyType == 'Independent House', primaryBlue),
            _buildPropertyTypeTile('Commercial', Icons.storefront_rounded,
                _propertyType == 'Commercial', primaryBlue),
            _buildPropertyTypeTile('PG/Co-Living', Icons.groups_rounded,
                _propertyType == 'PG/Co-Living', primaryBlue),
            _buildPropertyTypeTile('Office Space', Icons.business_center_rounded,
                _propertyType == 'Office Space', primaryBlue),
            _buildPropertyTypeTile('Any', Icons.grid_view_rounded,
                _propertyType == 'Any', primaryBlue),
          ],
        ),

        const SizedBox(height: 16),

        // AI Tip Capsule
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBEB),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFFDE68A)),
          ),
          child: Row(
            children: [
              const Text('💡', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              Expanded(
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 11.5, color: Color(0xFF92400E)),
                    children: [
                      TextSpan(
                        text: 'Not sure? ',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      TextSpan(
                        text: 'Our AI will help you find the right options.',
                      ),
                    ],
                  ),
                ),
              ),
              const Icon(Icons.chevron_right_rounded,
                  color: Color(0xFFD97706), size: 18),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLookingForCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
    required Color primaryBlue,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          height: 120,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFEFF6FF) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? primaryBlue : const Color(0xFFE2E8F0),
              width: isSelected ? 1.5 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              if (isSelected)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: primaryBlue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check,
                        size: 11, color: Colors.white),
                  ),
                ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon,
                      size: 26,
                      color:
                          isSelected ? primaryBlue : const Color(0xFF0F172A)),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color:
                          isSelected ? primaryBlue : const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 9,
                      color: Color(0xFF64748B),
                      height: 1.25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPropertyTypeTile(
      String title, IconData icon, bool isSelected, Color primaryBlue) {
    return GestureDetector(
      onTap: () => setState(() => _propertyType = title),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEFF6FF) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? primaryBlue : const Color(0xFFE2E8F0),
            width: isSelected ? 1.5 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: Stack(
          children: [
            if (isSelected)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: primaryBlue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check,
                      size: 10, color: Colors.white),
                ),
              ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 24,
                    color:
                        isSelected ? primaryBlue : const Color(0xFF0F172A),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight:
                          isSelected ? FontWeight.w800 : FontWeight.w600,
                      color:
                          isSelected ? primaryBlue : const Color(0xFF334155),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // STEP 2: LOCATION
  // ---------------------------------------------------------------------------
  Widget _buildStep2Location(Color primaryBlue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section: Search Location Card
        _buildCardWrapper(
          icon: Icons.person_pin_circle_rounded,
          title: 'Search Location',
          subtitle: '',
          primaryBlue: primaryBlue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search input
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: TextField(
                  controller: _locationSearchController,
                  style: const TextStyle(
                      fontSize: 12.5, fontWeight: FontWeight.w600),
                  decoration: const InputDecoration(
                    hintText: 'Search city, locality, or landmark...',
                    hintStyle: TextStyle(
                        fontSize: 12, color: Color(0xFF94A3B8)),
                    prefixIcon: Icon(Icons.search_rounded,
                        color: Color(0xFF64748B), size: 20),
                    suffixIcon: Icon(Icons.my_location_rounded,
                        color: Color(0xFF64748B), size: 18),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Current Location Bar
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Color(0xFFEFF6FF),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.location_on_rounded,
                          color: primaryBlue, size: 18),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Current Location',
                            style: TextStyle(
                              fontSize: 9.5,
                              color: Color(0xFF64748B),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Noida, Uttar Pradesh',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                        ],
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        side: BorderSide(color: primaryBlue),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Use Current',
                        style: TextStyle(
                          color: primaryBlue,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Section: Popular Areas
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Popular Areas',
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0F172A),
              ),
            ),
            Text(
              'See All',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: primaryBlue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        Row(
          children: [
            _buildPopularAreaCard(
              title: 'Sector 62',
              propertiesCount: '1.2K properties',
              imagePath: 'assets/images/home_header_bg.jpg',
            ),
            const SizedBox(width: 8),
            _buildPopularAreaCard(
              title: 'Sector 63',
              propertiesCount: '980 properties',
              imagePath: 'assets/images/city_skyline.jpg',
            ),
            const SizedBox(width: 8),
            _buildPopularAreaCard(
              title: 'Greater Noida',
              propertiesCount: '1.5K properties',
              imagePath: 'assets/images/onboarding_1.jpg',
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Section: Selected Locations Chips
        const Text(
          'Selected Locations',
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 8),

        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ..._selectedLocations.map((loc) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        loc,
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF334155),
                        ),
                      ),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () {
                          setState(() => _selectedLocations.remove(loc));
                        },
                        child: const Icon(Icons.close_rounded,
                            size: 14, color: Color(0xFF64748B)),
                      ),
                    ],
                  ),
                )),
            GestureDetector(
              onTap: () {
                setState(() => _selectedLocations.add('Indirapuram'));
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: primaryBlue.withValues(alpha: 0.4)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, size: 14, color: primaryBlue),
                    const SizedBox(width: 4),
                    Text(
                      'Add More',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: primaryBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        // Interactive Mini Map Container
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFE5F3FF),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFCBD5E1)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Map vector lines illustration
              CustomPaint(
                size: const Size(double.infinity, 150),
                painter: _MiniMapPainter(),
              ),

              // Radius ring and Center Pin
              Center(
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: primaryBlue.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: primaryBlue.withValues(alpha: 0.4),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_on_rounded,
                          color: primaryBlue, size: 16),
                      const SizedBox(width: 4),
                      const Text(
                        'Sector 62\nNoida',
                        style: TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // GPS reticle icon at bottom right
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.my_location_rounded,
                      size: 16, color: Color(0xFF0F172A)),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Search in nearby areas toggle
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Color(0xFFEFF6FF),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.radar_rounded,
                    color: primaryBlue, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Search in nearby areas',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      'We\'ll also show properties in surrounding areas.',
                      style: TextStyle(
                        fontSize: 9.5,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: _searchNearby,
                activeThumbColor: primaryBlue,
                onChanged: (val) => setState(() => _searchNearby = val),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPopularAreaCard({
    required String title,
    required String propertiesCount,
    required String imagePath,
  }) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              height: 55,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                height: 55,
                color: const Color(0xFFEFF6FF),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    propertiesCount,
                    style: const TextStyle(
                      fontSize: 8.5,
                      color: Color(0xFF64748B),
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

  // ---------------------------------------------------------------------------
  // STEP 3: PREFERENCES
  // ---------------------------------------------------------------------------
  Widget _buildStep3Preferences(Color primaryBlue) {
    final amenitiesList = [
      {'title': 'Car Parking', 'icon': Icons.directions_car_rounded},
      {'title': 'Lift', 'icon': Icons.elevator_rounded},
      {'title': 'Power Backup', 'icon': Icons.bolt_rounded},
      {'title': 'Security', 'icon': Icons.shield_outlined},
      {'title': 'Gym', 'icon': Icons.fitness_center_rounded},
      {'title': 'Swimming Pool', 'icon': Icons.pool_rounded},
      {'title': 'Club House', 'icon': Icons.holiday_village_rounded},
      {'title': 'Garden', 'icon': Icons.park_rounded},
      {'title': 'Near Metro', 'icon': Icons.subway_rounded},
      {'title': 'Pet Friendly', 'icon': Icons.pets_rounded},
      {'title': 'Gated Society', 'icon': Icons.door_front_door_rounded},
      {'title': 'Furnished Kitchen', 'icon': Icons.kitchen_rounded},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Property Details Card
        _buildCardWrapper(
          icon: Icons.home_work_rounded,
          title: 'Property Details',
          subtitle: '',
          primaryBlue: primaryBlue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BHK
              const Text(
                'BHK',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF334155),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildPillButton('1 BHK', _bhk == '1 BHK', primaryBlue,
                      () => setState(() => _bhk = '1 BHK')),
                  const SizedBox(width: 6),
                  _buildPillButton('2 BHK', _bhk == '2 BHK', primaryBlue,
                      () => setState(() => _bhk = '2 BHK')),
                  const SizedBox(width: 6),
                  _buildPillButton('3 BHK', _bhk == '3 BHK', primaryBlue,
                      () => setState(() => _bhk = '3 BHK')),
                  const SizedBox(width: 6),
                  _buildPillButton('4 BHK', _bhk == '4 BHK', primaryBlue,
                      () => setState(() => _bhk = '4 BHK')),
                  const SizedBox(width: 6),
                  _buildPillButton('Any', _bhk == 'Any', primaryBlue,
                      () => setState(() => _bhk = 'Any')),
                ],
              ),

              const SizedBox(height: 16),

              // Furnishing
              const Text(
                'Furnishing',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF334155),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildFurnishingTile('Furnished', Icons.chair_rounded,
                      _furnishing == 'Furnished', primaryBlue, () {
                    setState(() => _furnishing = 'Furnished');
                  }),
                  const SizedBox(width: 8),
                  _buildFurnishingTile('Semi Furnished', Icons.bed_rounded,
                      _furnishing == 'Semi Furnished', primaryBlue, () {
                    setState(() => _furnishing = 'Semi Furnished');
                  }),
                  const SizedBox(width: 8),
                  _buildFurnishingTile('Unfurnished', Icons.weekend_rounded,
                      _furnishing == 'Unfurnished', primaryBlue, () {
                    setState(() => _furnishing = 'Unfurnished');
                  }),
                  const SizedBox(width: 8),
                  _buildFurnishingTile('Any', Icons.more_horiz_rounded,
                      _furnishing == 'Any', primaryBlue, () {
                    setState(() => _furnishing = 'Any');
                  }),
                ],
              ),

              const SizedBox(height: 16),

              // Property Age
              const Text(
                'Property Age',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF334155),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildPillButton('New', _propertyAge == 'New', primaryBlue,
                      () => setState(() => _propertyAge = 'New')),
                  const SizedBox(width: 6),
                  _buildPillButton(
                      '1-5 Years', _propertyAge == '1-5 Years', primaryBlue,
                      () => setState(() => _propertyAge = '1-5 Years')),
                  const SizedBox(width: 6),
                  _buildPillButton(
                      '5-10 Years', _propertyAge == '5-10 Years', primaryBlue,
                      () => setState(() => _propertyAge = '5-10 Years')),
                  const SizedBox(width: 6),
                  _buildPillButton(
                      '10+ Years', _propertyAge == '10+ Years', primaryBlue,
                      () => setState(() => _propertyAge = '10+ Years')),
                  const SizedBox(width: 6),
                  _buildPillButton('Any', _propertyAge == 'Any', primaryBlue,
                      () => setState(() => _propertyAge = 'Any')),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Additional Preferences Card
        _buildCardWrapper(
          icon: Icons.calendar_month_rounded,
          title: 'Additional Preferences',
          subtitle: 'Select the features that matter to you',
          primaryBlue: primaryBlue,
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: amenitiesList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.15,
            ),
            itemBuilder: (context, index) {
              final item = amenitiesList[index];
              final title = item['title'] as String;
              final icon = item['icon'] as IconData;
              final isSelected = _additionalPreferences.contains(title);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _additionalPreferences.remove(title);
                    } else {
                      _additionalPreferences.add(title);
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFEFF6FF) : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected
                          ? primaryBlue
                          : const Color(0xFFE2E8F0),
                      width: isSelected ? 1.5 : 1.0,
                    ),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Stack(
                    children: [
                      if (isSelected)
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: primaryBlue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.check,
                                size: 10, color: Colors.white),
                          ),
                        ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(icon,
                                size: 22,
                                color: isSelected
                                    ? primaryBlue
                                    : const Color(0xFF64748B)),
                            const SizedBox(height: 4),
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 9.5,
                                fontWeight: isSelected
                                    ? FontWeight.w800
                                    : FontWeight.w600,
                                color: isSelected
                                    ? primaryBlue
                                    : const Color(0xFF475569),
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPillButton(
      String label, bool isSelected, Color primaryBlue, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? primaryBlue : const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? primaryBlue : const Color(0xFFE2E8F0),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
              color: isSelected ? Colors.white : const Color(0xFF475569),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFurnishingTile(String label, IconData icon, bool isSelected,
      Color primaryBlue, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFEFF6FF) : const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? primaryBlue : const Color(0xFFE2E8F0),
              width: isSelected ? 1.5 : 1.0,
            ),
          ),
          padding: const EdgeInsets.all(4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 20,
                  color: isSelected ? primaryBlue : const Color(0xFF64748B)),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 8.5,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                  color: isSelected ? primaryBlue : const Color(0xFF475569),
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // STEP 4: BUDGET & TIMELINE
  // ---------------------------------------------------------------------------
  Widget _buildStep4Budget(Color primaryBlue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section: Budget Range Card
        _buildCardWrapper(
          icon: Icons.currency_rupee_rounded,
          title: 'Budget Range',
          subtitle: 'Tell us your expected price range',
          primaryBlue: primaryBlue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Budget Tabs
              Row(
                children: [
                  _buildBudgetTab('Monthly Rent', _budgetType == 'Monthly Rent',
                      primaryBlue, () => setState(() => _budgetType = 'Monthly Rent')),
                  const SizedBox(width: 8),
                  _buildBudgetTab('Total Budget (Buy)',
                      _budgetType == 'Total Budget (Buy)', primaryBlue, () {
                    setState(() => _budgetType = 'Total Budget (Buy)');
                  }),
                  const SizedBox(width: 8),
                  _buildBudgetTab('Any', _budgetType == 'Any', primaryBlue,
                      () => setState(() => _budgetType = 'Any')),
                ],
              ),

              const SizedBox(height: 20),

              // Price Bubbles
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: primaryBlue.withValues(alpha: 0.4)),
                    ),
                    child: Text(
                      '₹${_budgetRange.start.toInt()}',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800,
                        color: primaryBlue,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: primaryBlue.withValues(alpha: 0.4)),
                    ),
                    child: Text(
                      '₹${_budgetRange.end.toInt()}',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800,
                        color: primaryBlue,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Range Slider
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: primaryBlue,
                  inactiveTrackColor: const Color(0xFFE2E8F0),
                  thumbColor: primaryBlue,
                  overlayColor: primaryBlue.withValues(alpha: 0.2),
                  trackHeight: 6,
                ),
                child: RangeSlider(
                  values: _budgetRange,
                  min: 0,
                  max: 100000,
                  divisions: 20,
                  onChanged: (values) => setState(() => _budgetRange = values),
                ),
              ),

              // Scale ticks below slider
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('0', style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
                    Text('10K', style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
                    Text('25K', style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
                    Text('50K', style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
                    Text('1L+', style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Section: Move-in Timeline
        _buildCardWrapper(
          icon: Icons.calendar_today_rounded,
          title: 'Move-in Timeline',
          subtitle: 'When do you plan to move?',
          primaryBlue: primaryBlue,
          child: Column(
            children: [
              Row(
                children: [
                  _buildTimelineButton('Immediately',
                      _moveInTimeline == 'Immediately', primaryBlue, () {
                    setState(() => _moveInTimeline = 'Immediately');
                  }),
                  const SizedBox(width: 8),
                  _buildTimelineButton('Within 1 Month',
                      _moveInTimeline == 'Within 1 Month', primaryBlue, () {
                    setState(() => _moveInTimeline = 'Within 1 Month');
                  }),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildTimelineButton('Within 3 Months',
                      _moveInTimeline == 'Within 3 Months', primaryBlue, () {
                    setState(() => _moveInTimeline = 'Within 3 Months');
                  }),
                  const SizedBox(width: 8),
                  _buildTimelineButton('Flexible',
                      _moveInTimeline == 'Flexible', primaryBlue, () {
                    setState(() => _moveInTimeline = 'Flexible');
                  }),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Section: Preferred Tenure (for Rent)
        _buildCardWrapper(
          icon: Icons.assignment_rounded,
          title: 'Preferred Tenure (for Rent)',
          subtitle: '',
          primaryBlue: primaryBlue,
          child: Row(
            children: [
              _buildTenureButton('6 Months', _preferredTenure == '6 Months',
                  primaryBlue, () => setState(() => _preferredTenure = '6 Months')),
              const SizedBox(width: 8),
              _buildTenureButton('1 Year', _preferredTenure == '1 Year',
                  primaryBlue, () => setState(() => _preferredTenure = '1 Year')),
              const SizedBox(width: 8),
              _buildTenureButton('2 Years', _preferredTenure == '2 Years',
                  primaryBlue, () => setState(() => _preferredTenure = '2 Years')),
              const SizedBox(width: 8),
              _buildTenureButton('Long Term', _preferredTenure == 'Long Term',
                  primaryBlue, () => setState(() => _preferredTenure = 'Long Term')),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Section: Other Requirements (Optional)
        _buildCardWrapper(
          icon: Icons.description_rounded,
          title: 'Other Requirements (Optional)',
          subtitle: 'Any specific needs or notes?',
          primaryBlue: primaryBlue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: TextField(
                  controller: _notesController,
                  maxLines: 4,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600),
                  decoration: const InputDecoration(
                    hintText:
                        'e.g. need a family-friendly property, close to metro, allow pets, with balcony, etc.',
                    hintStyle: TextStyle(
                        fontSize: 11.5, color: Color(0xFF94A3B8)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                '0/500',
                style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBudgetTab(
      String label, bool isSelected, Color primaryBlue, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? primaryBlue : const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? primaryBlue : const Color(0xFFE2E8F0),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
              color: isSelected ? Colors.white : const Color(0xFF475569),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineButton(
      String label, bool isSelected, Color primaryBlue, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? primaryBlue : const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? primaryBlue : const Color(0xFFE2E8F0),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
              color: isSelected ? Colors.white : const Color(0xFF475569),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTenureButton(
      String label, bool isSelected, Color primaryBlue, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? primaryBlue : const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? primaryBlue : const Color(0xFFE2E8F0),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
              color: isSelected ? Colors.white : const Color(0xFF475569),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // STEP 5: REVIEW & POST
  // ---------------------------------------------------------------------------
  Widget _buildStep5Review(Color primaryBlue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // "Almost Done!" Mint Banner
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFECFDF5),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFA7F3D0)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Color(0xFF10B981),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 16, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Almost Done!',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF065F46),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Review your requirement and post it to get matched with verified owners and sellers.',
                      style: TextStyle(
                        fontSize: 10.5,
                        color: Color(0xFF047857),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Requirement Summary Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Requirement Summary',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  InkWell(
                    onTap: () => setState(() => _currentStep = 1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.edit_outlined,
                              size: 13, color: primaryBlue),
                          const SizedBox(width: 4),
                          Text(
                            'Edit',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: primaryBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const Divider(height: 24, color: Color(0xFFF1F5F9)),

              _buildSummaryRow(
                  Icons.home_outlined, 'Looking For', _lookingFor),
              _buildSummaryRow(
                  Icons.apartment_rounded, 'Property Type', _propertyType),
              _buildSummaryRow(Icons.bed_rounded, 'BHK', _bhk),
              _buildSummaryRow(
                  Icons.chair_rounded, 'Furnishing', _furnishing),
              _buildSummaryRow(
                  Icons.timer_outlined, 'Property Age', _propertyAge),
              _buildSummaryRow(
                Icons.location_on_outlined,
                'Location',
                _selectedLocations.join(', '),
              ),
              _buildSummaryRow(
                Icons.currency_rupee_rounded,
                'Budget Range',
                '₹${_budgetRange.start.toInt()} - ₹${_budgetRange.end.toInt()} / month',
              ),
              _buildSummaryRow(
                  Icons.calendar_today_rounded,
                  'Move-in Timeline',
                  _moveInTimeline),
              _buildSummaryRow(
                  Icons.assignment_outlined,
                  'Preferred Tenure',
                  _preferredTenure),
              _buildSummaryRow(
                Icons.settings_outlined,
                'Key Preferences',
                _additionalPreferences.join(', '),
              ),
              _buildSummaryRow(
                Icons.notes_rounded,
                'Additional Notes',
                _notesController.text.isEmpty
                    ? 'None'
                    : _notesController.text,
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // AI Matching Enabled Card
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFF5F3FF), Color(0xFFEDE9FE)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFDDD6FE)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFF7C3AED),
                  shape: BoxShape.circle,
                ),
                child: const Text('🤖', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'AI Matching Enabled',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF4C1D95),
                      ),
                    ),
                    Text(
                      'We\'ll notify you when matching properties are available.',
                      style: TextStyle(
                        fontSize: 9.5,
                        color: Color(0xFF6D28D9),
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: _aiMatchingEnabled,
                activeThumbColor: const Color(0xFF7C3AED),
                onChanged: (val) => setState(() => _aiMatchingEnabled = val),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF64748B)),
          const SizedBox(width: 8),
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // CARD WRAPPER
  // ---------------------------------------------------------------------------
  Widget _buildCardWrapper({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget child,
    required Color primaryBlue,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1F5F9), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Icon(icon, color: primaryBlue, size: 20),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 10.5,
                        color: Color(0xFF64748B),
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // BOTTOM ACTION BAR
  // ---------------------------------------------------------------------------
  Widget _buildBottomActionBar(Color primaryBlue) {
    final nextLabels = [
      'Next: Location',
      'Next: Preferences',
      'Next: Budget',
      'Next: Review',
      'Post Requirement',
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          top: BorderSide(color: Color(0xFFF1F5F9), width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _currentStep == 1
                ? SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _nextStep,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            nextLabels[_currentStep - 1],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_rounded,
                              color: Colors.white, size: 18),
                        ],
                      ),
                    ),
                  )
                : Row(
                    children: [
                      OutlinedButton.icon(
                        onPressed: _prevStep,
                        icon: const Icon(Icons.arrow_back_rounded,
                            size: 16, color: Color(0xFF334155)),
                        label: const Text(
                          'Back',
                          style: TextStyle(
                            color: Color(0xFF334155),
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 13),
                          side: const BorderSide(color: Color(0xFFCBD5E1)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _nextStep,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _currentStep == 5
                                  ? const Color(0xFF2563EB)
                                  : primaryBlue,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (_currentStep == 5)
                                  const Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: Icon(Icons.send_rounded,
                                        color: Colors.white, size: 18),
                                  ),
                                Text(
                                  nextLabels[_currentStep - 1],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                if (_currentStep < 5) ...[
                                  const SizedBox(width: 8),
                                  const Icon(Icons.arrow_forward_rounded,
                                      color: Colors.white, size: 18),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            if (_currentStep == 5)
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  'Your requirement will be visible to verified property owners and sellers.',
                  style: TextStyle(
                    fontSize: 9.5,
                    color: Color(0xFF64748B),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SUCCESS DIALOG
  // ---------------------------------------------------------------------------
  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        contentPadding: const EdgeInsets.all(28),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: const Color(0xFF2563EB),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2563EB).withValues(alpha: 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(Icons.check_rounded,
                  size: 38, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              'Requirement Posted Successfully!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Color(0xFF0F172A),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'We will match you with genuine property owners and sellers that fit your exact preferences.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF64748B),
                fontSize: 12,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Requirement ID',
                        style: TextStyle(fontSize: 10, color: Color(0xFF64748B)),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'REQ-9042',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCFCE7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Matching Active',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF15803D),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.go(AppRoutes.mainNavigation);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Go to Home',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// MINI MAP PAINTER FOR STEP 2
// -----------------------------------------------------------------------------
class _MiniMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = const Color(0xFFBFDBFE)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final secondaryRoadPaint = Paint()
      ..color = const Color(0xFFDBEAFE)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Draw grid roads
    canvas.drawLine(
        Offset(0, size.height * 0.3), Offset(size.width, size.height * 0.3), roadPaint);
    canvas.drawLine(
        Offset(0, size.height * 0.7), Offset(size.width, size.height * 0.7), roadPaint);
    canvas.drawLine(
        Offset(size.width * 0.25, 0), Offset(size.width * 0.25, size.height), roadPaint);
    canvas.drawLine(
        Offset(size.width * 0.75, 0), Offset(size.width * 0.75, size.height), roadPaint);

    // Diagonal arterial roads
    canvas.drawLine(const Offset(0, 0), Offset(size.width, size.height), secondaryRoadPaint);
    canvas.drawLine(Offset(0, size.height), Offset(size.width, 0), secondaryRoadPaint);

    // Block outlines
    final blockPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(10, 10, size.width * 0.2, size.height * 0.25),
            const Radius.circular(4)),
        blockPaint);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(size.width * 0.78, 10, size.width * 0.18, size.height * 0.25),
            const Radius.circular(4)),
        blockPaint);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(10, size.height * 0.72, size.width * 0.2, size.height * 0.22),
            const Radius.circular(4)),
        blockPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
