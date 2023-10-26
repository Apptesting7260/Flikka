import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flikka/Job%20Seeker/SeekerBottomNavigationBar/tab_bar.dart';
import 'package:flikka/Payment_Methods/wallet.dart';
import 'package:flikka/controllers/EditAboutController/EditAboutController.dart';
import 'package:flikka/controllers/EditSeekerAppreciationController/EditSeekerAppreciationController.dart';
import 'package:flikka/controllers/EditSeekerPofileController/EditSeekerProfileController.dart';
import 'package:flikka/controllers/EditSeekerResumeController/EditSeekerResumeController.dart';
import 'package:flikka/controllers/EditSeekerWorkExperience/EditSeekerWorkExperience.dart';
import 'package:flikka/controllers/SeekerChoosePositionGetController/SeekerChoosePositionGetController.dart';
import 'package:flikka/controllers/ViewSeekerProfileController/ViewSeekerProfileController.dart';
import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/ViewSeekerProfileModel/ViewSeekerProfileModel.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../res/components/general_expection.dart';
import '../../../res/components/internet_exception_widget.dart';
import '../../../utils/CommonWidgets.dart';


class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  SeekerChoosePositionGetController seekerChoosePositionGetController = Get.put(SeekerChoosePositionGetController());

  Future<void> _openImagePickerDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff373737),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none),
          title: Center(
            child: Text(
              'Please choose image',
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyButton(
                width: Get.width * .25,
                height: Get.height * .05,
                title: "Camera", onTap1: () {
                _pickImage(ImageSource.camera);
              },),
              const SizedBox(width: 10,),
              MyButton(
                width: Get.width * .25,
                height: Get.height * .05,
                title: "Gallery", onTap1: () {
                _pickImage(ImageSource.gallery);
              },),
            ],
          ),
        );
      },
    );
  }

  File? imageFile;
  String resumePath = '';
  final imgPicker = ImagePicker();
  final imageCropper = ImageCropper();

  Future<void> _pickImage(abc) async {
    final pickedImage = await ImagePicker().pickImage(source: abc);

    if (pickedImage != null) {
      final croppedImage = await imageCropper.cropImage(
        sourcePath: pickedImage.path,
        aspectRatio: const CropAspectRatio(
            ratioX: 1.5, ratioY: 2), // Adjust aspect ratio as needed
        compressQuality: 40, // Adjust compression quality as needed
      );

      setState(() {
        imageFile = File(croppedImage!.path);
        editSeekerProfileController.profileApi(
            imageFile?.path, "", "", "", context);
        print(imageFile);
        Get.back();
      });
    }
  }


  String uri = '';

  //********************* for aboutsectionedition *************
  EditAboutController editAboutController = Get.put(EditAboutController());

  EditSeekerProfileController editSeekerProfileController = Get.put(EditSeekerProfileController());
  EditSeekerExperienceController editSeekerExperienceController = Get.put(EditSeekerExperienceController()) ;
  EditSeekerAppreciationController editSeekerAppreciationController = Get.put(EditSeekerAppreciationController()) ;
  EditSeekerResumeController editSeekerResumeController = Get.put(EditSeekerResumeController()) ;

  aboutSection(String? about) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        editAboutController.loading.value = false;
        TextEditingController aboutSectionController = TextEditingController();
        aboutSectionController.text = about ?? "";
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontSize: 13),
                  onChanged: (String value) {
                  },
                  controller: aboutSectionController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xff373737),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(33),
                        borderSide: BorderSide.none
                    ),
                    hintText: 'Enter about',
                    hintStyle: Theme
                        .of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors.white, fontSize: 12),
                  ),
                ),
                SizedBox(height: Get.height * 0.02,),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(
                      width: 100,
                      height: 40,
                      onTap1: () {
                        Navigator.of(context).pop();
                      }, title: 'Cancel',
                    ),
                    const SizedBox(width: 20,),
                    Obx(() =>
                        MyButton(
                          width: 100,
                          height: 40,
                          loading: editAboutController.loading.value,
                          onTap1: () {
                            editAboutController.aboutApi(
                                aboutSectionController.text, context);
                          },
                          title: 'Submit',
                        ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.02,),
              ],
            ),
          ),
        );
      },
    );
  }

  introSection(String? name,
      String? location,
      String? positions,
      var id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        editSeekerProfileController.loading.value = false;
        TextEditingController nameController = TextEditingController();
        TextEditingController locationController = TextEditingController();
        var positionId;
        nameController.text = name ?? "";
        locationController.text = location ?? "";
        positionId = id;
        var selectedPosition;
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Obx(() =>
                  Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22)),
                    insetPadding: const EdgeInsets.symmetric(horizontal: 20),
                    child: seekerChoosePositionGetController.loading.value ?
                    const CircularProgressIndicator()
                        : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontSize: 13),
                            onChanged: (String value) {
                              setState(() => uri = value);
                            },
                            controller: nameController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xff373737),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(33),
                                borderSide: BorderSide.none
                              ),
                              hintText: 'Enter name',
                              hintStyle: Theme
                                  .of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                  color: AppColors.white, fontSize: 12),
                            ),
                          ),
                          SizedBox(height: Get.height * 0.02,),
                          TextField(
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontSize: 13),
                            onChanged: (String value) {
                              setState(() => uri = value);
                            },
                            controller: locationController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xff373737),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(33),
                                  borderSide: BorderSide.none
                              ),
                              hintText: 'Enter location',
                              hintStyle: Theme
                                  .of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                  color: AppColors.white, fontSize: 12),
                            ),
                          ),
                          SizedBox(height: Get.height * 0.02,),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(33),
                              color: Color(0xff373737),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                padding: EdgeInsets.symmetric(horizontal: Get.width*.04,vertical: Get.height*.01),
                                isExpanded: true,
                                value: selectedPosition,
                                hint: Text(
                                  positions ?? "Select Position",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                      color: const Color(0xffCFCFCF)),
                                ),
                                items: seekerChoosePositionGetController
                                    .seekerChoosePositionGetList.value.data?.map((
                                    document) {
                                  return DropdownMenuItem(
                                    value: document.positions,
                                    child: Text("${document.positions}",
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .bodyMedium),
                                    onTap: () {
                                      setState(() {
                                        positionId = document.id;
                                        print(positionId);
                                        selectedPosition = document.positions!;
                                      });
                                    },
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  // setState(() {
                                  //   selectedPosition = value.toString();
                                  // });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: Get.height * .02,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyButton(
                                width: 100,
                                height: 40,
                                onTap1: () {
                                  Navigator.of(context).pop();
                                }, title: 'Cancel',
                              ),
                              const SizedBox(width: 20,),
                              Obx(() =>
                                  MyButton(
                                    width: 100,
                                    height: 40,
                                    loading: editSeekerProfileController.loading
                                        .value,
                                    onTap1: () {
                                      editSeekerProfileController.profileApi(
                                          null, nameController.text,
                                          locationController.text, positionId,
                                          context
                                      );
                                    },
                                    title: 'Submit',
                                  ),
                              ),
                            ],
                          ),
                          SizedBox(height: Get.height * 0.02,),
                        ],
                      ),
                    ),
                  ),
              );
            }
        );
      },
    );
  }

  //********************* for workexperience *************
  TextEditingController workexperienceController = TextEditingController();

  workExperienceSection(
      bool experience ,
      String? job ,
      String? company ,
      String? startDate ,
      String? endDate ,
      int index ,
  {
    bool? add
  }
      ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final key = GlobalKey<FormState>() ;
        final startDateKey = GlobalKey<FormState>() ;
        final endDateKey = GlobalKey<FormState>() ;
        TextEditingController jobTitleOrEducationLevelController = TextEditingController();
        TextEditingController companyOrInstituteController = TextEditingController();
        _startDateController.text = startDate ?? "" ;
        _endDateController.text = endDate ?? "" ;
        companyOrInstituteController.text = company ?? "" ;
        jobTitleOrEducationLevelController.text = job ?? "" ;
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: key,
                  child: Column(
                    children: [
                      TextFormField(
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 13),
                        onChanged: (String value) {

                        },
                        controller: jobTitleOrEducationLevelController,
                        decoration: InputDecoration(
                          hintText: experience ?  'Enter job title' : "Enter education level",
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: AppColors.white, fontSize: 12),
                        ),
                        validator: (value) {
                          if(value == null || value.isEmpty) {
                            return 'Please fill this field' ;
                          }
                        },
                      ),
                      SizedBox(height: Get.height* 0.02,) ,
                      TextFormField(
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 13),
                        onChanged: (String value) {

                        },
                        controller: companyOrInstituteController,
                        decoration: InputDecoration(
                          hintText: experience ? 'Enter company name' : 'Enter institute name',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: AppColors.white, fontSize: 12),
                        ),
                        validator: (value) {
                          if(value == null || value.isEmpty) {
                            return 'Please fill this field' ;
                          }
                        },
                      ),
                      SizedBox(height: Get.height* 0.02,),
                    ],
                  ),
                ) ,
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment
                      .start,
                  children: [
                    Expanded(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: CommonWidgets
                                  .textFieldHeading(
                                  context, "Start date"),
                            ),
                            SizedBox(
                              height: Get.height * .01,
                            ),
                            Form(
                              key: startDateKey,
                              child: TextFormField(
                                controller: _startDateController,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                    color: Color(0xffCFCFCF),
                                    fontSize: 12,
                                    fontWeight: FontWeight
                                        .w400),
                                onTap: () => _selectDate(true,context,"") ,
                                readOnly: true,
                                decoration: InputDecoration(
                                  errorStyle: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight
                                          .w300,
                                      fontSize: 12),
                                  constraints: const BoxConstraints(
                                    //maxWidth: Get.width * 0.41,
                                  ),
                                  filled: true,
                                  fillColor: const Color(
                                      0xff373737),
                                  hintText: "Select date",
                                  contentPadding: EdgeInsets
                                      .symmetric(
                                      vertical: Get.height *
                                          .027,
                                      horizontal: Get.width *
                                          .06),
                                  hintStyle: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                      color: Color(0xffCFCFCF),
                                      fontSize: 12,
                                      fontWeight: FontWeight
                                          .w400),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(35),
                                      borderSide: BorderSide
                                          .none),
                                  suffixIcon: const Icon(
                                    Icons.calendar_month,
                                    size: 13,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty) {
                                    return 'Select start date';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      width: Get.width * .04,
                    ),
                    Expanded(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: CommonWidgets
                                  .textFieldHeading(
                                  context, "End date"),
                            ),
                            SizedBox(
                              height: Get.height * .01,
                            ),
                            Form(key : endDateKey,
                              child: TextFormField(
                                controller: _endDateController,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: const Color(0xffCFCFCF), fontSize: 12,
                                    fontWeight: FontWeight.w400),
                                onTap: () {
                                  if(startDateKey.currentState!.validate()) {
                                    _selectDate(false,context,_startDateController.text) ;
                                  }
                                },
                                readOnly: true,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xff373737),
                                  hintText: "Select date",
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: Get.height * .027,
                                      horizontal: Get.width * .06),
                                  hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: const Color(0xffCFCFCF),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(35),
                                      borderSide: BorderSide.none
                                  ),
                                  suffixIcon: const Icon(
                                    Icons.calendar_month,
                                    size: 13,
                                  ),
                                ),
                              ),
                            ),

                          ],
                        )),
                  ],
                ),
                SizedBox(height: Get.height*.02,) ,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(
                      width: 100,
                      height: 40,
                      onTap1: () {
                        Navigator.of(context).pop();
                      }, title: 'Cancel',
                    ),
                    const SizedBox(width: 20,) ,
                    Obx( () =>
                     MyButton(
                        width: 100,
                        height: 40,
                        loading: editSeekerExperienceController.loading.value,
                        onTap1: () {
                          if(key.currentState!.validate()) {
                            if (experience == true) {
                              WorkExpJob experienceData = WorkExpJob() ;
                              if (add == true) {
                                experienceData.workExpJob = jobTitleOrEducationLevelController.text ;
                                experienceData.companyName = companyOrInstituteController.text ;
                                experienceData.jobStartDate = _startDateController.text ;
                                experienceData.jobEndDate = _endDateController.text ;
                                debugPrint("this is experience ${experienceData.companyName}") ;
                                seekerProfileController.viewSeekerData.value.workExpJob?.add(experienceData);
                                debugPrint("this is experience list ${seekerProfileController.viewSeekerData.value.workExpJob}") ;
                                editSeekerExperienceController.workApi(true, seekerProfileController.viewSeekerData.value.workExpJob, context);
                              } else {
                                seekerProfileController.viewSeekerData.value.workExpJob?[index]
                                    .workExpJob = jobTitleOrEducationLevelController.text;
                                seekerProfileController.viewSeekerData.value.workExpJob?[index]
                                    .companyName = companyOrInstituteController.text;
                                seekerProfileController.viewSeekerData.value.workExpJob?[index]
                                    .jobStartDate = _startDateController.text;
                                seekerProfileController.viewSeekerData.value.workExpJob?[index]
                                    .jobEndDate = _endDateController.text;
                                editSeekerExperienceController.workApi(true,
                                    seekerProfileController.viewSeekerData.value.workExpJob, context);
                              }
                            } else {
                              EducationLevel educationData = EducationLevel() ;
                              if (add == true) {
                                educationData.educationLevel = jobTitleOrEducationLevelController.text ;
                                educationData.institutionName = companyOrInstituteController.text ;
                                educationData.educationStartDate = _startDateController.text ;
                                educationData.educationEndDate = _endDateController.text ;
                                seekerProfileController.viewSeekerData.value.seekerDetails?.educationLevel?.add(educationData) ;
                                editSeekerExperienceController.workApi(false, seekerProfileController.viewSeekerData.value
                                        .seekerDetails?.educationLevel, context);
                              } else {
                                seekerProfileController.viewSeekerData.value
                                    .seekerDetails?.educationLevel?[index]
                                    .educationLevel = jobTitleOrEducationLevelController.text;
                                seekerProfileController.viewSeekerData.value
                                    .seekerDetails?.educationLevel?[index]
                                    .institutionName = companyOrInstituteController.text;
                                seekerProfileController.viewSeekerData.value
                                    .seekerDetails?.educationLevel?[index]
                                    .educationStartDate = _startDateController.text;
                                seekerProfileController.viewSeekerData.value
                                    .seekerDetails?.educationLevel?[index]
                                    .educationEndDate = _endDateController.text;
                                editSeekerExperienceController.workApi(
                                    false,
                                    seekerProfileController.viewSeekerData.value
                                        .seekerDetails?.educationLevel,
                                    context);
                              }
                            }
                          }
                        }, title: 'Submit',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height* 0.02,) ,
              ],
            ),
          ),
        );
      },
    );
  }

  //********************* for education *************
  TextEditingController educationController = TextEditingController();

  //********************* for skill *************
  TextEditingController skillController = TextEditingController();

  void skill() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)),
          title: Text(
            "Add skill",
            style: Theme
                .of(context)
                .textTheme
                .displayLarge,
          ),
          content: TextField(
            style: Theme
                .of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontSize: 15),
            onChanged: (String value) {
              setState(() => uri = value);
            },
            controller: skillController,
            decoration: InputDecoration(
              hintText: 'Write your skill',
              hintStyle: Theme
                  .of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.white, fontSize: 16),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: Theme
                    .of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Submit",
                style: Theme
                    .of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                // Implement comment submission logic here
                // You can use the commentController.text to access the comment text
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //********************* for language *************
  TextEditingController languageController = TextEditingController();

  void language() {
    showDialog(
      //barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)),
          title: Text(
            "Add language",
            style: Theme
                .of(context)
                .textTheme
                .displayLarge,
          ),
          content: TextField(
            style: Theme
                .of(context)
                .textTheme
                .displayLarge
                ?.copyWith(fontSize: 15),
            onChanged: (String value) {
              setState(() => uri = value);
            },
            controller: languageController,
            decoration: InputDecoration(
              hintText: 'Write your language',
              hintStyle: Theme
                  .of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.white, fontSize: 16),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: Theme
                    .of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Submit",
                style: Theme
                    .of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                // Implement comment submission logic here
                // You can use the commentController.text to access the comment text
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //********************* for appreciation *************
  TextEditingController appreciationController = TextEditingController();

  appreciation(
      int index ,
      String? award ,
      String? achievement ,
      {
        bool? add
      }
      ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final key = GlobalKey<FormState>() ;
        TextEditingController awardController = TextEditingController() ;
        TextEditingController achievementController = TextEditingController() ;
        awardController.text = award ?? "" ;
        achievementController.text = achievement ?? "" ;
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: key,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 13),
                    onChanged: (String value) {},
                    controller: awardController,
                    decoration: InputDecoration(
                      hintText: "Enter award name",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: AppColors.white, fontSize: 12),
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return 'Please fill this field' ;
                      }
                    },
                  ),
                  SizedBox(height: Get.height* 0.02,) ,
                  TextFormField(
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 13),
                    onChanged: (String value) {},
                    controller: achievementController,
                    decoration: InputDecoration(
                      hintText: 'Enter achievement',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: AppColors.white, fontSize: 12),
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return 'Please fill this field' ;
                      }
                    },
                  ),
                  SizedBox(height: Get.height*.02,) ,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(
                        width: 100,
                        height: 40,
                        onTap1: () {
                          Navigator.of(context).pop();
                        }, title: 'Cancel',
                      ),
                      const SizedBox(width: 20,) ,
                      Obx( () =>
                          MyButton(
                            width: 100,
                            height: 40,
                            loading: editSeekerAppreciationController.loading.value,
                            onTap1: () {
                              if(key.currentState!.validate()) {
                                // List? list = [] ;
                                Appreciation appreciationData = Appreciation() ;
                                if (add == true) {
                                  appreciationData.achievement = achievementController.text ;
                                  appreciationData.awardName = awardController.text ;
                                  seekerProfileController.viewSeekerData.value.seekerDetails?.appreciation?.add(appreciationData) ;
                                  // list = seekerProfileController.viewSeekerData.value.seekerDetails?.appreciation ;
                                  // list?.add(appreciationData) ;
                                  // print("this ======================= $list") ;
                                  editSeekerAppreciationController.appreciationApi(seekerProfileController.viewSeekerData.value.seekerDetails?.appreciation, context);
                                } else {
                                  seekerProfileController.viewSeekerData.value
                                      .seekerDetails?.appreciation?[index]
                                      .awardName = awardController.text;
                                  seekerProfileController.viewSeekerData.value
                                      .seekerDetails?.appreciation?[index]
                                      .achievement = achievementController.text;
                                  editSeekerAppreciationController.appreciationApi(
                                      seekerProfileController.viewSeekerData.value
                                          .seekerDetails?.appreciation, context);
                                }
                              }
                            }, title: 'Submit',
                          ),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height* 0.02,) ,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool isWork = false;
  bool isEducation = false;
  bool isAppreciation = false;
  bool isResume = false;

  ViewSeekerProfileController seekerProfileController = Get.put(
      ViewSeekerProfileController());

  @override
  void initState() {
    seekerProfileController.viewSeekerProfileApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (seekerProfileController.rxRequestStatus.value) {
        case Status.LOADING:
          return const
          Scaffold(body: Center(child: CircularProgressIndicator()),);

        case Status.ERROR:
          if (seekerProfileController.error.value ==
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
            SafeArea(
              child: Scaffold(
                body: Stack(
                  children: [
                    Obx( () => editSeekerProfileController.loadingImage.value ?
                         Container( height: Get.height * 0.55,
                            alignment: Alignment.center,
                            child:const CircularProgressIndicator()) :
                      CachedNetworkImage(
                        fit: BoxFit.cover,
                        height: Get.height * 0.5,
                        width: Get.width,
                        placeholder: (context, url) => const Center(child:CircularProgressIndicator()),
                        imageUrl:  "${seekerProfileController.viewSeekerData.value.seekerInfo?.profileImg}" ,),
                    ) ,
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Get.height * .02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.offAll(TabScreen(index: 0)) ;
                                },
                                  child: Image.asset("assets/images/icon_back_blue.png",height: Get.height*.055,)) ,
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: CircularPercentIndicator(
                                  percent: seekerProfileController
                                      .viewSeekerData.value.completeProfile /
                                      100,
                                  lineWidth: 3,
                                  center: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${seekerProfileController.viewSeekerData
                                            .value.completeProfile}%",
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                            color: AppColors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        "Profile",
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                            color: AppColors.white,
                                            fontSize: 8,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  progressColor: const Color(0xff56B8F6),
                                  backgroundColor: AppColors
                                      .ratingcommentfillcolor,
                                  radius: 25, // Background color
                                ),
                              ),
                            ],
                          ) ,

                          SizedBox(
                            height: Get.height * .25,
                          ),

                          Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Get.to(() => const Wallet());
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 42,
                                    width: 42,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        // gradient: LinearGradient(
                                        //   colors: [
                                        //     Color(0xff56B8F6),
                                        //     Color(0xff4D6FED)
                                        //   ],
                                        // )
                                        color: AppColors.blueThemeColor
                                    ),
                                    child: Image.asset("assets/images/wallet_icon.png", height: 18,),
                                  )),
                              SizedBox(width: Get.width * .04,),
                              GestureDetector(
                                onTap: () {
                                  _openImagePickerDialog();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 42,
                                  width: 42,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    // gradient: LinearGradient(
                                    //   colors: [
                                    //     Color(0xff56B8F6),
                                    //     Color(0xff4D6FED)
                                    //   ],
                                    //   begin: Alignment.topLeft,
                                    //   end: Alignment.bottomRight,
                                    // ),
                                      color: AppColors.blueThemeColor
                                  ),
                                  child: Image.asset(
                                    "assets/images/camera.png",
                                    height: 18,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    DraggableScrollableSheet(
                      initialChildSize: 0.5, // half screen
                      minChildSize: 0.5, // half screen
                      maxChildSize: 1, // full screen
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return
                          Container(decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(35),
                                topLeft: Radius.circular(35),
                              ),
                            ),
                            child: ListView(
                              controller: scrollController,
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(24),
                                    decoration: const BoxDecoration(
                                        color: AppColors.black,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            topRight: Radius.circular(25))
                                    ),
                                    //height: Get.height,
                                    //width: Get.width,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            SizedBox(width: Get.width * 0.6,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    "${seekerProfileController
                                                        .viewSeekerData.value
                                                        .seekerInfo?.fullname}",
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .displayLarge,
                                                    softWrap: true,
                                                  ),
                                                  Text(
                                                      "${seekerProfileController
                                                          .viewSeekerData.value
                                                          .seekerDetails
                                                          ?.positions}",
                                                      style: Theme
                                                          .of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                          color: const Color(
                                                              0xffCFCFCF),
                                                          fontWeight: FontWeight
                                                              .w600)
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * .003,),
                                                  Text(
                                                    "${seekerProfileController
                                                        .viewSeekerData.value
                                                        .seekerInfo?.location}",
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                        color: AppColors
                                                            .ratingcommenttextcolor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  introSection(
                                                      seekerProfileController
                                                          .viewSeekerData.value
                                                          .seekerInfo?.fullname,
                                                      seekerProfileController
                                                          .viewSeekerData.value
                                                          .seekerInfo?.location,
                                                      seekerProfileController
                                                          .viewSeekerData.value
                                                          .seekerDetails
                                                          ?.positions,
                                                      seekerProfileController
                                                          .viewSeekerData.value
                                                          .seekerDetails
                                                          ?.position
                                                  );
                                                  seekerChoosePositionGetController
                                                      .seekerGetPositionApi(
                                                      true);
                                                },
                                                child: Image.asset(
                                                  "assets/images/icon_edit.png",
                                                  height: 18,))
                                          ],
                                        ),
                                        SizedBox(height: Get.height * 0.04,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              children: [
                                                InkWell(

                                                    child: SvgPicture.asset(
                                                        'assets/images/aboutsvg.svg')),
                                                SizedBox(
                                                  width: Get.width * 0.02,),
                                                Text('About me',
                                                  style: Get.theme.textTheme
                                                      .labelMedium!.copyWith(
                                                      color: AppColors.white),),
                                              ],
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  aboutSection(
                                                      seekerProfileController
                                                          .viewSeekerData.value
                                                          .seekerInfo?.aboutMe);
                                                },
                                                child: Image.asset(
                                                  "assets/images/icon_edit.png",
                                                  height: 18,))
                                          ],
                                        ),
                                        SizedBox(height: Get.height * 0.01,),
                                        const Divider(
                                          thickness: 0.2,
                                          color: AppColors.white,
                                        ),
                                        SizedBox(height: Get.height * 0.01,),
                                        Text(
                                          seekerProfileController.viewSeekerData
                                              .value.seekerInfo?.aboutMe ??
                                              "No Data",
                                          textAlign: TextAlign.left,
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                              color: AppColors
                                                  .ratingcommenttextcolor),
                                        ),

                                        //********************* for work ex ***************************
                                        SizedBox(height: Get.height * 0.045,),
                                        Row(mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              children: [
                                                InkWell(

                                                    child: SvgPicture.asset(
                                                        'assets/images/experisvg.svg')),
                                                SizedBox(
                                                  width: Get.width * 0.02,),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .only(
                                                      top: 4.0),
                                                  child: Text('Work experience',
                                                    style: Get.theme.textTheme
                                                        .labelMedium!.copyWith(
                                                        color: AppColors
                                                            .white),),
                                                ),
                                              ],
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  workExperienceSection(true,"","","","",0,add: true);
                                                },
                                                child: Image.asset(
                                                    'assets/images/addicononjobre.png'))
                                          ],
                                        ),
                                        SizedBox(height: Get.height * 0.02,),
                                        const Divider(
                                          thickness: 0.2,
                                          color: AppColors.white,
                                        ),
                                        seekerProfileController.viewSeekerData.value.workExpJob == null ||
                                            seekerProfileController.viewSeekerData.value.workExpJob?.length == 0 ?
                                        const Text('Fresher')
                                            : ListView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: seekerProfileController.viewSeekerData.value.workExpJob?.length,
                                            itemBuilder: (context, index) {
                                              var data = seekerProfileController.viewSeekerData.value.workExpJob?[index];
                                              return Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: Get.height * 0.02,),
                                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text('${data?.workExpJob}',
                                                        style: Get.theme.textTheme.bodyMedium!.copyWith(
                                                            color: AppColors.white, fontWeight: FontWeight.w700),),
                                                      Row(
                                                        children: [
                                                          InkWell(
                                                              onTap: () {
                                                                workExperienceSection(true,data?.workExpJob,data?.companyName , data?.jobStartDate , data?.jobEndDate ,index);
                                                              },
                                                              child:  Image.asset("assets/images/icon_edit.png",height: 18)),
                                                          const SizedBox(width: 16,),
                                                          InkWell(
                                                              onTap: () {
                                                                _openDeleteDialog(index , true) ;
                                                              },
                                                              child: Image.asset('assets/images/deleteicon.png')),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(height: Get.height * 0.01,),
                                                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("${data?.companyName}",
                                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                            color: AppColors.ratingcommenttextcolor, fontWeight: FontWeight.w400),),
                                                      data?.jobEndDate == 'null' || data?.jobStartDate == 'null'
                                                          ? const SizedBox()
                                                          : Text('${data?.jobStartDate} - ${data?.jobEndDate}',
                                                        // "${data?.jobStartDate?.month}/${data?.jobStartDate?.year} - ${data?.jobEndDate?.month}/${data?.jobEndDate?.year}",
                                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                            color: AppColors.ratingcommenttextcolor, fontWeight: FontWeight.w400),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              );
                                            }
                                        ),

                                        // ********************* for Education ***************************

                                        SizedBox(height: Get.height * 0.045,),

                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                          children: [
                                            Row(mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                    child: SvgPicture.asset('assets/images/Educationsvg.svg')),
                                                SizedBox(
                                                  width: Get.width * 0.02,),

                                                Text('Education',
                                                  style: Get.theme.textTheme
                                                      .labelMedium!.copyWith(
                                                      color: AppColors
                                                          .white),),

                                              ],
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  workExperienceSection(false,"","","","",0,add: true);
                                                },
                                                child: Image.asset('assets/images/addicononjobre.png'))
                                          ],
                                        ),
                                        SizedBox(height: Get.height * 0.02,),
                                        const Divider(thickness: 0.2, color: AppColors.white,),
                                        seekerProfileController.viewSeekerData.value.seekerDetails?.educationLevel == null ||
                                            seekerProfileController.viewSeekerData.value.seekerDetails?.educationLevel?.length == 0 ?
                                        const Text("No Data") :
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: seekerProfileController.viewSeekerData.value.seekerDetails?.educationLevel?.length,
                                            itemBuilder: (context, index) {
                                              var data = seekerProfileController.viewSeekerData.value.seekerDetails?.educationLevel?[index];
                                              return Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: Get.height * 0.02,),
                                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text('${data?.educationLevel}',
                                                        style: Get.theme.textTheme.bodyMedium!.copyWith(
                                                            color: AppColors.white, fontWeight: FontWeight.w700),),
                                                      Row(
                                                        children: [
                                                          InkWell(
                                                              onTap: () {
                                                                workExperienceSection(false,data?.educationLevel, data?.institutionName, data?.educationStartDate, data?.educationEndDate, index);
                                                              },
                                                              child: Image.asset('assets/images/editicon2.png')),

                                                          const SizedBox(width: 16,),
                                                          InkWell(
                                                              onTap: () {
                                                                _openDeleteDialog(index , false) ;
                                                              },
                                                              child: Image.asset('assets/images/deleteicon.png')),
                                                        ],
                                                      )

                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.01,),
                                                  Column( crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("${data?.institutionName}",
                                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                            color: AppColors.ratingcommenttextcolor, fontWeight: FontWeight.w400),),
                                                      data?.educationStartDate == 'null' || data?.educationEndDate == 'null'
                                                          ? const SizedBox()
                                                          : Text('${data?.educationStartDate} - ${data?.educationEndDate}',
                                                        // "${data?.educationStartDate?.month}/${data?.educationStartDate?.year} - ${data?.educationEndDate?.month}/${data?.educationEndDate?.year}",
                                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                            color: AppColors.ratingcommenttextcolor, fontWeight: FontWeight.w400),),
                                                    ],
                                                  )
                                                ],
                                              );
                                            }
                                        ),

                                        // ********************* for Skill ***************************

                                        SizedBox(height: Get.height * 0.045,),

                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                    child: SvgPicture.asset('assets/images/skillsvg.svg')),
                                                SizedBox(width: Get.width * 0.02,),
                                                Text('Skill',
                                                  style: Get.theme.textTheme.labelMedium!.copyWith(color: AppColors.white),),
                                              ],
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  skill();
                                                },
                                                child: Image.asset('assets/images/editicon2.png'))
                                          ],
                                        ),
                                        SizedBox(height: Get.height * 0.02,),
                                        const Divider(
                                          thickness: 0.2,
                                          color: AppColors.white,
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.015,),
                                        Text('Soft Skill',
                                          style: Get.theme.textTheme
                                              .labelMedium!.copyWith(
                                              color: AppColors
                                                  .white),),
                                        SizedBox(
                                          height: Get.height * 0.015,),

                                        // SizedBox(height: Get.height * 0.02,),
                                        seekerProfileController.viewSeekerData
                                            .value.seekerDetails?.skillName ==
                                            null ||
                                            seekerProfileController
                                                .viewSeekerData.value
                                                .seekerDetails?.skillName
                                                ?.length == 0 ?

                                        const Text("No Data") :
                                        GridView.builder(gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            mainAxisExtent: 36,
                                            maxCrossAxisExtent: Get.width * 0.4,
                                            mainAxisSpacing: 8,
                                            crossAxisSpacing: 8),
                                            itemCount: seekerProfileController
                                                .viewSeekerData.value
                                                .seekerDetails?.skillName
                                                ?.length,
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              var data = seekerProfileController
                                                  .viewSeekerData.value
                                                  .seekerDetails
                                                  ?.skillName?[index];
                                              return Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(12),
                                                  color: AppColors.blackdown,
                                                ),
                                                padding: const EdgeInsets.all(
                                                    8),
                                                child: Text('${data?.skills}',
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  style: Get.theme.textTheme
                                                      .bodySmall!.copyWith(
                                                      color: AppColors.white,
                                                      fontWeight: FontWeight
                                                          .w400),),
                                              );
                                            }),
                                        ///////////passion////////

                                        SizedBox(
                                          height: Get.height * 0.025,),
                                        Text('Passion',
                                          style: Get.theme.textTheme
                                              .labelMedium!.copyWith(
                                              color: AppColors
                                                  .white),),
                                        SizedBox(
                                          height: Get.height * 0.015,),
                                        seekerProfileController.viewSeekerData
                                            .value.seekerDetails?.passionName ==
                                            null ||
                                            seekerProfileController
                                                .viewSeekerData.value
                                                .seekerDetails?.passionName
                                                ?.length == 0 ?

                                        const Text("No Data") :
                                        GridView.builder(gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            mainAxisExtent: 36,
                                            maxCrossAxisExtent: Get.width * 0.4,
                                            mainAxisSpacing: 8,
                                            crossAxisSpacing: 8),
                                            itemCount: seekerProfileController.viewSeekerData.value.seekerDetails?.passionName?.length,
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              var data = seekerProfileController.viewSeekerData.value.seekerDetails?.passionName?[index];
                                              return Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(12),
                                                  color: AppColors.blackdown,),
                                                padding: const EdgeInsets.all(8),
                                                child: Text('${data?.passion}',
                                                  overflow: TextOverflow.ellipsis,
                                                  style: Get.theme.textTheme.bodySmall!.copyWith(
                                                      color: AppColors.white, fontWeight: FontWeight.w400),),
                                              );
                                            }),
                                        //////////passion////////////

                                        ////////industry preference////////////
                                        SizedBox(
                                          height: Get.height * 0.025,),
                                        Text('industry preference',
                                          style: Get.theme.textTheme
                                              .labelMedium!.copyWith(
                                              color: AppColors
                                                  .white),),

                                        SizedBox(
                                          height: Get.height * 0.015,),
                                        seekerProfileController.viewSeekerData
                                            .value.seekerDetails?.industryPreferenceName ==
                                            null ||
                                            seekerProfileController
                                                .viewSeekerData.value
                                                .seekerDetails?.industryPreferenceName
                                                ?.length == 0 ?

                                        const Text("No Data") :
                                        GridView.builder(gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            mainAxisExtent: 36,
                                            maxCrossAxisExtent: Get.width * 0.4,
                                            mainAxisSpacing: 8,
                                            crossAxisSpacing: 8),
                                            itemCount: seekerProfileController.viewSeekerData.value.seekerDetails?.industryPreferenceName?.length,
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              var data = seekerProfileController.viewSeekerData.value.seekerDetails?.industryPreferenceName?[index];
                                              return Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(12),
                                                  color: AppColors.blackdown,),
                                                padding: const EdgeInsets.all(8),
                                                child: Text('${data?.industryPreferences}',
                                                  overflow: TextOverflow.ellipsis,
                                                  style: Get.theme.textTheme.bodySmall!.copyWith(
                                                      color: AppColors.white, fontWeight: FontWeight.w400),),
                                              );
                                            }),
                                        ////////industry preference////////////

                                        //////////////Strengths////////
                                        SizedBox(
                                          height: Get.height * 0.025,),
                                        Text('Strengths',
                                          style: Get.theme.textTheme
                                              .labelMedium!.copyWith(
                                              color: AppColors
                                                  .white),),
                                        SizedBox(
                                          height: Get.height * 0.015,),
                                        seekerProfileController.viewSeekerData
                                            .value.seekerDetails?.strengthsName ==
                                            null ||
                                            seekerProfileController
                                                .viewSeekerData.value
                                                .seekerDetails?.strengthsName
                                                ?.length == 0 ?
                                        const Text("No Data") :
                                        GridView.builder(gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            mainAxisExtent: 36,
                                            maxCrossAxisExtent: Get.width * 0.4,
                                            mainAxisSpacing: 8,
                                            crossAxisSpacing: 8),
                                            itemCount: seekerProfileController
                                                .viewSeekerData.value
                                                .seekerDetails?.strengthsName
                                                ?.length,
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              var data = seekerProfileController
                                                  .viewSeekerData.value
                                                  .seekerDetails
                                                  ?.strengthsName?[index];
                                              return Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(12),
                                                  color: AppColors.blackdown,
                                                ),
                                                padding: const EdgeInsets.all(
                                                    8),
                                                child: Text('${data?.strengths}',
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  style: Get.theme.textTheme
                                                      .bodySmall!.copyWith(
                                                      color: AppColors.white,
                                                      fontWeight: FontWeight
                                                          .w400),),
                                              );
                                            }),
                                        //////////////Strengths////////

                                        //////////////Salary expectation////////
                                        SizedBox(
                                          height: Get.height * 0.025,),
                                        Text('Salary expectation',
                                          style: Get.theme.textTheme
                                              .labelMedium!.copyWith(
                                              color: AppColors
                                                  .white),),
                                        SizedBox(
                                          height: Get.height * 0.015,),
                                        seekerProfileController.viewSeekerData
                                            .value.seekerDetails?.salaryExpectationName ==
                                            null ||
                                            seekerProfileController
                                                .viewSeekerData.value
                                                .seekerDetails?.salaryExpectationName
                                                ?.length == 0 ?
                                        const Text("No Data") :
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius
                                                .circular(12),
                                            color: AppColors.blackdown,
                                          ),
                                          padding: const EdgeInsets.symmetric(horizontal : 20 ,vertical: 8),
                                          child: Text('${seekerProfileController.viewSeekerData.value
                                              .seekerDetails?.salaryExpectationName}',
                                            overflow: TextOverflow
                                                .ellipsis,
                                            style: Get.theme.textTheme
                                                .bodySmall!.copyWith(
                                                color: AppColors.white,
                                                fontWeight: FontWeight
                                                    .w400),),
                                        ),
                                        //////////////Salary expectation////////

                                        //////////////When can i start working?////////
                                        SizedBox(
                                          height: Get.height * 0.025,),
                                        Text('When can i start working?',
                                          style: Get.theme.textTheme
                                              .labelMedium!.copyWith(
                                              color: AppColors
                                                  .white),),
                                        SizedBox(
                                          height: Get.height * 0.015,),
                                        seekerProfileController.viewSeekerData
                                            .value.seekerDetails?.startWorkName ==
                                            null ||
                                            seekerProfileController
                                                .viewSeekerData.value
                                                .seekerDetails?.startWorkName
                                                ?.length == 0 ?
                                        const Text("No Data") :
                                        GridView.builder(gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            mainAxisExtent: 36,
                                            maxCrossAxisExtent: Get.width * 0.4,
                                            mainAxisSpacing: 8,
                                            crossAxisSpacing: 8),
                                            itemCount: seekerProfileController
                                                .viewSeekerData.value
                                                .seekerDetails?.startWorkName
                                                ?.length,
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              var data = seekerProfileController
                                                  .viewSeekerData.value
                                                  .seekerDetails
                                                  ?.startWorkName?[index];
                                              return Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(12),
                                                  color: AppColors.blackdown,
                                                ),
                                                padding: const EdgeInsets.all(
                                                    8),
                                                child: Text('${data?.startWork}',
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  style: Get.theme.textTheme
                                                      .bodySmall!.copyWith(
                                                      color: AppColors.white,
                                                      fontWeight: FontWeight
                                                          .w400),),
                                              );
                                            }),
                                        //////////////When can i start working?////////


                                        //////////////Availability?////////
                                        SizedBox(
                                          height: Get.height * 0.025,),
                                        Text('Availability?',
                                          style: Get.theme.textTheme
                                              .labelMedium!.copyWith(
                                              color: AppColors
                                                  .white),),
                                        SizedBox(
                                          height: Get.height * 0.015,),
                                        seekerProfileController.viewSeekerData
                                            .value.seekerDetails?.availabityName ==
                                            null ||
                                            seekerProfileController
                                                .viewSeekerData.value
                                                .seekerDetails?.availabityName
                                                ?.length == 0 ?
                                        const Text("No Data") :
                                        GridView.builder(gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            mainAxisExtent: 36,
                                            maxCrossAxisExtent: Get.width * 0.4,
                                            mainAxisSpacing: 8,
                                            crossAxisSpacing: 8),
                                            itemCount: seekerProfileController
                                                .viewSeekerData.value
                                                .seekerDetails?.availabityName
                                                ?.length,
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              var data = seekerProfileController
                                                  .viewSeekerData.value
                                                  .seekerDetails
                                                  ?.availabityName?[index];
                                              return Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(12),
                                                  color: AppColors.blackdown,
                                                ),
                                                padding: const EdgeInsets.all(
                                                    8),
                                                child: Text('${data?.availabity}',
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  style: Get.theme.textTheme
                                                      .bodySmall!.copyWith(
                                                      color: AppColors.white,
                                                      fontWeight: FontWeight
                                                          .w400),),
                                              );
                                            }),
                                        //////////////Availability?////////


                                        SizedBox(height: Get.height * 0.045,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              children: [
                                                InkWell(
                                                    child: SvgPicture.asset(
                                                        'assets/images/languagesvg.svg')),
                                                SizedBox(
                                                  width: Get.width * 0.02,),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .only(
                                                      top: 2.0),
                                                  child:
                                                  Text('Language',
                                                    style: Get.theme.textTheme
                                                        .labelMedium!.copyWith(
                                                        color: AppColors
                                                            .white),),
                                                ),
                                              ],
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  language();
                                                },
                                                child: Image.asset(
                                                    'assets/images/editicon2.png'))
                                          ],
                                        ),
                                        SizedBox(height: Get.height * 0.02,),
                                        const Divider(
                                          thickness: 0.2,
                                          color: AppColors.white,
                                        ),
                                        SizedBox(height: Get.height * 0.02,),
                                        seekerProfileController.viewSeekerData
                                            .value.seekerDetails?.language ==
                                            null ||
                                            seekerProfileController
                                                .viewSeekerData.value
                                                .seekerDetails?.language
                                                ?.length == 0 ?
                                        const Text("No Data") :
                                        GridView.builder(gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            mainAxisExtent: 36,
                                            maxCrossAxisExtent: Get.width * 0.4,
                                            mainAxisSpacing: 8,
                                            crossAxisSpacing: 8),
                                            itemCount: seekerProfileController
                                                .viewSeekerData.value
                                                .seekerDetails?.language
                                                ?.length,
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              var data = seekerProfileController
                                                  .viewSeekerData.value
                                                  .seekerDetails
                                                  ?.language?[index];
                                              return Container( alignment: Alignment.center,
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                                                  color: AppColors.blackdown,),
                                                padding: const EdgeInsets.all(8),
                                                child: Text('${data?.languages}',
                                                  style: Get.theme.textTheme.bodySmall!.copyWith(
                                                      color: AppColors.white, fontWeight: FontWeight.w400),),
                                              );
                                            }),
                                        //********************* for appreciation ***************************
                                        SizedBox(height: Get.height * 0.04,),
                                        Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row( mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                    child: SvgPicture.asset( 'assets/images/Educationsvg.svg')),
                                                SizedBox(width: Get.width * 0.02,),
                                                Padding(padding: const EdgeInsets.only(top: 6.0),
                                                  child: Text('appreciation',
                                                    style: Get.theme.textTheme.labelMedium!.copyWith(
                                                        color: AppColors.white),),
                                                ),
                                              ],
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  appreciation(0 , "", "", add: true);
                                                },
                                                child: Image.asset('assets/images/addicononjobre.png'))
                                          ],
                                        ),
                                        SizedBox(height: Get.height * 0.02,),
                                        const Divider(
                                          thickness: 0.2,
                                          color: AppColors.white,
                                        ),
                                        seekerProfileController.viewSeekerData.value.seekerDetails?.appreciation == null ||
                                            seekerProfileController.viewSeekerData.value.seekerDetails?.appreciation?.length == 0 ?
                                        const Text("No Data")
                                            : ListView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: seekerProfileController.viewSeekerData.value.seekerDetails?.appreciation?.length,
                                            itemBuilder: (context, index) {
                                              var data = seekerProfileController.viewSeekerData.value.seekerDetails?.appreciation?[index];
                                              return Column( crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: Get.height * 0.02,),
                                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text('${data?.awardName}', style: Get.theme.textTheme.bodyMedium!.copyWith(
                                                            color: AppColors.white, fontWeight: FontWeight.w700),),
                                                      Row(
                                                        children: [
                                                          InkWell(
                                                              onTap: () {
                                                                appreciation(index , data?.awardName , data?.achievement);},
                                                              child: Image.asset('assets/images/editicon2.png')),
                                                          const SizedBox(width: 16,),
                                                          InkWell(
                                                              onTap: () {
                                                                _openAppreciationDeleteDialog(index) ;
                                                              },
                                                              child: Image.asset('assets/images/deleteicon.png')),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(height: Get.height * 0.01,),
                                                  Column( crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text( "${data?.achievement}",
                                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                            color: AppColors.ratingcommenttextcolor, fontWeight: FontWeight.w400),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              );
                                            }
                                        ),

                                        SizedBox(height: Get.height * 0.04,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              children: [
                                                InkWell(child: SvgPicture.asset('assets/images/resumesvg.svg')),
                                                SizedBox(width: Get.width * 0.02,),
                                                Padding(padding: const EdgeInsets.only(top: 6.0),
                                                  child: Text('Resume',
                                                    style: Get.theme.textTheme
                                                        .labelMedium!.copyWith(
                                                        color: AppColors
                                                            .white),),
                                                ),
                                              ],
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  _openFilePicker() ;
                                                },
                                                child: seekerProfileController.viewSeekerData
                                                    .value.seekerInfo?.resume == null || seekerProfileController
                                                        .viewSeekerData.value.seekerInfo?.resume.length == 0 ?
                                                Image.asset('assets/images/addicononjobre.png'):
                                                Image.asset('assets/images/editicon2.png')
                                            )
                                          ],
                                        ),
                                        SizedBox(height: Get.height * 0.02,),
                                        const Divider(
                                          thickness: 0.2,
                                          color: AppColors.white,
                                        ),
                                        SizedBox(height: Get.height * 0.02,),
                                        seekerProfileController.viewSeekerData
                                            .value.seekerInfo?.resume == null ||
                                            seekerProfileController
                                                .viewSeekerData.value.seekerInfo
                                                ?.resume.length == 0 ?
                                        const Text("No Data")
                                            : ListTile(
                                          leading: SvgPicture.asset('assets/images/PDF.svg'),
                                          title: Text(
                                            '${seekerProfileController.viewSeekerData.value.seekerInfo?.resume}',
                                            overflow: TextOverflow.ellipsis,
                                            style: Get.theme.textTheme.bodySmall!.copyWith(
                                                color: AppColors.white, fontWeight: FontWeight.w500),),
                                        ),
                                        SizedBox(height: Get.height * .03,),
                                        // Text('Document',
                                        //   style: Get.theme.textTheme
                                        //       .labelMedium!.copyWith(
                                        //       color: AppColors.white),),
                                        // SizedBox(height: Get.height*.015,) ,
                                        // const Divider(thickness: 0.2, color: AppColors.white,),
                                        // ListTile(title:
                                        // Text("${seekerProfileController.viewSeekerData.value.seekerInfo?.documentImg}",
                                        //     style: Get.theme.textTheme.bodySmall!.copyWith(
                                        //         color: AppColors.white, fontWeight: FontWeight.w500),),
                                        //   // CircleAvatar(
                                        //   //   radius: 20,
                                        //   //   backgroundImage: NetworkImage("${seekerProfileController.viewSeekerData.value.seekerInfo?.documentImg}"),
                                        //   // ) ,
                                        //   trailing: SvgPicture.asset('assets/images/deletsvg.svg'),
                                        // ),
                                        // SizedBox(height: Get.height * 0.02,),
                                        Center(
                                          child: MyButton(
                                            title: "Boost Your Profile",
                                            onTap1: () {
                                              showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (
                                                    BuildContext context) {
                                                  return AlertDialog(
                                                    content: SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          Align(alignment: Alignment.topRight,
                                                              child: GestureDetector(
                                                                  onTap: () { Get.back();},
                                                                  child: Image.asset("assets/images/closeiconondrawer.png",
                                                                    height: Get.height * .027,))),
                                                          SizedBox( height: Get.height * 0.035 ),
                                                          Container(padding: const EdgeInsets.all(17),
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular( 60.0),
                                                              gradient: const LinearGradient(
                                                                colors: [Color(0xFF56B8F6), Color(0xFF4D6FED),],
                                                                begin: Alignment.topCenter,
                                                                end: Alignment.bottomCenter,),),
                                                            child: Image.asset('assets/images/boost.png', scale: 3.4,),
                                                          ),
                                                          SizedBox(height: Get.height * 0.02),
                                                          Text("Boost your profile", style: Get.theme.textTheme.labelMedium),
                                                          SizedBox(height: Get.height * 0.01),
                                                          Text("Lorem Ipsum is simply dummy text",
                                                              style: Get.theme.textTheme.bodySmall!.copyWith(
                                                                  fontWeight: FontWeight.w400, color: AppColors.white)),
                                                          SizedBox(height: Get.height * 0.05),
                                                          Container( decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(10.0),
                                                              gradient: const LinearGradient(
                                                                colors: [Color(0xFF56B8F6), Color(0xFF4D6FED),],
                                                                begin: Alignment.topCenter,
                                                                end: Alignment.bottomCenter,),),
                                                            height: Get.height * 0.21,
                                                            width: Get.width * 0.32,
                                                            child: Center(
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(height: Get.height * 0.035),
                                                                  Text("1", style: Get.theme.textTheme.displaySmall!.copyWith(
                                                                          fontSize: 25, color: AppColors.white)),
                                                                  SizedBox(height: Get.height * 0.014),
                                                                  Text("month", style: Get.theme.textTheme.titleSmall!.copyWith(
                                                                          fontSize: 15, color: AppColors.white)),
                                                                  SizedBox(height: Get.height * 0.01),
                                                                  Text("\$100", style: Get.theme.textTheme.bodyMedium!.copyWith(
                                                                          fontSize: 13, color: AppColors.white)),
                                                                  SizedBox(height: Get.height * 0.01),
                                                                  Text("Save 36%", style: Get.theme.textTheme.titleSmall!.copyWith(
                                                                          fontSize: 11, color: AppColors.white)),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: Get.height * 0.035),
                                                          Center(
                                                            child: MyButton(width: Get.width * .7,
                                                              title: "BOOST ME",
                                                              onTap1: () {},),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius
                                                            .circular(15)
                                                    ),
                                                  );
                                                },
                                              );
                                            },),
                                        ),
                                        SizedBox(height: Get.height * .02,),
                                      ],
                                    )
                                ),

                              ],
                            ),
                          );
                      },
                    ),
                  ],
                ),
              ),
            );
      }
    });
  }


  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();

  Future<void> _selectDate(
      bool start ,
      BuildContext context,
      String firstDate
      // DateTime? firstDate,
      // DateTime? selectedDate ,
      // int step
      // TextEditingController controller
      ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: start ? DateTime(1990) : DateTime.parse(firstDate),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );
    if (picked != null ) {
      setState(() {
     start ?   _startDateController.text = DateFormat('yyyy-MM-dd').format(picked) :
        _endDateController.text = DateFormat('yyyy-MM-dd').format(picked);
     print(_startDateController.text) ;
      });
    }
  }

  Future<void> _openDeleteDialog( int index,
      bool isExperience) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff373737),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none),
          title: Center(
            child: Text('Are you sure you want to delete',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600,fontSize: 13),
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx( () =>
                   MyButton(
                      width: Get.width*.25,
                      height: Get.height*.05,
                      loading: editSeekerExperienceController.loading.value,
                      title: "Yes",
                      onTap1: () {
                        if(!isExperience){
                      seekerProfileController
                          .viewSeekerData.value
                          .seekerDetails?.educationLevel?.removeAt(index) ;
                      editSeekerExperienceController.workApi(
                          false,
                          seekerProfileController.viewSeekerData.value
                              .seekerDetails?.educationLevel, context);
                        }else {
                          seekerProfileController
                              .viewSeekerData.value.workExpJob?.removeAt(index);
                          editSeekerExperienceController.workApi(
                              true,
                              seekerProfileController.viewSeekerData.value.workExpJob, context);
                        }

                    },),
                  )
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyButton(
                    width: Get.width*.25,
                    height: Get.height*.05,
                    title: "No",
                    onTap1: () { Get.back() ;},)
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openAppreciationDeleteDialog( int index,) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff373737),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none),
          title: Center(
            child: Text(
              'Are you sure you want to delete',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600,fontSize: 13),
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx( () =>
                      MyButton(
                        width: Get.width*.25,
                        height: Get.height*.05,
                        loading: editSeekerAppreciationController.loading.value,
                        title: "Yes",
                        onTap1: () {
                            seekerProfileController.viewSeekerData.value.seekerDetails?.appreciation?.removeAt(index);
                            editSeekerAppreciationController.appreciationApi(
                              seekerProfileController.viewSeekerData.value.seekerDetails?.appreciation ,context);
                        },),
                  )
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyButton(
                    width: Get.width*.25,
                    height: Get.height*.05,
                    title: "No",
                    onTap1: () { Get.back() ;},)
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
    );

    if(result != null) {
      if (result.files.single.path!.toLowerCase().endsWith('.pdf')) {
        setState(() {
          resumePath = result.files.single.path!;
          editSeekerResumeController.resumeApi(resumePath, context) ;
          editSeekerResumeController.errorMessage.value = '' ;
        });
        print(resumePath);
      } else {
        if(resumePath.isEmpty) {
          editSeekerResumeController.errorMessage.value = 'Please pick a pdf file';
        }else {
          editSeekerResumeController.errorMessage.value = 'Only pdf file is allowed';
        }
      }
    }
    else {
      // User canceled the picker
    }
  }

}
