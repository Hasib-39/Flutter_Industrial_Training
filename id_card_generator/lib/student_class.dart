import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Student {
  final String universityName;
  final String studentId;
  final String studentName;
  final String departmentShortForm;
  final String country;
  final String quote;
  final String universityLogoBase64;
  final String studentPhotoBase64;
  final Color themeColor;

  const Student({
    required this.universityName,
    required this.studentId,
    required this.studentName,
    required this.departmentShortForm,
    required this.country,
    required this.quote,
    required this.universityLogoBase64,
    required this.studentPhotoBase64,
    required this.themeColor,
  });
}

class StudentFormPage extends StatefulWidget {
  const StudentFormPage({super.key});

  @override
  State<StudentFormPage> createState() => _StudentFormPageState();
}

class _StudentFormPageState extends State<StudentFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _imagePicker = ImagePicker();

  final _universityNameController = TextEditingController();
  final _studentIdController = TextEditingController();
  final _studentNameController = TextEditingController();
  final _departmentShortFormController = TextEditingController();
  final _countryController = TextEditingController();
  final _quoteController = TextEditingController();

  String? _universityLogoBase64;
  String? _studentPhotoBase64;
  Color _selectedThemeColor = const Color(0xff003432);

  Student? _createdStudent;
  bool _showForm = true;

  final List<Color> _themeColors = [
    const Color(0xff003432),
    const Color(0xff1976D2),
    const Color(0xff7B1FA2),
    const Color(0xffC62828),
    const Color(0xffE65100),
    const Color(0xff2E7D32),
    const Color(0xff00695C),
    const Color(0xff283593),
  ];

  Future<void> _pickImage(bool isLogo) async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 85,
    );

    if (image != null) {
      final bytes = await File(image.path).readAsBytes();
      final base64String = base64Encode(bytes);

      setState(() {
        if (isLogo) {
          _universityLogoBase64 = base64String;
        } else {
          _studentPhotoBase64 = base64String;
        }
      });
    }
  }

  Future<void> _takePhoto() async {
    final XFile? photo = await _imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 85,
    );

    if (photo != null) {
      final bytes = await File(photo.path).readAsBytes();
      final base64String = base64Encode(bytes);

      setState(() {
        _studentPhotoBase64 = base64String;
      });
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      if (_universityLogoBase64 == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select a university logo")),
        );
        return;
      }

      if (_studentPhotoBase64 == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please add a student photo")),
        );
        return;
      }

      final student = Student(
        universityName: _universityNameController.text,
        studentId: _studentIdController.text,
        studentName: _studentNameController.text,
        departmentShortForm: _departmentShortFormController.text,
        country: _countryController.text,
        quote: _quoteController.text,
        universityLogoBase64: _universityLogoBase64!,
        studentPhotoBase64: _studentPhotoBase64!,
        themeColor: _selectedThemeColor,
      );

      setState(() {
        _createdStudent = student;
        _showForm = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Student ID card created successfully!")),
      );
    }
  }

  @override
  void dispose() {
    _universityNameController.dispose();
    _studentIdController.dispose();
    _studentNameController.dispose();
    _departmentShortFormController.dispose();
    _countryController.dispose();
    _quoteController.dispose();
    super.dispose();
  }

  Widget _buildImagePreview(String? base64String, String label) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[400]!, width: 2),
      ),
      child: base64String != null
          ? ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.memory(
          base64Decode(base64String),
          fit: BoxFit.cover,
        ),
      )
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image, size: 40, color: Colors.grey[600]),
          const SizedBox(height: 8),
          Text(label,
              style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        ],
      ),
    );
  }

  Visibility _buildIDCardForm() {
    return Visibility(
      visible: _showForm,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Student Information",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),

                // University Logo Section
                const Center(
                  child: Text(
                    "University Logo",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        _buildImagePreview(_universityLogoBase64, "Logo"),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () => _pickImage(true),
                          icon: const Icon(Icons.upload_file),
                          label: const Text("Choose Logo"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _selectedThemeColor,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Student Photo Section
                const Center(
                  child: Text(
                    "Student Photo",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        _buildImagePreview(_studentPhotoBase64, "Photo"),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: _takePhoto,
                          icon: const Icon(Icons.camera_alt),
                          label: const Text("Take Photo"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _selectedThemeColor,
                            foregroundColor: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton.icon(
                          onPressed: () => _pickImage(false),
                          icon: const Icon(Icons.photo_library),
                          label: const Text("Choose Photo"),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: _selectedThemeColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Theme Color Section
                const Text(
                  "Card Theme Color",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: _themeColors.map((color) {
                    final isSelected = color == _selectedThemeColor;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedThemeColor = color;
                        });
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? Colors.black : Colors.grey[300]!,
                            width: isSelected ? 3 : 2,
                          ),
                        ),
                        child: isSelected
                            ? const Icon(Icons.check, color: Colors.white)
                            : null,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),

                // Text Fields
                TextFormField(
                  controller: _universityNameController,
                  decoration: InputDecoration(
                    labelText: "University Name",
                    prefixIcon: const Icon(Icons.school),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  validator: (value) =>
                  value == null || value.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _studentIdController,
                  decoration: InputDecoration(
                    labelText: "Student ID",
                    prefixIcon: const Icon(Icons.badge),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  validator: (value) =>
                  value == null || value.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _studentNameController,
                  decoration: InputDecoration(
                    labelText: "Student Name",
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  validator: (value) =>
                  value == null || value.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _departmentShortFormController,
                  decoration: InputDecoration(
                    labelText: "Department (e.g., CSE, EEE)",
                    prefixIcon: const Icon(Icons.business),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  validator: (value) =>
                  value == null || value.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _countryController,
                  decoration: InputDecoration(
                    labelText: "Country",
                    prefixIcon: const Icon(Icons.flag),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _quoteController,
                  decoration: InputDecoration(
                    labelText: "Quote (Optional)",
                    prefixIcon: const Icon(Icons.format_quote),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _saveForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedThemeColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Generate ID Card",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIDCard(Student student) {
    return Center(
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all( 16.0),
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    color: student.themeColor,
                    width: 300,
                    height: 160,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 8),
                        Container(
                          height: 45,
                          width: 45,
                          color: Colors.white,
                          child: Image.memory(
                            base64Decode(student.universityLogoBase64),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          student.universityName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: -75,
                    child: Container(
                      height: 150,
                      width: 150,
                      color: student.themeColor,
                      padding: const EdgeInsets.all(8.0),
                      child: Image.memory(
                        base64Decode(student.studentPhotoBase64),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
              SizedBox(
                width: 190,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.key_sharp, color: student.themeColor),
                        const SizedBox(width: 4),
                        const Text("Student ID",
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    Container(
                      width: 150,
                      height: 28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: student.themeColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            const CircleAvatar(
                                maxRadius: 8,
                                backgroundColor: Colors.blueAccent),
                            const SizedBox(width: 10),
                            Text(student.studentId,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.account_circle, color: student.themeColor),
                        const SizedBox(width: 4),
                        const Text("Student Name",
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0),
                      child: Text(student.studentName,
                          style: TextStyle(
                              color: student.themeColor,
                              fontWeight: FontWeight.w900)),
                    ),
                    Row(
                      children: [
                        Icon(Icons.school, color: student.themeColor),
                        const SizedBox(width: 4),
                        const Text("Program ",
                            style: TextStyle(color: Colors.grey)),
                        Text("B.Sc. in ${student.departmentShortForm} ",
                            style: TextStyle(
                                color: student.themeColor,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.people, color: student.themeColor),
                        const SizedBox(width: 4),
                        const Text("Department ",
                            style: TextStyle(color: Colors.grey)),
                        Text(student.departmentShortForm,
                            style: TextStyle(
                                color: student.themeColor,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: student.themeColor),
                        const SizedBox(width: 4),
                        Text(student.country,
                            style: TextStyle(
                                color: student.themeColor,
                                fontWeight: FontWeight.bold)),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: 300,
                height: 28,
                color: student.themeColor,
                alignment: Alignment.center,
                child: Text(
                  student.quote,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.italic),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showForm = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: student.themeColor,
                    foregroundColor: Colors.white),
                child: const Text("Edit Info"),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Student ID Card Generator"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: _selectedThemeColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildIDCardForm(),
            if (!_showForm && _createdStudent != null)
              _buildIDCard(_createdStudent!),
          ],
        ),
      ),
    );
  }
}
