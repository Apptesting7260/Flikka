
import 'package:flikka/Job%20Seeker/SeekerBottomNavigationBar/tab_bar.dart';
import 'package:flikka/controllers/LoginController/LoginController.dart';
import 'package:flikka/Job%20Seeker/Authentication/sign_up.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'forgot_password.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  LoginController loginController =Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  var isLoading = false;

  bool _isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }
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
                decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //   // colors: [Color(0xff56B8F6), Color(0xff4D6FED)],
                  //   colors: [Color(0xff2386C7), Color(0xff4D6FED)],
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  // ),
               color: Color(0xff285bf5) ,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: Get.height*.08,),
                    Center(
                      child: Text("Welcome Back",style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 30)),
                    ),
                    SizedBox(height: Get.height*.02,),
                    Center(
                      child: SizedBox(
                        width: Get.width*.8,
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
                maxChildSize: 0.72, // full screen
                builder: (BuildContext context,
                    ScrollController scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30) ,
                          topLeft:Radius.circular(30) , ),
                        color: Colors.black),
                    // color: Colors.black,
                    child: SingleChildScrollView(
                     physics: NeverScrollableScrollPhysics(),
                      child: Container(
                        height: Get.height,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: Color(0xff000000),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(33.0),
                            topRight: Radius.circular(33.0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: Get.width*.06),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: Get.height*.05,),
                              Text("Email",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,color: Color(0xffFFFFFF)),),
                              SizedBox(height: Get.height*.01,),
                              TextFormField(
                                controller: loginController.emailController.value,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: Get.width*.06,vertical: Get.height*.027),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xffFFFFFF),
                                  hintText: "Enter your email",
                                  hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w500),
                                ),
                                onChanged: (value) {
                                  loginController.errorMessage.value = "" ;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an email address';
                                  } else if (!_isValidEmail(value)) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: Get.height*.02,),
                              Text("Password",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,color: Color(0xffFFFFFF)),),
                              SizedBox(height: Get.height*.01,),
                              TextFormField(
                                controller: loginController.passwordController.value,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                onChanged: (value) {
                                  loginController.errorMessage.value = "" ;
                                },
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w600),
                                obscureText: !_isPasswordVisible,
                                decoration: InputDecoration(
                                  //contentPadding: EdgeInsets.symmetric(horizontal: Get.width*.08,vertical: Get.height*.027),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(35),
                                    ),

                                    filled: true,
                                    fillColor: Color(0xffFFFFFF),
                                    hintText: "Enter your password",
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
                                  if (value!.isEmpty) {
                                    return "Please Enter Password";
                                   }
                                },
                              ),
                              SizedBox(height: Get.height*.01,),
                              Obx(() => loginController.errorMessage.value.isEmpty ?
                              const SizedBox() :
                                  Text(loginController.errorMessage.value,style: const TextStyle(color: Colors.red),)
                              ) ,
                              Align(
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                    onTap: () {
                                      Get.to(() =>const ForgotPassword());
                                    },
                                    child: Text("Forgot Password ?",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xff56B8F6)),)),
                              ),
                              SizedBox(height: Get.height*.045,),
                            Obx(() =>  Center(
                              child: MyButton(
                                  loading: loginController.loading.value,
                                  title: "LOGIN",
                                  onTap1: () {
                                    loginController.errorMessage.value = "" ;
                                    if(_formKey.currentState!.validate()) {
                                      print(loginController.loading.value);
                                      loginController.loginApiHit();
                                    }
                                  }
                              ),
                            ),),
                              SizedBox(height: Get.height*.03,),
                              Center(
                                child: SizedBox(
                                  width:   295,
                                  height:   56,
                                  child: ElevatedButton(
                                    onPressed: () {

                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xffFFFFFF),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset("assets/images/google.png",height: Get.height*.03,),
                                        SizedBox(width: Get.width*.03), // Add spacing between the icon and text
                                        Text("SIGN IN WITH GOOGLE",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w700),),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height*0.03,),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: RichText(
                                  text: TextSpan(
                                    text: "You don't have an account yet?  ",
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400, color: Color(0xffCFCFCF)),
                                    children: [
                                      TextSpan(
                                        recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUp()),
                                        text: "Sign up",
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400,color: Color(0xff56B8F6),decoration: TextDecoration.underline),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height*.05,),
                            ],
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

