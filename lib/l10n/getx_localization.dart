import 'package:get/get_navigation/src/root/internacionalization.dart';

class Language extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          //splash screen
          'splash_text': 'Face Registration APP',
          'dashboard': 'Dashboard',

          //login Screen
          'exams': 'Exam type',
          'null_exam_list': 'No exams available right now',
          'email_hint': 'Email/User id',
          'password_hint': 'Password',
          'login': 'Login',
          'registration': 'Registration',
          'welcome': 'Welcome to face detection app',

          //registration screen
          'photo_upload': 'Upload photo',
          'open_camera': 'Open camera',
          'front_upload': 'Upload front side of your face',
          'left_upload': 'Upload left side of your face',
          'right_upload': 'Upload right side of your face',
          'sign_upload': 'Upload your signature here',
          'complete_process':
              'This is to inform you that the photos you capture will be verify with you during the examination. So be careful when uploading photos and give clear photos.',
          'complete_btn': 'Complete Process',
          'completed_registration':
              'You have successfully completed the registration process for ___ exam',

          // loginController
          'please_wait': 'Please Wait...',
          'no_data': 'No data found',
          'warning': 'Warning!',
          'retry': 'Retry',
          'error_unknown': 'Unknown error occurred',

          //registration controller
          'verification_text':
              'For facial verification you need to give your clear photo in the following way.',
          'uploading': 'Uploading image ...',
          'no_face_found': 'Sorry no face detected',
          'try_again_btn': 'Try again',
          'no_image_selected': 'No image selected from device',
          'wait_for_a_while': 'Please wait for a while ...',
          'next_btn': 'Next',
          'complete_process_warning':
              'Please upload all the images in the given way to complete registration',
          'no_internet': 'No internet connection',
        },

        'bn_BD': {
          //splash screen
          'splash_text': 'ফেস ডিটেকশন অ্যাপ',
          'dashboard': 'ড্যাশবোর্ড',

          //login screen
          'exams': 'পরীক্ষার ধরন',
          'null_exam_list': 'এখন কোনো পরীক্ষার সময়সূচি নেই',
          'email_hint': 'ইমেল/ইউজার আইডি',
          'password_hint': 'পাসওয়ার্ড',
          'login': 'লগইন',

          //registration screen
          'registration': 'রেজিস্ট্রেশন',
          'welcome': 'ফেস ডিটেকশন অ্যাপে স্বাগতম',
          'photo_upload': 'আপলোড ফটো',
          'open_camera': 'ওপেন ক্যামেরা',
          'front_upload': 'আপনার মুখের সামনের দিকটি আপলোড করুন',
          'left_upload': 'আপনার মুখের ডান পাশটি আপলোড করুন',
          'right_upload': 'আপনার মুখের বাম পাশটি আপলোড করুন',
          'sign_upload': 'এখানে আপনার স্বাক্ষর আপলোড করুন',
          'complete_process':
              'অনুগ্রহ করে পরীক্ষা করুন এবং প্রক্রিয়াটি সম্পূর্ণ করুন',
          'complete_btn': 'প্রক্রিয়া সম্পূর্ণ করুন',
          'completed_registration':
              'আপনি সফলভাবে ___ পরীক্ষার জন্য নিবন্ধন প্রক্রিয়া সম্পন্ন করেছেন',

          // loginController
          'please_wait': 'অনুগ্রহপূর্বক অপেক্ষা করুন...',
          'no_data': 'No data found',
          'warning': 'সতর্কতা',
          'error_unknown': 'অজানা ত্রুটি ঘটেছে',

          //registration controller
          'verification_text':
              'ফেসিয়াল ভেরিফিকেশনের জন্য আপনাকে নিচের উপায়ে আপনার পরিষ্কার ছবি দিতে হবে।',
          'uploading': 'ছবি আপলোড করা হচ্ছে...',
          'no_face_found': 'দুঃখিত কোন ফেস সনাক্ত করা হয়নি',
          'try_again_btn': 'আবার চেষ্টা করুন',
          'no_image_selected': 'ডিভাইস থেকে কোনো ছবি নির্বাচন করা হয়নি',
          'wait_for_a_while': 'কিছুক্ষন অপেক্ষা করুন...',
          'next_btn': 'অগ্রসর হন',
          'complete_process_warning':
              'নিবন্ধন সম্পূর্ণ করার জন্য প্রদত্ত উপায়ে সমস্ত ছবি আপলোড করুন',
          'no_internet': 'ইন্টারনেট সংযোগ নেই',
        },
      };
}
