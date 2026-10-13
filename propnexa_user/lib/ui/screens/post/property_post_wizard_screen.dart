import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routes/app_routes.dart';

enum PropertyPostMode { sell, rent }

class PropertyPostWizardScreen extends StatefulWidget {
  final PropertyPostMode mode;

  const PropertyPostWizardScreen({
    super.key,
    this.mode = PropertyPostMode.sell,
  });

  @override
  State<PropertyPostWizardScreen> createState() =>
      _PropertyPostWizardScreenState();
}

class _PropertyPostWizardScreenState extends State<PropertyPostWizardScreen> {
  int _currentStep = 1;
  final int _totalSteps = 5;

  bool get isSell => widget.mode == PropertyPostMode.sell;

  Color get themeColor =>
      isSell ? const Color(0xFFEF4444) : const Color(0xFF2563EB);

  Color get themeSoftColor =>
      isSell ? const Color(0xFFFEE2E2) : const Color(0xFFEFF6FF);

  Color get themeLightBorder =>
      isSell ? const Color(0xFFFFECEC) : const Color(0xFFE0E7FF);

  // Form Controllers & State
  late TextEditingController _titleController;
  late TextEditingController _priceController;
  late TextEditingController _depositController;
  late TextEditingController _areaController;
  late TextEditingController _descriptionController;

  String _propertyType = 'Apartment';
  String _bhk = '3 BHK';
  String _bathrooms = '2';
  String _parking = '1 Covered';
  bool _priceNegotiable = true;

  // Step 2 State
  String _propertyAge = '1 - 5 Years';
  String _totalFloors = '10 Floors';
  String _propertyFloor = '3rd Floor';
  String _facing = 'East';
  String _furnishing = 'Semi Furnished';
  String _condition = 'Good';
  String _availability = 'Immediately';
  String _minLease = '11 Months';

  // Step 3 State: Selected Amenities
  final Set<String> _selectedAmenities = {};
  final Set<String> _selectedFacilities = {};

  // Step 4 State: Photos
  final List<String> _photos = [
    'assets/images/home_header_bg.jpg',
    'assets/images/onboarding_1.jpg',
    'assets/images/onboarding_2.jpg',
    'assets/images/post_hero_banner.jpg',
  ];

  // Step 5 State
  bool _confirmedAccuracy = true;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: isSell
          ? 'Spacious 3 BHK Apartment in Sector 62'
          : 'Modern 2 BHK Flat for Rent in Sector 62',
    );
    _priceController = TextEditingController(
      text: isSell ? '75,00,000' : '25,000',
    );
    _depositController = TextEditingController(text: '50,000');
    _areaController = TextEditingController(text: isSell ? '1450' : '1100');
    _descriptionController = TextEditingController();

    if (!isSell) {
      _bhk = '2 BHK';
      _totalFloors = '12 Floors';
      _propertyFloor = '5th Floor';
      _facing = 'West';
      _furnishing = 'Furnished';
      _selectedAmenities.addAll(['Parking', 'Garden']);
      _selectedFacilities.add('School');
    } else {
      _selectedAmenities.addAll(['Power Backup', 'Swimming Pool']);
      _selectedFacilities.add('Hospital');
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _depositController.dispose();
    _areaController.dispose();
    _descriptionController.dispose();
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

  @override
  Widget build(BuildContext context) {
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
            Text(
              isSell ? 'Sell Property' : 'Rent Property',
              style: const TextStyle(
                color: Color(0xFF0F172A),
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            if (_currentStep == 1)
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(
                  isSell
                      ? 'List your property for sale and reach genuine buyers'
                      : 'List your property for rent and find trusted tenants',
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
          _buildStepProgressBar(),

          // Step Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Column(
                children: [
                  if (_currentStep == 1) _buildStep1PromoBanner(),
                  const SizedBox(height: 12),
                  _buildCurrentStepContent(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // Bottom Action Bar
          _buildBottomActionBar(),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // STEP PROGRESS BAR
  // ---------------------------------------------------------------------------
  Widget _buildStepProgressBar() {
    final stepLabels = [
      'Basic Details',
      'Property Details',
      'Amenities',
      'Photos & Video',
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
                              ? themeColor
                              : const Color(0xFFF1F5F9),
                          border: Border.all(
                            color: isCompleted || isActive
                                ? themeColor
                                : const Color(0xFFCBD5E1),
                            width: 1.5,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: isCompleted
                            ? const Icon(Icons.check, size: 16, color: Colors.white)
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
                        ? themeColor
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
  // STEP 1 PROMOTIONAL BANNER
  // ---------------------------------------------------------------------------
  Widget _buildStep1PromoBanner() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isSell
              ? const [Color(0xFFFFF1F2), Color(0xFFFFE4E6)]
              : const [Color(0xFFEFF6FF), Color(0xFFDBEAFE)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: themeLightBorder, width: 1.2),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          // Illustration / Photo
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              isSell
                  ? 'assets/images/post_sell_card.jpg'
                  : 'assets/images/home_header_bg.jpg',
              width: 90,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 90,
                height: 80,
                color: themeSoftColor,
                child: Icon(Icons.home, size: 36, color: themeColor),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Banner text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isSell ? Icons.local_offer : Icons.key_rounded,
                        size: 11,
                        color: themeColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isSell ? 'Sell Property' : 'Rent Property',
                        style: TextStyle(
                          color: themeColor,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  isSell
                      ? 'Get the best value for your property'
                      : 'Find the right tenants hassle-free',
                  style: const TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isSell
                      ? 'List your property and connect with verified buyers.'
                      : 'List your property for rent and get verified tenants quickly.',
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 10.5,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      width: 14,
                      height: 5,
                      decoration: BoxDecoration(
                        color: themeColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: themeColor.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: themeColor.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      isSell ? Icons.bar_chart_rounded : Icons.key_rounded,
                      color: themeColor,
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // STEP ROUTING
  // ---------------------------------------------------------------------------
  Widget _buildCurrentStepContent() {
    switch (_currentStep) {
      case 1:
        return _buildStep1Form();
      case 2:
        return _buildStep2Form();
      case 3:
        return _buildStep3Form();
      case 4:
        return _buildStep4Form();
      case 5:
        return _buildStep5Form();
      default:
        return _buildStep1Form();
    }
  }

  // ---------------------------------------------------------------------------
  // STEP 1: BASIC DETAILS
  // ---------------------------------------------------------------------------
  Widget _buildStep1Form() {
    return _buildCardWrapper(
      icon: Icons.home_rounded,
      title: 'Basic Details',
      subtitle: 'Provide the basic information about your property',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Title & Type
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 12,
                child: _buildFormField(
                  label: 'Property Title *',
                  child: _buildTextField(
                    controller: _titleController,
                    hint: isSell
                        ? 'e.g. Spacious 3 BHK Apartment in Sector 62'
                        : 'e.g. Modern 2 BHK Flat for Rent in Sector 62',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 9,
                child: _buildFormField(
                  label: 'Property Type *',
                  child: _buildDropdownField(
                    value: _propertyType,
                    items: const [
                      'Apartment',
                      'Villa',
                      'Independent House',
                      'Builder Floor',
                      'Penthouse'
                    ],
                    onChanged: (val) => setState(() => _propertyType = val!),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Row 2: Listing For & Price
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 9,
                child: _buildFormField(
                  label: 'Listing For',
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: themeSoftColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: themeColor, width: 1.2),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isSell ? 'Sell' : 'Rent',
                          style: TextStyle(
                            color: themeColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 13.5,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(Icons.check_circle_rounded,
                            color: themeColor, size: 16),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFormField(
                      label: isSell ? 'Expected Price *' : 'Monthly Rent *',
                      child: _buildTextField(
                        controller: _priceController,
                        hint: isSell ? 'Enter selling price' : 'Enter monthly rent',
                        prefixIcon: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            '₹',
                            style: TextStyle(
                              color: Color(0xFF0F172A),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (isSell)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                value: _priceNegotiable,
                                activeColor: themeColor,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                onChanged: (val) =>
                                    setState(() => _priceNegotiable = val ?? true),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'Price negotiable',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF475569),
                                fontWeight: FontWeight.w500,
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

          // If Rent: Row for Security Deposit & Furnishing
          if (!isSell) ...[
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _buildFormField(
                    label: 'Security Deposit',
                    child: _buildTextField(
                      controller: _depositController,
                      hint: 'Enter security deposit',
                      prefixIcon: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          '₹',
                          style: TextStyle(
                            color: Color(0xFF0F172A),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildFormField(
                    label: 'Furnishing *',
                    child: _buildDropdownField(
                      value: _furnishing,
                      items: const ['Furnished', 'Semi Furnished', 'Unfurnished'],
                      onChanged: (val) => setState(() => _furnishing = val!),
                    ),
                  ),
                ),
              ],
            ),
          ],

          const SizedBox(height: 14),

          // Row: BHK & Bathrooms
          Row(
            children: [
              Expanded(
                child: _buildFormField(
                  label: 'BHK *',
                  child: _buildDropdownField(
                    value: _bhk,
                    items: const [
                      '1 RK',
                      '1 BHK',
                      '2 BHK',
                      '3 BHK',
                      '4 BHK',
                      '5+ BHK'
                    ],
                    onChanged: (val) => setState(() => _bhk = val!),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildFormField(
                  label: 'Bathrooms *',
                  child: _buildDropdownField(
                    value: _bathrooms,
                    items: const ['1', '2', '3', '4', '5+'],
                    onChanged: (val) => setState(() => _bathrooms = val!),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Row: Super Built-up Area & Car Parking
          Row(
            children: [
              Expanded(
                child: _buildFormField(
                  label: 'Super Built-up Area (sq ft) *',
                  child: _buildTextField(
                    controller: _areaController,
                    hint: isSell ? 'e.g. 1450' : 'e.g. 1100',
                    prefixIcon: const Icon(
                      Icons.aspect_ratio_rounded,
                      size: 18,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildFormField(
                  label: 'Car Parking',
                  child: _buildDropdownField(
                    value: _parking,
                    items: const [
                      'None',
                      '1 Open',
                      '1 Covered',
                      '2 Covered',
                      '3+ Covered'
                    ],
                    onChanged: (val) => setState(() => _parking = val!),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Description
          _buildFormField(
            label: 'Description *',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildTextField(
                  controller: _descriptionController,
                  hint: isSell
                      ? 'Describe your property, its highlights, location advantages, and why someone should buy it...'
                      : 'Describe your property, nearby amenities, suitability for tenants, and any special features...',
                  maxLines: 4,
                ),
                const SizedBox(height: 4),
                const Text(
                  '0/1000',
                  style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // STEP 2: PROPERTY DETAILS
  // ---------------------------------------------------------------------------
  Widget _buildStep2Form() {
    return _buildCardWrapper(
      icon: Icons.home_work_rounded,
      title: 'Property Details',
      subtitle: 'Add more details about your property',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Property Age & Total Floors
          Row(
            children: [
              Expanded(
                child: _buildFormField(
                  label: 'Property Age',
                  child: _buildDropdownField(
                    value: _propertyAge,
                    items: const [
                      'Under Construction',
                      'Ready to Move',
                      '0 - 1 Years',
                      '1 - 5 Years',
                      '5 - 10 Years',
                      '10+ Years'
                    ],
                    onChanged: (val) => setState(() => _propertyAge = val!),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildFormField(
                  label: 'Total Floors in Building',
                  child: _buildDropdownField(
                    value: _totalFloors,
                    items: const [
                      '3 Floors',
                      '5 Floors',
                      '10 Floors',
                      '12 Floors',
                      '15 Floors',
                      '20+ Floors'
                    ],
                    onChanged: (val) => setState(() => _totalFloors = val!),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Row 2: Floor & Facing
          Row(
            children: [
              Expanded(
                child: _buildFormField(
                  label: 'Your Property is on Floor',
                  child: _buildDropdownField(
                    value: _propertyFloor,
                    items: const [
                      'Ground Floor',
                      '1st Floor',
                      '2nd Floor',
                      '3rd Floor',
                      '5th Floor',
                      'Top Floor'
                    ],
                    onChanged: (val) => setState(() => _propertyFloor = val!),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildFormField(
                  label: 'Facing',
                  child: _buildDropdownField(
                    value: _facing,
                    items: const [
                      'East',
                      'West',
                      'North',
                      'South',
                      'North-East',
                      'North-West'
                    ],
                    onChanged: (val) => setState(() => _facing = val!),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Furnishing Choice
          _buildFormField(
            label: 'Furnishing',
            child: Row(
              children: [
                _buildSegmentButton('Furnished', _furnishing == 'Furnished', () {
                  setState(() => _furnishing = 'Furnished');
                }),
                const SizedBox(width: 8),
                _buildSegmentButton(
                    'Semi Furnished', _furnishing == 'Semi Furnished', () {
                  setState(() => _furnishing = 'Semi Furnished');
                }),
                const SizedBox(width: 8),
                _buildSegmentButton(
                    'Unfurnished', _furnishing == 'Unfurnished', () {
                  setState(() => _furnishing = 'Unfurnished');
                }),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Specific to Sell vs Rent
          if (isSell) ...[
            _buildFormField(
              label: 'Property Condition *',
              child: Row(
                children: [
                  _buildSegmentButton('New', _condition == 'New', () {
                    setState(() => _condition = 'New');
                  }),
                  const SizedBox(width: 8),
                  _buildSegmentButton('Good', _condition == 'Good', () {
                    setState(() => _condition = 'Good');
                  }),
                  const SizedBox(width: 8),
                  _buildSegmentButton(
                      'Needs Renovation', _condition == 'Needs Renovation', () {
                    setState(() => _condition = 'Needs Renovation');
                  }),
                ],
              ),
            ),
          ] else ...[
            Row(
              children: [
                Expanded(
                  child: _buildFormField(
                    label: 'Availability *',
                    child: _buildDropdownField(
                      value: _availability,
                      items: const [
                        'Immediately',
                        'Within 15 Days',
                        'Within 30 Days',
                        'After 1 Month'
                      ],
                      onChanged: (val) => setState(() => _availability = val!),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildFormField(
                    label: 'Minimum Lease Duration',
                    child: _buildDropdownField(
                      value: _minLease,
                      items: const [
                        '6 Months',
                        '11 Months',
                        '1 Year',
                        '2 Years',
                        '3 Years'
                      ],
                      onChanged: (val) => setState(() => _minLease = val!),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // STEP 3: AMENITIES
  // ---------------------------------------------------------------------------
  Widget _buildStep3Form() {
    final commonAmenities = [
      {'title': 'Parking', 'icon': Icons.local_parking_rounded},
      {'title': 'Lift', 'icon': Icons.elevator_rounded},
      {'title': 'Power Backup', 'icon': Icons.bolt_rounded},
      {'title': 'Security', 'icon': Icons.shield_outlined},
      {'title': 'Gym', 'icon': Icons.fitness_center_rounded},
      {'title': 'Swimming Pool', 'icon': Icons.pool_rounded},
      {'title': 'Club House', 'icon': Icons.apartment_rounded},
      {'title': 'Garden', 'icon': Icons.park_rounded},
      {'title': 'Kids Play Area', 'icon': Icons.toys_rounded},
      {'title': 'Pet Friendly', 'icon': Icons.pets_rounded},
      {'title': 'CCTV', 'icon': Icons.videocam_outlined},
      {'title': 'Fire Safety', 'icon': Icons.local_fire_department_rounded},
    ];

    final nearbyFacilities = [
      {'title': 'School', 'icon': Icons.school_outlined},
      {'title': 'Hospital', 'icon': Icons.local_hospital_outlined},
      {'title': 'Metro Station', 'icon': Icons.subway_outlined},
      {'title': 'Market', 'icon': Icons.shopping_cart_outlined},
    ];

    return _buildCardWrapper(
      icon: Icons.roofing_rounded,
      title: 'Amenities',
      subtitle: 'Select the amenities available in your property',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Common Amenities',
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 12),

          // 4-Column Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: commonAmenities.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.95,
            ),
            itemBuilder: (context, index) {
              final item = commonAmenities[index];
              final title = item['title'] as String;
              final icon = item['icon'] as IconData;
              final isSelected = _selectedAmenities.contains(title);

              return _buildAmenityTile(
                icon: icon,
                title: title,
                isSelected: isSelected,
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedAmenities.remove(title);
                    } else {
                      _selectedAmenities.add(title);
                    }
                  });
                },
              );
            },
          ),

          const SizedBox(height: 20),

          const Text(
            'Nearby Facilities',
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 12),

          // 4-Column Grid for Nearby Facilities
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: nearbyFacilities.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.95,
            ),
            itemBuilder: (context, index) {
              final item = nearbyFacilities[index];
              final title = item['title'] as String;
              final icon = item['icon'] as IconData;
              final isSelected = _selectedFacilities.contains(title);

              return _buildAmenityTile(
                icon: icon,
                title: title,
                isSelected: isSelected,
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedFacilities.remove(title);
                    } else {
                      _selectedFacilities.add(title);
                    }
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAmenityTile({
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: isSelected ? themeSoftColor : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? themeColor : const Color(0xFFE2E8F0),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected ? themeColor : const Color(0xFF64748B),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: TextStyle(
                fontSize: 9.5,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? themeColor : const Color(0xFF475569),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // STEP 4: PHOTOS & VIDEO
  // ---------------------------------------------------------------------------
  Widget _buildStep4Form() {
    return _buildCardWrapper(
      icon: Icons.photo_library_rounded,
      title: 'Photos & Video',
      subtitle: 'Add high quality photos and videos of your property',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Big Upload Photos Box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFCBD5E1),
                width: 1.2,
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: themeSoftColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.add_photo_alternate_rounded,
                      color: themeColor, size: 28),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Upload Photos',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Add up to 20 photos\n(JPG, PNG - Max 10MB each)',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF64748B),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Uploaded Photos Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _photos.length + 1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (context, index) {
              if (index < _photos.length) {
                return Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.asset(
                          _photos[index],
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Container(
                            color: themeSoftColor,
                            child: Icon(Icons.image, color: themeColor),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () {
                          setState(() => _photos.removeAt(index));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.close,
                              size: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: themeColor.withValues(alpha: 0.5),
                      width: 1.2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: themeColor, size: 22),
                      const SizedBox(height: 4),
                      Text(
                        'Add More',
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                          color: themeColor,
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),

          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${_photos.length}/20',
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Add Video (Optional)
          const Text(
            'Add Video (Optional)',
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: themeSoftColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.play_circle_fill_rounded,
                      color: themeColor, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Upload Property Video',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      Text(
                        '[Max 50MB, MP4]',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded,
                    color: Color(0xFF94A3B8)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // STEP 5: REVIEW & POST
  // ---------------------------------------------------------------------------
  Widget _buildStep5Form() {
    return _buildCardWrapper(
      icon: Icons.rate_review_rounded,
      title: 'Review & Post',
      subtitle: 'Review all details before posting your property',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Edit button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Property Preview',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              InkWell(
                onTap: () => setState(() => _currentStep = 1),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.edit_outlined,
                          size: 13, color: Color(0xFF2563EB)),
                      SizedBox(width: 4),
                      Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2563EB),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Property Preview Card
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image with FOR SALE / FOR RENT banner
                Stack(
                  children: [
                    Image.asset(
                      'assets/images/post_hero_banner.jpg',
                      height: 140,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        height: 140,
                        color: themeSoftColor,
                        child: Icon(Icons.home, size: 48, color: themeColor),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: themeColor,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          isSell ? 'FOR SALE' : 'FOR RENT',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Price
                      Text(
                        isSell
                            ? '₹${_priceController.text}'
                            : '₹${_priceController.text}/month',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Title & Location
                      Text(
                        _titleController.text,
                        style: const TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF334155),
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Sector 62, Noida, Uttar Pradesh',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF64748B),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Key Specs Chips
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildSpecChip(Icons.bed_rounded, '$_bhk Beds'),
                          _buildSpecChip(
                              Icons.bathtub_rounded, '$_bathrooms Baths'),
                          _buildSpecChip(Icons.square_foot_rounded,
                              '${_areaController.text} sq ft'),
                          _buildSpecChip(
                              Icons.directions_car_rounded, _parking),
                        ],
                      ),

                      const Divider(height: 24, color: Color(0xFFF1F5F9)),

                      // Key-Value Table
                      _buildReviewRow(
                          'Property Type', _propertyType),
                      _buildReviewRow('Furnishing', _furnishing),
                      if (isSell) ...[
                        _buildReviewRow('Facing', _facing),
                        _buildReviewRow('Property Age', _propertyAge),
                      ] else ...[
                        _buildReviewRow('Available from', _availability),
                        _buildReviewRow('Minimum Lease', _minLease),
                        _buildReviewRow('Facing', _facing),
                      ],

                      const SizedBox(height: 10),

                      // Amenities preview
                      Row(
                        children: [
                          const Text(
                            'Amenities',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF64748B),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Icon(Icons.pool_rounded,
                                  size: 15, color: themeColor),
                              const SizedBox(width: 4),
                              Icon(Icons.bolt_rounded,
                                  size: 15, color: themeColor),
                              const SizedBox(width: 4),
                              Icon(Icons.park_rounded,
                                  size: 15, color: themeColor),
                              const SizedBox(width: 4),
                              Text(
                                '+5 more',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: themeColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Accuracy Confirmation Checkbox
          Row(
            children: [
              SizedBox(
                width: 22,
                height: 22,
                child: Checkbox(
                  value: _confirmedAccuracy,
                  activeColor: themeColor,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onChanged: (val) =>
                      setState(() => _confirmedAccuracy = val ?? true),
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'I confirm that all the information provided is accurate.',
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Color(0xFF334155),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: const Color(0xFF64748B)),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 10,
            color: Color(0xFF475569),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF64748B),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // CARD WRAPPER HELPER
  // ---------------------------------------------------------------------------
  Widget _buildCardWrapper({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF1F5F9), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: themeSoftColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: themeColor, size: 20),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
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

          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // FORM FIELD UTILS
  // ---------------------------------------------------------------------------
  Widget _buildFormField({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label.replaceAll(' *', ''),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFF334155),
            ),
            children: [
              if (label.contains('*'))
                const TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Color(0xFFEF4444),
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        child,
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    Widget? prefixIcon,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
          color: Color(0xFF0F172A),
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 12,
            color: Color(0xFF94A3B8),
            fontWeight: FontWeight.normal,
          ),
          prefixIcon: prefixIcon,
          prefixIconConstraints:
              const BoxConstraints(minWidth: 32, minHeight: 32),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: items.contains(value) ? value : items.first,
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: Color(0xFF64748B), size: 18),
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0F172A),
          ),
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildSegmentButton(
      String label, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: 42,
          decoration: BoxDecoration(
            color: isSelected ? themeSoftColor : const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? themeColor : const Color(0xFFE2E8F0),
              width: isSelected ? 1.5 : 1.0,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
              color: isSelected ? themeColor : const Color(0xFF475569),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // BOTTOM ACTION BAR
  // ---------------------------------------------------------------------------
  Widget _buildBottomActionBar() {
    final nextLabels = [
      'Next: Property Details',
      'Next: Amenities',
      'Next: Photos & Video',
      'Next: Review & Post',
      'Publish Property',
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
        child: _currentStep == 1
            // Step 1: Full-width Next button
            ? SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeColor,
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
            // Steps 2-5: Back + Next/Publish Buttons
            : Row(
                children: [
                  // Back Button
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

                  // Next / Publish Button
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _nextStep,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: themeColor,
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
                                padding: EdgeInsets.only(right: 6.0),
                                child: Icon(Icons.rocket_launch_rounded,
                                    color: Colors.white, size: 18),
                              ),
                            Text(
                              nextLabels[_currentStep - 1],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13.5,
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
                color: themeColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: themeColor.withValues(alpha: 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(Icons.check_rounded,
                  size: 38, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              isSell ? 'Property Listed for Sale!' : 'Property Listed for Rent!',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Color(0xFF0F172A),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Your property has been submitted for verification and will go live shortly.',
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
                        'Listing ID',
                        style:
                            TextStyle(fontSize: 10, color: Color(0xFF64748B)),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'PN-10245',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Pending Review',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFD97706),
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
                  backgroundColor: themeColor,
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
