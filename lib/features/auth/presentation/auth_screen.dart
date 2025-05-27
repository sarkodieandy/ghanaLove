import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();
  final _picker = ImagePicker();

  File? _profileImage;
  int _currentStep = 0;
  bool _isImageUploading = false;

  // User data
  late String _name;
  late String _bio;
  int _age = 18;
  String _gender = 'Male';
  final List<String> _interests = [];

  Future<void> _pickImage() async {
    setState(() => _isImageUploading = true);
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() => _profileImage = File(image.path));
      }
    } finally {
      setState(() => _isImageUploading = false);
    }
  }

  void _nextStep() {
    if (_currentStep < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentStep++);
    }
  }

  void _submit() {
    if ((_formKey.currentState?.validate() ?? false) &&
        _interests.length >= 3) {
      _formKey.currentState?.save();
      context.go('/login'); // Navigate to login or home
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please complete all fields and select at least 3 interests.',
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentStep > 0) {
          _pageController.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          setState(() => _currentStep--);
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: _currentStep > 0
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    setState(() => _currentStep--);
                  },
                )
              : null,
          title: const Text('Create Profile'),
          centerTitle: true,
          elevation: 0,
          actions: [
            TextButton(
              onPressed: _currentStep == 2 ? _submit : null,
              child: Text(
                _currentStep == 2 ? 'DONE' : 'SKIP',
                style: TextStyle(
                  color: _currentStep == 2 ? Colors.redAccent : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            LinearProgressIndicator(
              value: (_currentStep + 1) / 3,
              backgroundColor: Colors.grey[200],
              color: Colors.redAccent,
              minHeight: 2,
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildPhotoStep(),
                  _buildInfoStep(),
                  _buildInterestsStep(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: FilledButton(
                onPressed: _currentStep == 2 ? _submit : _nextStep,
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  _currentStep == 2 ? 'COMPLETE PROFILE' : 'CONTINUE',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoStep() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Add Your Best Photo',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'This will be your first impression',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 100,
              backgroundColor: Colors.grey[200],
              backgroundImage: _profileImage != null
                  ? FileImage(_profileImage!)
                  : null,
              child: _profileImage == null
                  ? Icon(Icons.add_a_photo, size: 50, color: Colors.grey[400])
                  : null,
            ),
          ),
          if (_isImageUploading)
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: CircularProgressIndicator(),
            ),
          if (_profileImage != null)
            TextButton(
              onPressed: _pickImage,
              child: const Text('Change Photo'),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Text(
              'Tell Us About Yourself',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.person),
              ),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter your name' : null,
              onSaved: (value) => _name = value ?? '',
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Bio',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.edit),
              ),
              maxLines: 3,
              onSaved: (value) => _bio = value ?? '',
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _gender,
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.transgender),
                    ),
                    items: ['Male', 'Female', 'Other'].map((gender) {
                      return DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => _gender = value!),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Age',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.cake),
                    ),
                    keyboardType: TextInputType.number,
                    initialValue: _age.toString(),
                    onChanged: (value) => _age = int.tryParse(value) ?? _age,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterestsStep() {
    const interests = [
      'Travel',
      'Music',
      'Sports',
      'Movies',
      'Cooking',
      'Gaming',
      'Reading',
      'Fitness',
    ];

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            'What Are You Into?',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Select at least 3 interests',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: interests.map((interest) {
              final isSelected = _interests.contains(interest);
              return FilterChip(
                label: Text(interest),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    selected
                        ? _interests.add(interest)
                        : _interests.remove(interest);
                  });
                },
                selectedColor: Colors.redAccent.withOpacity(0.2),
                checkmarkColor: Colors.redAccent,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.redAccent : Colors.black,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: isSelected
                        ? Colors.redAccent
                        : Colors.grey.withOpacity(0.3),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
