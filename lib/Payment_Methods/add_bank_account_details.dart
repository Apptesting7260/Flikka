import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/app_colors.dart';

class AddBankAccountDetails extends StatefulWidget {
  const AddBankAccountDetails({super.key});

  @override
  State<AddBankAccountDetails> createState() => _AddBankAccountDetailsState();
}

class _AddBankAccountDetailsState extends State<AddBankAccountDetails> {
  final List<String> bankItems = [
    'State Bank of India','Bank of Baroda','ICICI Bank Ltd','Union Bank of India'
  ];
  String? bankValues;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height*.02,),
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset("assets/images/icon_back_blue.png",height: Get.height*.05,)),
              SizedBox(height: Get.height*.025,),
              Text("Add Bank account details",style: Theme.of(context).textTheme.displaySmall,),
              SizedBox(height: Get.height*.04,),
              Text("Bank",style: Theme.of(context).textTheme.titleSmall,),
              SizedBox(height: Get.height*.004,),
              Center(
                child:
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint:  Row(
                      children: [
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            'Select bank',
                            style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: bankItems
                        .map((String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                        .toList(),
                    value: bankValues,
                    onChanged: (String? value) {
                      setState(() {
                        bankValues = value;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      height: Get.height*0.078,
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),

                        color: Color(0xff353535),
                      ),
                      elevation: 2,
                    ),
                    iconStyleData:  IconStyleData(
                      icon: Image.asset('assets/images/arrowdown.png'),
                      iconSize: 14,
                      iconEnabledColor: Colors.yellow,
                      iconDisabledColor: Colors.grey,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: Get.height*0.35,
                      width: Get.width*0.902,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Color(0xff353535),
                      ),
                      offset: const Offset(5, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius:  Radius.circular(40),
                        thickness: MaterialStateProperty.all<double>(6),
                        thumbVisibility: MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 14, right: 14),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height*.04,),
              Text("Account Holder Name",style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
              SizedBox(height: Get.height*.004,),
              TextFormField(
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                    border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: BorderSide(color: Color(0xff373737))
                    ),
                    filled: true,
                    fillColor: Color(0xff373737),
                    hintText: "Enter name",
                    enabledBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      // borderSide: BorderSide(color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                      borderSide: BorderSide(color: Color(0xff373737)),
                    ),
                    hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: Color(0xffCFCFCF),fontWeight: FontWeight.w400),
                    contentPadding: EdgeInsets.symmetric(horizontal: Get.width*.06,vertical: Get.height*.027)
                ),
                onFieldSubmitted: (value) {

                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: Get.height*.04,),
              Text("Branch Code",style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
              SizedBox(height: Get.height*.004,),
              TextFormField(
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                    border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: BorderSide(color: Color(0xff373737))
                    ),
                    filled: true,
                    fillColor: Color(0xff373737),
                    hintText: "Enter code",
                    enabledBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      // borderSide: BorderSide(color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                      borderSide: BorderSide(color: Color(0xff373737)),
                    ),
                    hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: Color(0xffCFCFCF),fontWeight: FontWeight.w400),
                    contentPadding: EdgeInsets.symmetric(horizontal: Get.width*.06,vertical: Get.height*.027)
                ),
                onFieldSubmitted: (value) {

                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: Get.height*.04,),
              Text("Account Number",style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
              SizedBox(height: Get.height*.004,),
              TextFormField(
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                    border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: BorderSide(color: Color(0xff373737))
                    ),
                    filled: true,
                    fillColor: Color(0xff373737),
                    hintText: "Enter account number",
                    enabledBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      // borderSide: BorderSide(color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                      borderSide: BorderSide(color: Color(0xff373737)),
                    ),
                    hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: Color(0xffCFCFCF),fontWeight: FontWeight.w400),
                    contentPadding: EdgeInsets.symmetric(horizontal: Get.width*.06,vertical: Get.height*.027)
                ),
                onFieldSubmitted: (value) {

                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: Get.height*.04,),
             Center(
               child: MyButton(title: "SUBMIT", onTap1: () {

               },),
             )
            ],
          ),
        ),
      ),
    ));
  }
}
