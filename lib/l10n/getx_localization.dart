import 'package:get/get_navigation/src/root/internacionalization.dart';

class Language extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US' : {

      //splash screen
      'splash text' : 'Face Registration APP',
      'dashboard' : 'Dashboard',


      //login Screen
      'exams' : 'Exam type',
      'null_exam_list' : 'No exams available right now',
      'email_hint' : 'Email/User id',
      'password_hint' : 'Password',
      'login' : 'Login',
      'registration' : 'Registration',
      'welcome' : 'Welcome to face detection app',


      //registration screen
      'photo_upload': 'Upload photo',
      'open_camera' : 'Open camera',
      'front_upload': 'Upload front side of your face',
      'left_upload': 'Upload left side of your face',
      'right_upload': 'Upload right side of your face',
      'sign_upload': 'Upload your signature here',
      'complete_process': 'Your registration is about to complete. Please press complete and all the best',
      'complete_btn': 'Complete Process',
      'completed_registration': 'You have successfully completed the registration process for ___ exam',

      // loginController
      'please_wait' : 'Please Wait...',
      'no_data' : 'No data found',
      'warning' : 'Warning!',
      'error_unknown' : 'Unknown error occurred',

      //registration controller
      'uploading' : 'Uploading image ...',
      'no_face_found' : 'Sorry no face detected',
      'try_again_btn' : 'try again',
      'no_image_selected' : 'No image selected from device',
      'wait_for_a_while' : 'Please wait for a while ...',

    },

    'bn_BD' : {
      //splash screen
      'splash text' : 'ফেস ডিটেকশন অ্যাপ',
      'dashboard' : 'ড্যাশবোর্ড',

      //login screen
      'exams' : 'পরীক্ষার ধরন',
      'null_exam_list' : 'এখন কোনো পরীক্ষার সময়সূচি নেই',
      'email_hint' : 'ইমেল/ইউজার আইডি',
      'password_hint' : 'পাসওয়ার্ড',
      'login' : 'লগইন',

      //registration screen
      'registration' : 'রেজিস্ট্রেশন',
      'welcome' : 'ফেস ডিটেকশন অ্যাপে স্বাগতম',
      'photo_upload': 'আপলোড ফটো',
      'open_camera': 'ওপেন ক্যামেরা',
      'front_upload': 'আপনার মুখের সামনের দিকটি আপলোড করুন',
      'left_upload': 'আপনার মুখের ডান পাশটি আপলোড করুন',
      'right_upload': 'আপনার মুখের বাম পাশটি আপলোড করুন',
      'sign_upload': 'এখানে আপনার স্বাক্ষর আপলোড করুন',
      'complete_process': 'অনুগ্রহ করে পরীক্ষা করুন এবং প্রক্রিয়াটি সম্পূর্ণ করুন',
      'complete_btn': 'প্রক্রিয়া সম্পূর্ণ করুন',
      'completed_registration': 'আপনি সফলভাবে ___ পরীক্ষার জন্য নিবন্ধন প্রক্রিয়া সম্পন্ন করেছেন',

      // loginController
      'please_wait' : 'অনুগ্রহপূর্বক অপেক্ষা করুন...',
      'no_data' : 'No data found',
      'warning' : 'সতর্কতা',
      'error_unknown' : 'অজানা ত্রুটি ঘটেছে',

      //registration controller
      'uploading' : 'ছবি আপলোড করা হচ্ছে...',
      'no_face_found' : 'দুঃখিত কোন ফেস সনাক্ত করা হয়নি',
      'try_again_btn' : 'আবার চেষ্টা করুন',
      'no_image_selected' : 'ডিভাইস থেকে কোনো ছবি নির্বাচন করা হয়নি',
      'wait_for_a_while' : 'কিছুক্ষন অপেক্ষা করুন...',

    },
  };
}