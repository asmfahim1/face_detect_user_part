import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mict_final_project/core/utils/exports.dart';
import 'package:mict_final_project/module/registration/view/registration_screen.dart';
import '../../../../../core/widgets/common_button.dart';
import '../../../../../core/widgets/common_text_field_widget.dart';
import '../../../../../core/widgets/sized_box_height_20.dart';
import '../../../../../core/widgets/text_widget.dart';
import '../../controller/login_controller.dart';

class LoginFormSectionWidget extends StatefulWidget {
  const LoginFormSectionWidget({Key? key}) : super(key: key);

  @override
  State<LoginFormSectionWidget> createState() => _LoginFormSectionWidgetState();
}

class _LoginFormSectionWidgetState extends State<LoginFormSectionWidget> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _passwordFocus = FocusNode();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<LoginController>(builder: (controller){
      return Form(
        key: _formKey,
        child: Container(
          height: size.height / 2,
          width: size.width,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: whiteColor.withOpacity(0.7),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBoxHeight20(),
              _textFields(controller),
              const SizedBox(
                height: 15,
              ),
              const SizedBoxHeight20(),
              _loginButton(controller),
            ],
          ),
        ),
      );
    });
  }

  Widget _textFields(LoginController login) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: size.height / 14,
          width: size.width,
          padding:
          const EdgeInsets.only(left: 10, right: 10),
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: DropdownButton(
            underline: const SizedBox(),
            // to remove the default underline of DropdownButton
            iconSize: 30.0,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.black,
            ),
            items: <String>['Bank exam', 'BDC exam', 'Biman exam', 'PSC exam']
                .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              login.setSelectedValue(newValue!);
            },
            hint: TextWidget(
              login.examType,
              style: TextStyles.title16,
            ),
            isExpanded: true,
            // to make the dropdown button span the full width of the container
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBoxHeight20(),
        CommonTextField(
          hintText: 'User id',
          validator: Validator().nullFieldValidate,
          controller: login.userId,
          onFieldSubmitted: (v) {
            FocusScope.of(context).requestFocus(_passwordFocus);
          },
        ),
        const SizedBoxHeight20(),
        CommonTextField(
          validator: Validator().nullFieldValidate,
          hintText: 'Password',
          focusNode: _passwordFocus,
          controller: login.password,
          obSecure: login.passwordVisible,
          onFieldSubmitted: (v) {
            //login method will call
            if (_formKey.currentState!.validate()) {

              /*login.loginMethod().then((value) {
                  if(value.isSuccess){
                    //route to home screen
                  }
                });*/
            }
          },
          suffixIcon: IconButton(
            color: blackColor,
            icon: login.passwordVisible
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off),
            onPressed: () {
              login.passwordVisible = !login.passwordVisible;
            },
          ),
        ),
      ],
    );
  }

  Widget _loginButton(LoginController login) {
    Size size = MediaQuery.of(context).size;
    return CommonButton(
      width: size.width / 1.6,
      buttonColor: blueColor,
      buttonTitle: 'Login',
      onTap: () {
        //login method will call
        Get.to(()=> const RegistrationScreen());
        //Get.toNamed(AppRoutes.homeScreen);
      },
    );
  }
}
