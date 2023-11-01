
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flikka/Job%20Recruiter/RecruiterRequiredSkills/required_skills.dart';
import 'package:flikka/controllers/AddJobController/AddJobController.dart';
import 'package:flikka/data/response/status.dart';
import 'package:flikka/utils/CommonWidgets.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/SeekerChoosePositionGetController/SeekerChoosePositionGetController.dart';
import '../../controllers/ViewLanguageController/ViewLanguageController.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../../utils/MultiSelectField.dart';


class AddAJobPage extends StatefulWidget {
  const AddAJobPage({super.key});

  @override
  State<AddAJobPage> createState() => _AddAJobPageState();
}

class _AddAJobPageState extends State<AddAJobPage> {

  var _formKey = GlobalKey<FormState>();
  var isLoading = false;

  var qualification ;

  final List<String> itemsEmp = [
    'Full-Time','Part-Time','Contract','Temporary', 'Internship', 'Fresher' ,
  ];
  String? employmentType;


  var jobTypeTitle;
  String? jobTitleName ;

  final List<String> itemsExp = [
    'On-site','Remote','Hybrid'
  ];
  String? workplaceType;

  final List<String> itemQualificaton = [
    'Bachelor degree','Master degree','12th pass', 'Diploma', 'Doctoral degree', '10th pass', 'M.phil'
  ];
  String? qualificatonType;

  List languageList = [];

 AddJobController addJobController = Get.put(AddJobController()) ;
  SeekerChoosePositionGetController seekerChoosePositionGetController =
  Get.put(SeekerChoosePositionGetController());

  ViewLanguageController viewLanguageController = Get.put(ViewLanguageController()) ;

  TextEditingController jobTitleController = TextEditingController() ;
  TextEditingController jobPositionController = TextEditingController() ;
  TextEditingController specializationController = TextEditingController() ;
  TextEditingController jobLocationController = TextEditingController() ;
  TextEditingController jobDescriptionController = TextEditingController() ;
  TextEditingController jobRequirementController = TextEditingController() ;
  TextEditingController languageController = TextEditingController() ;
  TextEditingController educationController = TextEditingController() ;
  TextEditingController experienceController = TextEditingController() ;
  TextEditingController preferredExperienceController = TextEditingController() ;

  @override
  void initState() {
    seekerChoosePositionGetController.seekerGetPositionApi(false) ;
    viewLanguageController.viewLanguageApi() ;
    super.initState();
  }

  final ScrollController scrollController =ScrollController() ;


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (viewLanguageController.rxRequestStatus.value) {
        case Status.LOADING:
          return const
          Scaffold(body: Center(child: CircularProgressIndicator()),);

        case Status.ERROR:
          if (viewLanguageController.error.value ==
              'No internet') {
            return InterNetExceptionWidget(
              onPress: () {},
            );
          } else {
            return Scaffold(body: GeneralExceptionWidget(
                onPress: () {}));
          }
        case Status.COMPLETED:
      return
      Obx( () => seekerChoosePositionGetController.rxRequestStatus.value == Status.LOADING ?
    const Center(child: CircularProgressIndicator(),) :
       Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0,vertical: 10),
        child: Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Image.asset('assets/images/icon_back_blue.png')),
            ),
            elevation: 0,
            title: Text("Add A Job",style: Get.theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
            // actions: [
            //   TextButton(onPressed: (){}, child: Text('Post',style: Get.theme.textTheme.labelMedium!.copyWith(color: Color(0xff56B8F6)),))
            // ],
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0,right: 15),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height*0.03,),
                    Center(
                      child: Stack(
                          children:[
                            Container(
                              height: Get.height*0.20,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color: const Color(0xff353535),
                                  borderRadius: BorderRadius.circular(22)
                              ),
                              child:imgFile?.path == null ?
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                              InkWell(
                                onTap: () async {
                                  _openImagePickerDialog();
                                  print("This is imgfile ${imgFile?.path}");
                                },
                                child: Stack(
                                  clipBehavior: Clip.none,
                                    children:[
                                      Image.asset('assets/images/icon_gallery.png',height: Get.height*.052,color: AppColors.blueThemeColor,),
                                      Positioned(
                                          bottom: -2,
                                          right: -2,
                                          child: Image.asset('assets/images/icon_Add_photo.png',height: Get.height*.021,)
                                      ),
                                    ] ),
                              ),
                              SizedBox(height: Get.height*0.02,),
                              Text("Select feature image",style: Get.theme.textTheme.bodySmall!.copyWith(color: Color(0xffCFCFCF)),),
                                  ],
                                ) :
                                  Image.file(imgFile! , fit: BoxFit.cover,),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: imgFile == null ?
                                  SizedBox() :
                              IconButton(onPressed: () {
                                _openImagePickerDialog();
                              }, icon: Icon(Icons.edit,color: Colors.white,size: 28,)),
                            ),
                          ]
                      ),),
                    Obx(() => addJobController.featureImageError.value.isEmpty ?
                    const SizedBox() :
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(addJobController.featureImageError.value,style: TextStyle(color: Colors.red),))
                    ) ,
                    SizedBox(height: Get.height*0.04,),
                    Text('Job Title',style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                    SizedBox(height: Get.height*0.01,),
                    TextFormField(
                      controller: jobPositionController,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                        border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: const BorderSide(color: Color(0xff373737))
                        ),
                        fillColor: Color(0xff373737),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: Get.width *0.04,vertical: Get.height*.027),
                        enabledBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                          //borderSide: BorderSide(color: Colors.white),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(35.0)),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        disabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(35.0)),
                          borderSide: BorderSide(color: Color(0xff373737)),
                        ),
                        hintText: 'Add job title ',
                        hintStyle:  Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),
                      ),
                      onFieldSubmitted: (value) {

                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: Get.height*0.03,),
                    Text('Job position',style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                    SizedBox(height: Get.height*0.01,),
                    Container(
                      alignment: Alignment.center,
                      padding:  EdgeInsets.only(left: Get.width *0.04,right: Get.width *0.05 ,top: Get.height*.0065,bottom: Get.height*.0065),
                      decoration: BoxDecoration(
                        color: const Color(0xff373737),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: Center(
                        child:
                        DropdownButtonHideUnderline(
                          child: DropdownButton(
                            alignment: Alignment.centerLeft,
                            borderRadius: BorderRadius.circular(20),
                            isExpanded: true,
                            value: jobTitleName,
                            hint:  Text(
                              'Add Position',
                              style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),
                              overflow: TextOverflow.ellipsis,
                            ),
                            items: seekerChoosePositionGetController.seekerChoosePositionGetList.value.data
                                ?.map((item) => DropdownMenuItem(
                              value: item.positions,
                              onTap: () {
                                setState(() {
                                  jobTypeTitle = item.id ;
                                  jobTitleName = item.positions ;
                                });
                                },
                              child: Text(
                                "${ item.positions}",
                                style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )).toList(),
                            elevation: 2,
                            onChanged: (String? value) {  },
                          ),

                        ),
                      ),
                    ),
                    Obx(() => addJobController.jobPositionErrorMessage.value.isEmpty ?
                    const SizedBox() :
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(addJobController.jobPositionErrorMessage.value,style: TextStyle(color: Colors.red),))
                    ) ,
                    SizedBox(height: Get.height*0.03,),
                    Text('Specialization',style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                    SizedBox(height: Get.height*0.01,),
                    TextFormField(
                      controller: specializationController,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                        border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: const BorderSide(color: Color(0xff373737))
                        ),
                        fillColor: Color(0xff373737),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: Get.width *0.04,vertical: Get.height*.027),
                        enabledBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                          //borderSide: BorderSide(color: Colors.white),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(35.0)),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        disabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(35.0)),
                          borderSide: BorderSide(color: Color(0xff373737)),
                        ),
                        hintText: 'Add Specialization',
                        hintStyle:  Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),
                      ),
                      onFieldSubmitted: (value) {

                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is empty';
                        }
                        return null;
                      },

                    ),

                    SizedBox(height: Get.height*0.03,),
                    Text('Job location',style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                    SizedBox(height: Get.height*0.01,),
                    TextFormField(
                      controller: jobLocationController,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                          border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                              borderSide: BorderSide(color: Color(0xff373737))
                          ),
                          fillColor: Color(0xff373737),
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: Get.width *0.04,vertical: Get.height*.027),
                          enabledBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            //borderSide: BorderSide(color: Colors.white),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(35.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(35.0)),
                            borderSide: BorderSide(color: Color(0xff373737)),
                          ),
                          hintText: 'Add location',
                          hintStyle:  Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF))
                      ),
                      onFieldSubmitted: (value) {

                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is empty';
                        }
                        return null;
                      },

                    ),

                    SizedBox(height: Get.height*0.03,),
                    Text('Description',style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                    SizedBox(height: Get.height*0.01,),
                    TextFormField(
                      controller: jobDescriptionController,
                        maxLines: 5,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xff373737),
                          hintText: "Add description",
                            hintStyle:  Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),
                          contentPadding: EdgeInsets.symmetric(horizontal: Get.width *0.04,vertical: Get.height*.027),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(22),
                              borderSide: BorderSide(color: Color(0xff373737))),

                          enabledBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            // borderSide: BorderSide(color: Colors.white),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(22.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(22.0)),
                            borderSide: BorderSide(color: Color(0xff373737)),
                          ),

                        ) ,
                      onFieldSubmitted: (value) {

                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is empty';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: Get.height*0.03,),
                    Text('Requirements',style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                    SizedBox(height: Get.height*0.01,),
                    TextFormField(
                      controller: jobRequirementController,
                        maxLines: 5,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xff373737),
                          hintText: "Add requirements",
                            hintStyle:  Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),
                          contentPadding: EdgeInsets.symmetric(horizontal: Get.width *0.04,vertical: Get.height*.027),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(22),
                              borderSide: BorderSide(color: Color(0xff373737))),
                          enabledBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            // borderSide: BorderSide(color: Colors.white),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(22.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(22.0)),
                            borderSide: BorderSide(color: Color(0xff373737)),
                          ),

                        ) ,
                      onFieldSubmitted: (value) {

                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is empty';
                        }
                        return null;
                      },
                    ),
                    //********************************************
                    SizedBox(height: Get.height*0.03,),
                    Text('Job Type',style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                    SizedBox(height: Get.height*0.01,),
                    Center(
                      child:
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint:  Text(
                            'Select job type',
                            style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                          items: itemsEmp
                              .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                              .toList(),
                          value: employmentType,
                          onChanged: (String? value) {
                            setState(() {
                              employmentType = value;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            height: Get.height*0.08,
                            width: double.infinity,
                            padding:  EdgeInsets.symmetric(horizontal: Get.width*.04, ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),

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
                              color: const Color(0xff353535),
                            ),
                            offset: const Offset(5, 0),
                            scrollbarTheme: ScrollbarThemeData(
                              radius:  const Radius.circular(40),
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
                    Obx(() => addJobController.jobTypeErrorMessage.value.isEmpty ?
                    const SizedBox() :
                    Text(addJobController.jobTypeErrorMessage.value,style: TextStyle(color: Colors.red),)
                    ) ,
                    SizedBox(height: Get.height*0.042,),
                    Text('Type of workplace',style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                    SizedBox(height: Get.height*0.01,),
                    Center(
                      child:
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint:  Text(
                            'Select workplace',
                            style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                          items: itemsExp
                              .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                              .toList(),
                          value: workplaceType,
                          onChanged: (String? value) {
                            setState(() {
                              workplaceType = value;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            height: Get.height*0.08,
                            width: double.infinity,
                            padding:  EdgeInsets.symmetric(horizontal: Get.width*.04, ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),

                              color: const Color(0xff353535),
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
                              color: const Color(0xff353535),
                            ),
                            offset: const Offset(5, 0),
                            scrollbarTheme: ScrollbarThemeData(
                              radius:  const Radius.circular(40),
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
                    Obx(() => addJobController.typeOfWorkPlaceErrorMessage.value.isEmpty ?
                    const SizedBox() :
                    Text(addJobController.typeOfWorkPlaceErrorMessage.value,style: TextStyle(color: Colors.red),)
                    ) ,
                    SizedBox(height: Get.height*0.042,),
                    Text('Work experience',style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                    SizedBox(height: Get.height*0.01,),
                    TextFormField(
                      controller: experienceController,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                          border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                              borderSide: BorderSide(color: Color(0xff373737))
                          ),
                          fillColor: Color(0xff373737),
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: Get.width *0.04,vertical: Get.height*.027),
                          enabledBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            //borderSide: BorderSide(color: Colors.white),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(35.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(35.0)),
                            borderSide: BorderSide(color: Color(0xff373737)),
                          ),
                          hintText: 'Add work experience',
                          hintStyle:  Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF))
                      ),
                      onFieldSubmitted: (value) {

                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is empty';
                        }
                        return null;
                      },

                    ),

                    SizedBox(height: Get.height*0.042,),
                    Text('Preferred work experience',style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                    SizedBox(height: Get.height*0.01,),
                    TextFormField(
                      controller: preferredExperienceController,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                          border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                              borderSide: const BorderSide(color: Color(0xff373737))
                          ),
                          fillColor: const Color(0xff373737),
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: Get.width *0.04,vertical: Get.height*.027),
                          enabledBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            //borderSide: BorderSide(color: Colors.white),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(35.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(35.0)),
                            borderSide: BorderSide(color: Color(0xff373737)),
                          ),
                          hintText: 'Add Preferred work experience',
                          hintStyle:  Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF))
                      ),
                      onFieldSubmitted: (value) {

                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is empty';
                        }
                        return null;
                      },

                    ),

                    SizedBox(height: Get.height*0.042,),
                    Text('Qualification',style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                    SizedBox(height: Get.height*0.01,),
                    Center(
                      child:
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint:  Text(
                            'Select qualification',
                            style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                          items: itemQualificaton
                              .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                              .toList(),
                          value: qualificatonType,
                          onChanged: (String? value) {
                            setState(() {
                              qualificatonType = value;
                              qualification = value;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            height: Get.height*0.08,
                            width: double.infinity,
                            padding:  EdgeInsets.symmetric(horizontal: Get.width*.04, ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),

                              color: const Color(0xff353535),
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
                              color: const Color(0xff353535),
                            ),
                            offset: const Offset(5, 0),
                            scrollbarTheme: ScrollbarThemeData(
                              radius:  const Radius.circular(40),
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
                    // TextFormField(
                    //   controller: educationController,
                    //   style: Theme.of(context).textTheme.bodyMedium,
                    //   decoration: InputDecoration(
                    //       border:OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(35),
                    //           borderSide: BorderSide(color: Color(0xff373737))
                    //       ),
                    //       fillColor: const Color(0xff373737),
                    //       filled: true,
                    //       contentPadding: EdgeInsets.symmetric(horizontal: Get.width *0.04,vertical: Get.height*.027),
                    //       enabledBorder:  OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(35),
                    //         //borderSide: BorderSide(color: Colors.white),
                    //       ),
                    //       errorBorder: const OutlineInputBorder(
                    //         borderRadius: BorderRadius.all(Radius.circular(35.0)),
                    //         borderSide: BorderSide(color: Colors.red),
                    //       ),
                    //       disabledBorder: const OutlineInputBorder(
                    //         borderRadius: BorderRadius.all(Radius.circular(35.0)),
                    //         borderSide: BorderSide(color: Color(0xff373737)),
                    //       ),
                    //       hintText: 'Add qualification',
                    //       hintStyle:  Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF))
                    //   ),
                    //
                    //   onFieldSubmitted: (value) {
                    //
                    //   },
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'This field is empty';
                    //     }
                    //     return null;
                    //   },
                    // ),

                    SizedBox(height: Get.height*0.042,),
                    Text('Language',style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                    SizedBox(height: Get.height*0.01,),
                    LanguageSelector(selectedLanguageList: languageList,languageList: viewLanguageController.viewLanguageData.value.languages,),
                    // TextFormField(
                    //   controller: languageController,
                    //   style: Theme.of(context).textTheme.bodyMedium,
                    //   decoration: InputDecoration(
                    //       border:OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(35),
                    //           borderSide: const BorderSide(color: Color(0xff373737))
                    //       ),
                    //       fillColor: const Color(0xff373737),
                    //       filled: true,
                    //       contentPadding: EdgeInsets.symmetric(horizontal: Get.width *0.04,vertical: Get.height*.027),
                    //       enabledBorder:  OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(35),
                    //         //borderSide: BorderSide(color: Colors.white),
                    //       ),
                    //       errorBorder: const OutlineInputBorder(
                    //         borderRadius: BorderRadius.all(Radius.circular(35.0)),
                    //         borderSide: BorderSide(color: Colors.red),
                    //       ),
                    //       disabledBorder: const OutlineInputBorder(
                    //         borderRadius: BorderRadius.all(Radius.circular(35.0)),
                    //         borderSide: BorderSide(color: Color(0xff373737)),
                    //       ),
                    //       hintText: 'Add language',
                    //       hintStyle:  Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF))
                    //   ),
                    //   onFieldSubmitted: (value) {
                    //
                    //   },
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'This field is empty';
                    //     }
                    //     return null;
                    //   },
                    //   ),

                    SizedBox(height: Get.height*0.065,),

                    Obx( () =>
                       Center(
                        child: MyButton(
                          loading: addJobController.loading.value,
                            title: 'Continue', onTap1: (){
                          addJobController.featureImageError.value = "" ;
                          addJobController.jobTypeErrorMessage.value = "" ;
                          addJobController.typeOfWorkPlaceErrorMessage.value = "" ;
                          addJobController.jobPositionErrorMessage.value = "" ;
                          if(imgFile == null) {
                            addJobController.featureImageError.value = "Please select image" ;
                            scrollController.animateTo(0, duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
                          }

                         else if(_formKey.currentState!.validate()) {
                            if (jobTitleName == null) {
                              addJobController.jobPositionErrorMessage.value =
                              "Please select job position";
                            } else if (employmentType == null) {
                              addJobController.jobTypeErrorMessage.value =
                              "Please select job type";
                            } else if (workplaceType == null) {
                              addJobController.typeOfWorkPlaceErrorMessage.value =
                              "Please select type of workplace";
                            } else {
                              addJobController.addJobApi(
                                imgFile?.path,
                                jobTypeTitle,
                                jobPositionController.text,
                                specializationController.text,
                                jobLocationController.text,
                                jobDescriptionController.text,
                                employmentType.toString(),
                                workplaceType.toString(),
                                jobRequirementController.text,
                                experienceController.text,
                                preferredExperienceController.text,
                                  qualification.toString(),
                                  LanguageSelectorState.languages
                              );
                            }
                          }
                                // Get.to(()=> const RequiredSkills());
                        }),
                      ),
                    ),
                    SizedBox(height: Get.height*0.08,),
                  ],
                ),
              ),
            ),
          ),
        )
                )
      );
      }
    }
    );
  }

  Future<void> _openImagePickerDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff373737),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          title:Center(
            child: Text(
              'Please choose image',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600,fontSize: 18),
            ),
          ),
          // content: Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     GestureDetector(
          //       child: const Icon(
          //         Icons.camera_alt_outlined,
          //         color: Colors.white,
          //       ),
          //       onTap: () {
          //         _pickImage(ImageSource.camera);
          //       },
          //     ),
          //     GestureDetector(
          //       child: const Icon(
          //         Icons.photo_library,
          //         color: Colors.white,
          //       ),
          //       onTap: () {
          //         _pickImage(ImageSource.gallery);
          //       },
          //     ),
          //   ],
          // ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyButton(
                width: Get.width*.25,
                height: Get.height*.05,
                title: "Camera", onTap1: () {
                _pickImage(ImageSource.camera);
              },),
              SizedBox(width: 10,) ,
              MyButton(
                width: Get.width*.25,
                height: Get.height*.05,
                title: "Gallery", onTap1: () {
                _pickImage(ImageSource.gallery);
              },),
            ],
          ),
        );
      },
    );
  }

  final imgPicker = ImagePicker();
  File? imgFile;
  Future<void> _pickImage(abc) async {
    var imgCamera = await imgPicker.pickImage(source: abc);
    setState(() {
      imgFile = File(imgCamera!.path);
      print(imgFile);
    });
    Get.back();
  }

}
