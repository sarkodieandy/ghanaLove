import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/custom_button.dart';

class ProfileCreationScreen extends StatefulWidget {
  const ProfileCreationScreen({super.key});

  @override
  State<ProfileCreationScreen> createState() => _ProfileCreationScreenState();
}

class _ProfileCreationScreenState extends State<ProfileCreationScreen> {
  int _currentStep = 0;
  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  String? _gender;
  String? _location;
  String? _culturalBackground;
  String? _religion;
  String? _relationshipGoal;

  final List<String> genders = ['Male', 'Female', 'Other'];
  final List<String> locations = ['Accra', 'Kumasi', 'Tamale', 'Cape Coast'];
  final List<String> culturalBackgrounds = ['Akan', 'Ewe', 'Ga', 'Other'];
  final List<String> religions = ['Christian', 'Muslim', 'Traditional'];
  final List<String> relationshipGoals = [
    'Marriage',
    'Serious Relationship',
    'Casual Dating',
    'Friendship',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => _profileImage = File(image.path));
    }
  }

  void _nextStep() {
    if (_formKeys[_currentStep].currentState?.validate() ?? false) {
      if (_currentStep < 2) {
        setState(() => _currentStep++);
      } else {
        context.go('/profile/1');
      }
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    } else {
      context.go('/settings'); // Always go back to settings
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => context.go('/settings'), // Back to settings
        ),
        title: const Text('Create Profile'),
        actions: [
          TextButton(
            onPressed: () => context.go('/home'),
            child: const Text('Skip'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Stepper(
            type: StepperType.vertical,
            currentStep: _currentStep,
            onStepContinue: _nextStep,
            onStepCancel: _previousStep,
            controlsBuilder: (context, details) {
              return Row(
                children: [
                  CustomButton(
                    text: _currentStep == 2
                        ? AppStrings.saveAndContinue
                        : 'Next',
                    onPressed: details.onStepContinue!,
                    width: 120,
                  ),
                  const SizedBox(width: 16),
                  if (_currentStep > 0)
                    CustomButton(
                      text: 'Back',
                      onPressed: details.onStepCancel!,
                      isPrimary: false,
                      width: 100,
                    ),
                ],
              );
            },
            steps: [
              Step(
                title: const Text('Basic Info'),
                content: _buildBasicInfoForm(),
                isActive: _currentStep == 0,
              ),
              Step(
                title: const Text('Cultural Info'),
                content: _buildCulturalInfoForm(),
                isActive: _currentStep == 1,
              ),
              Step(
                title: const Text('Bio'),
                content: _buildBioForm(),
                isActive: _currentStep == 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBasicInfoForm() {
    return Form(
      key: _formKeys[0],
      child: Column(
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[200],
              backgroundImage: _profileImage != null
                  ? FileImage(_profileImage!)
                  : null,
              child: _profileImage == null
                  ? const Icon(Icons.add_a_photo, size: 30, color: Colors.grey)
                  : null,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Name'),
            validator: (value) =>
                value == null || value.isEmpty ? 'Enter your name' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _ageController,
            decoration: const InputDecoration(labelText: 'Age'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Enter your age';
              if (int.tryParse(value) == null) return 'Enter a valid number';
              return null;
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _gender,
            decoration: const InputDecoration(labelText: 'Gender'),
            items: genders
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) => setState(() => _gender = value),
            validator: (value) => value == null ? 'Select gender' : null,
          ),
        ],
      ),
    );
  }

  Widget _buildCulturalInfoForm() {
    return Form(
      key: _formKeys[1],
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            value: _location,
            decoration: const InputDecoration(labelText: 'Location'),
            items: locations
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) => setState(() => _location = value),
            validator: (value) => value == null ? 'Select location' : null,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _culturalBackground,
            decoration: const InputDecoration(labelText: 'Cultural Background'),
            items: culturalBackgrounds
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) => setState(() => _culturalBackground = value),
            validator: (value) =>
                value == null ? 'Select cultural background' : null,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _religion,
            decoration: const InputDecoration(labelText: 'Religion'),
            items: religions
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) => setState(() => _religion = value),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _relationshipGoal,
            decoration: const InputDecoration(labelText: 'Relationship Goal'),
            items: relationshipGoals
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) => setState(() => _relationshipGoal = value),
            validator: (value) =>
                value == null ? 'Select relationship goal' : null,
          ),
        ],
      ),
    );
  }

  Widget _buildBioForm() {
    return Form(
      key: _formKeys[2],
      child: TextFormField(
        controller: _bioController,
        decoration: const InputDecoration(
          labelText: 'Bio',
          hintText: 'Tell others about yourself...',
          border: OutlineInputBorder(),
        ),
        maxLines: 5,
        maxLength: 200,
        validator: (value) =>
            value == null || value.isEmpty ? 'Write a short bio' : null,
      ),
    );
  }
}
