
import 'package:flikka/controllers/ResetPasswordController/ResetPasswordController.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../widgets/app_colors.dart';
import 'login.dart';
import 'successfully.dart';


class CreatePassword extends StatefulWidget {
  final String email ;
  const CreatePassword({Key? key, required this.email}) : super(key: key);

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {

  ResetPasswordController resetPasswordController=Get.put(ResetPasswordController());

  var _formKey = GlobalKey<FormState>();
  var isLoading = false;

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
  }


  bool _isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  bool _isconPasswordVisible = false;
  bool _isconRememberMe = false;

  bool _isPasswordVisible = false;
  bool _isRememberMe = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.blueAccent,
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              Container(
                height: Get.height,
                width: Get.width,
                decoration: const BoxDecoration(
                  // gradient: LinearGradient(
                  //   // colors: [Color(0xff56B8F6), Color(0xff4D6FED)],
                  //   colors: [Color(0xff2386C7), Color(0xff4D6FED)],
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  // ),
                    color: AppColors.blueThemeColor
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: Get.height*.08,),
                    Center(
                      child: Text("Reset Password",style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 30)),
                    ),
                    SizedBox(height: Get.height*.02,),
                    Center(
                      child: SizedBox(
                        width: Get.width*.9,
                        child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffFFFFFF),fontSize: 13),),
                      ),
                    ),
                  ],
                ),
              ),
              DraggableScrollableSheet(
                initialChildSize: 0.72, // half screen
                minChildSize: 0.72, // half screen
                maxChildSize: 1, // full screen
                builder: (BuildContext context, ScrollController scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30) ,
                          topLeft:Radius.circular(30) , ),
                        color: Colors.black),
                    // color: Colors.black,
                    child:   SingleChildScrollView(
                      controller:scrollController ,
                      child: Container(
                        height: Get.height,
                        width: Get.width,
                        decoration: const BoxDecoration(
                          color: Color(0xff000000),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(33.0),
                            topRight: Radius.circular(33.0),
                          ),
                        ),
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: Get.width*.06),
                          child: SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: Get.height*.07,),
                                Text("New Password",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,color: Color(0xffFFFFFF)),),
                                SizedBox(height: Get.height*.01,),
                                TextFormField(
                                  controller: resetPasswordController.passwordcontroller.value,
                                  obscureText: !_isconPasswordVisible,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w600),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: Get.width*.06,vertical: Get.height*.027),
                                      suffixIcon: Padding(
                                        padding:  EdgeInsets.only(right: Get.width*.02),
                                        child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _isconPasswordVisible = !_isconPasswordVisible;
                                              });
                                            },
                                            icon: Icon(
                                              _isconPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                              color: Color(0xff646464),
                                            )),
                                      ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    filled: true,
                                    fillColor: Color(0xffFFFFFF),
                                    hintText: "Enter your password",
                                    hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w500),
                                  ),
                                  onFieldSubmitted: (value) {

                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please Enter Password";
                                    } else if (value.length < 8) {
                                      return "Password must be at least 8 characters long";
                                    } else if (!value.contains(RegExp(r'[A-Z]'))) {
                                      return "Password must contain at least one uppercase letter";
                                    } else if (!value.contains(RegExp(r'[a-z]'))) {
                                      return "Password must contain at least one lowercase letter";
                                    } else if (!value.contains(RegExp(r'[0-9]'))) {
                                      return "Password must contain at least one digit";
                                    } else if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                                      return "Password must contain at least one special character";
                                    }
                                    return null; // Return null if the password is valid
                                  },
                                ),
                                SizedBox(height: Get.height*.02,),
                                Text("Confirm Password",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,color: Color(0xffFFFFFF)),),
                                SizedBox(height: Get.height*.01,),
                                TextFormField(
                                controller: resetPasswordController.confirmpasswordcontroller.value,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w600),
                                  obscureText: !_isPasswordVisible,
                                  decoration: InputDecoration(
                                    //contentPadding: EdgeInsets.symmetric(horizontal: Get.width*.08,vertical: Get.height*.027),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(35),
                                      ),
                                      filled: true,
                                      fillColor: Color(0xffFFFFFF),
                                      hintText: "Enter your confirm password",
                                      hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w500),
                                      contentPadding: EdgeInsets.symmetric(horizontal: Get.width*.06,vertical: Get.height*.027),
                                      suffixIcon: Padding(
                                        padding:  EdgeInsets.only(right: Get.width*.02),
                                        child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _isPasswordVisible = !_isPasswordVisible;
                                              });
                                            },
                                            icon: Icon(
                                              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                              color: Color(0xff646464),
                                            )),
                                      )
                                  ),
                                  validator: (value) {
                                  if(value != resetPasswordController.passwordcontroller.value.text)
                                    {
                                      return "Password do not match";
                                    }
                                    // if (value!.isEmpty) {
                                    //   return "Please Enter Password";
                                    // } else if (value.length < 8) {
                                    //   return "Password must be at least 8 characters long";
                                    // } else if (!value.contains(RegExp(r'[A-Z]'))) {
                                    //   return "Password must contain at least one uppercase letter";
                                    // } else if (!value.contains(RegExp(r'[a-z]'))) {
                                    //   return "Password must contain at least one lowercase letter";
                                    // } else if (!value.contains(RegExp(r'[0-9]'))) {
                                    //   return "Password must contain at least one digit";
                                    // } else if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                                    //   return "Password must contain at least one special character";
                                    // }

                                    return null; // Return null if the password is valid
                                  },
                                ),
                                SizedBox(height: Get.height*.05,),
                                Center(
                                  child: MyButton(title: "SAVE", onTap1: () {
                                    if(_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      resetPasswordController.resetPasswordApiHit(widget.email) ;
                                      Get.to(()=>const Successfully());
                                    }
                                  },),
                                ),
                                SizedBox(height: 17),
                                Center(
                                  child: SizedBox(
                                    width:   295,
                                    height:   56,
                                    child: ElevatedButton(
                                      onPressed: () {
                                         Get.to(()=>const Login());
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Color(0xffFFFFFF),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                      ),
                                      child: Text("BACK TO LOGIN",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),

      ),
    );
  }
}

