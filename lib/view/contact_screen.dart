// ignore_for_file: unused_element, deprecated_member_use, unused_local_variable, no_leading_underscores_for_local_identifiers, avoid_print, unused_field
import 'package:advertech_test_task/controllers/send_data_controller.dart';
import 'package:advertech_test_task/helpers/assets.dart';
import 'package:advertech_test_task/helpers/colors.dart';
import 'package:advertech_test_task/helpers/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  final _sendDataController = SendDataController();

  bool _isButtonDisabled = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  isValidEmail(String email) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  void _validateInputs() {
    _formKey.currentState!.validate()
        ? setState(() => _isButtonDisabled = false)
        : setState(() => _isButtonDisabled = true);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      int answer = _sendDataController.fetchData(
        name: _nameController.text,
        email: _emailController.text,
        message: _messageController.text,
      );

      _nameController.clear();
      _emailController.clear();
      _messageController.clear();

      setState(() {
        _isButtonDisabled = true;
        _isLoading = false;
      });
    }
  }

  @override
  build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          onChanged: _validateInputs,
          child: Column(
            children: [
              _requiredInputField(
                lable: 'Name',
                controller: _nameController,
                validator: (v) => v!.isEmpty ? 'Name is required' : null,
              ),
              _requiredInputField(
                lable: 'Email',
                controller: _emailController,
                validator: (v) {
                  if (v!.isEmpty) return 'Email is required';
                  if (!isValidEmail(v)) return 'Invalid email address';
                  return null;
                },
              ),
              _requiredInputField(
                lable: 'Message',
                controller: _messageController,
                validator: (v) => v!.isEmpty ? 'Message is required' : null,
              ),
              const SizedBox(height: 16.0),
              _sendButton(size)
            ],
          ),
        ),
      ),
    );
  }

  _requiredInputField({
    required String? Function(String?)? validator,
    required TextEditingController controller,
    required String? lable,
  }) {
    return TextFormField(
      validator: validator!,
      controller: controller,
      decoration: InputDecoration(
        labelText: lable!,
        labelStyle: AppFonts.lableText.copyWith(
          color: AppColors.lightGrey,
        ),
      ),
    );
  }

  _lockInCircleIcon() {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        color: AppColors.creame,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: SvgPicture.asset(
          AppAssets.openLockSVG,
          color: AppColors.yellow,
          height: 18,
          width: 18,
        ),
      ),
    );
  }

  _sendButton(Size size) {
    return GestureDetector(
      onTap: _isButtonDisabled ? null : _submitForm,
      child: Container(
        width: size.width,
        height: 50,
        decoration: BoxDecoration(
          color: _isButtonDisabled
              ? AppColors.purple.withOpacity(.5)
              : AppColors.purple,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            _isButtonDisabled ? 'Enter all required fiels' : 'Send',
            style: AppFonts.buttonText.copyWith(
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }

  _appBar() {
    return AppBar(
      title: Text(
        'Contact us',
        style: AppFonts.titleText.copyWith(
          color: AppColors.black,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: AppColors.black,
        ),
        onPressed: () {},
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }
}
