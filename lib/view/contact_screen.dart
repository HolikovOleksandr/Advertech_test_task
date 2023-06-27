import 'package:advertech_test_task/helpers/colors.dart';
import 'package:advertech_test_task/helpers/fonts.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            _sendButton(size),
          ],
        ),
      ),
    );
  }

  _sendButton(Size size) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: size.width,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.purple,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            'Send',
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
