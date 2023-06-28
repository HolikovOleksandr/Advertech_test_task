// ignore_for_file: unused_element, avoid_print, use_build_context_synchronously

import 'package:advertech_test_task/controllers/send_data_controller.dart';
import 'package:advertech_test_task/helpers/colors.dart';
import 'package:advertech_test_task/helpers/fonts.dart';
import 'package:flutter/material.dart';

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

  bool isValidEmail(String email) {
    final emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);

    return emailValid;
  }

  void _validateInputs() {
    setState(() => _isButtonDisabled = !_formKey.currentState!.validate());
  }

  Future<void> _sendDataToServer() async {
    if (_formKey.currentState!.validate()) {
      bool result = await _sendDataController.fetchData(
        name: _nameController.text,
        email: _emailController.text,
        message: _messageController.text,
      );

      _showResultMessage(result, context);

      setState(() {
        _isLoading = false;
        _isButtonDisabled = false;

        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          onChanged: _validateInputs,
          child: Column(
            children: [
              const Spacer(),
              _requiredInputField(
                size: size,
                label: 'Name',
                controller: _nameController,
                validator: (v) => v!.isEmpty ? 'Name is required' : null,
              ),
              _requiredInputField(
                size: size,
                label: 'Email',
                controller: _emailController,
                validator: (v) {
                  if (v!.isEmpty) return 'Email is required';
                  if (!isValidEmail(v)) return 'Invalid email address';
                  return null;
                },
              ),
              _requiredInputField(
                size: size,
                label: 'Message',
                controller: _messageController,
                validator: (v) => v!.isEmpty ? 'Message is required' : null,
              ),
              const Spacer(flex: 3),
              _sendDataButton(size),
              const Spacer(flex: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _requiredInputField({
    required String? Function(String?)? validator,
    required TextEditingController controller,
    required String? label,
    required Size size,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            children: [
              _lockInCircleIcon(),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  validator: validator!,
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: label!,
                    labelStyle: AppFonts.lableText.copyWith(
                      color: AppColors.grey,
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.lightGrey,
                        width: 1,
                      ),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.purple,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _lockInCircleIcon() {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        color: AppColors.creame,
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Center(
        child: Icon(
          Icons.lock_open,
          color: AppColors.yellow,
          size: 18,
        ),
      ),
    );
  }

  Widget _sendDataButton(Size size) {
    return GestureDetector(
      onTap: () {
        _sendDataToServer();
      },
      child: Container(
        width: size.width,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: _isButtonDisabled
              ? AppColors.purple.withOpacity(.5)
              : AppColors.purple,
        ),
        child: Center(
          child: !_isLoading
              ? Text(
                  _isButtonDisabled ? 'Enter all required fields' : 'Send',
                  style: AppFonts.buttonText.copyWith(
                      color: _isButtonDisabled
                          ? AppColors.purple
                          : AppColors.white),
                )
              : const SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    color: AppColors.purple,
                  ),
                ),
        ),
      ),
    );
  }

  _showResultMessage(bool result, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: result ? AppColors.purple : AppColors.red,
        content: Text(
          result ? 'Successful!' : 'Error',
          style: AppFonts.buttonText.copyWith(
            color: result ? AppColors.creame : AppColors.black,
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Contact us',
        style: AppFonts.titleText.copyWith(color: AppColors.black),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.black),
        onPressed: () => setState(() {
          _nameController.text = "Oleksandr";
          _emailController.text = "sanyagolikov97@gmail.com";
          _messageController.text = "Please hire me (:";
        }),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }
}
