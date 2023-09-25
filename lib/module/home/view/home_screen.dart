import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mict_final_project/core/utils/exports.dart';
import 'package:mict_final_project/core/widgets/exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(
        title: 'Home',
        actions: [
          GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(Icons.logout_outlined, color: redColor, size: 25,),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          _profileWidget(),
          SizedBox(height: 100,),
          Container(
            height: 250,
            width: 250,
            decoration: BoxDecoration(
              color: strokeColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 1.2,
                color: Colors.grey.shade300,
              )
            ),
            child: Icon(Icons.person_outline_outlined, size: 50,),
          ),
          SizedBoxHeight20(),
          _uploadPhotoButton(),
        ],
      ),
    );
  }

  Widget _profileWidget(){
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 6,
      width: size.width,
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: greenColor,
            radius: 40,
            child: Icon(
              Icons.person,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget('Abu Sale Mohammad Fahim', style: TextStyles.title16,),
              TextWidget('id: 2254991017', style: TextStyles.title16,),
              TextWidget('exam : BCS exam', style: TextStyles.title16,),
            ],
          ),
        ],
      ),
    );
  }

  Widget _uploadPhotoButton() {
    Size size = MediaQuery.of(context).size;
    return CommonButton(
      btnHeight: size.height / 20,
      buttonColor: greenColor,
      width: size.width / 2,
      buttonTitle: 'Upload photo',
      onTap: () {
        //upload image
      },
    );
  }
}
