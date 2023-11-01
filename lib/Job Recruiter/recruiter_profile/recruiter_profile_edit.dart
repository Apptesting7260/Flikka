import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flikka/controllers/CreateUpdateRecruiterProfileController/CreateUpdateRecruiterProfileController.dart';
import 'package:flikka/controllers/SelectIndustryController/SelectIndustryController.dart';
import 'package:flikka/data/response/status.dart';
import 'package:flikka/utils/CommonWidgets.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';

class RecruiterProfileEdit extends StatefulWidget {
  const RecruiterProfileEdit({super.key});

  @override
  State<RecruiterProfileEdit> createState() => _RecruiterProfileEditState();
}

class _RecruiterProfileEditState extends State<RecruiterProfileEdit> {
  var companyNameController = TextEditingController();
  var companyLocationController = TextEditingController();
  var addBioController = TextEditingController();
  var contactPersonNameController = TextEditingController();
  var homeTitleNameController = TextEditingController();
  // var homeDescriptionController = TextEditingController();
  var websiteLinkController = TextEditingController();
  var titleNameController = TextEditingController();
  var aboutTitleNameController = TextEditingController();
  var aboutDescriptionController = TextEditingController();
  var aboutySpecialtiesController = TextEditingController();

  File? coverImage;
  File? profileImage;
  /////Upload cover image dialog////////////
  Future<void> _openCoverImagePickerDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff373737),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          title: Center(
            child: Text(
              'Please choose image',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18,fontWeight: FontWeight.w600),
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyButton(
                width: Get.width*.25,
                height: Get.height*.05,
                title: "Camera", onTap1: () {
                _pickImage(ImageSource.camera);
              },),
              const SizedBox(width: 10,) ,
              MyButton(
                width: Get.width*.25,
                height: Get.height*.05,
                title: "Galery", onTap1: () {
                _pickImage(ImageSource.gallery);
              },),
            ],
          ),
        );
      },
    );
  }

  late File? _pickedImage;
  final imgPicker = ImagePicker();
  final coverImageCropper = ImageCropper() ;
  Future<void> _pickImage(abc) async {
    var imgCamera = await imgPicker.pickImage(source: abc);

    if(imgCamera != null) {
      final croppedImage = await coverImageCropper.cropImage(
        sourcePath: imgCamera.path,
        aspectRatio: const CropAspectRatio(ratioX: 1.5, ratioY: 2),
        // Adjust aspect ratio as needed
        compressQuality: 70,);

      setState(() {
        coverImage = File(croppedImage!.path);
        print(coverImage);
      });
      Get.back();
    }
  }
  ///////cover img////////////////

  ////////upload profile image dialog/////////

  Future<void> _openProfileImagePickerDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff373737),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          title: Center(
            child: Text(
              'Please choose image',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18,fontWeight: FontWeight.w600),
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyButton(
                width: Get.width*.25,
                height: Get.height*.05,
                title: "Camera", onTap1: () {
                _pickImagee(ImageSource.camera);
              },),
              const SizedBox(width: 10,),
              MyButton(
                width: Get.width*.25,
                height: Get.height*.05,
                title: "Gallery", onTap1: () {
                _pickImagee(ImageSource.gallery);
              },),
            ],
          ),
        );
      },
    );
  }

  dynamic industry;
  String? companySize;
  DateTime? founded;

  late File? _pickedCoverImage;
  final imagePicker = ImagePicker();
  final profileImageCropper = ImageCropper() ;
  Future<void> _pickImagee(abc) async {
    var imgCamera = await imgPicker.pickImage(source: abc);
    if(imgCamera != null) {
      final croppedImage = await profileImageCropper.cropImage(
        sourcePath: imgCamera.path,
        aspectRatio: const CropAspectRatio(ratioX: 1.5, ratioY: 2),
        // Adjust aspect ratio as needed
        compressQuality: 70,);

      setState(() {
        profileImage = File(croppedImage!.path);
        print(profileImage);
      });
      Get.back();
    }
  }
  ////////////profile image/////////////

  final List<String> itemsC = [
    'Social Marketing',
    'Programming',
    'Health Finance',
    'Content Manager'
  ];
  String? socialValue;

  final List<String> itemsCompanySize = [
   ' 0-10 Employees',
   ' 10-20 Employees',
    '20-30 Employees',
   ' 30-50 Employees',
    '50-75 Employees',
    '75-100 Employees'
  ];
  String? sizeValues;

  ////date///
  String selectedDateString = 'yyyy/MM/dd';
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        selectedDateString = "${picked.year.toString().padLeft(4,'0')}-${picked.month.toString().padLeft(2,'0')}-${picked.day.toString().padLeft(2,'0')}";
        founded = picked;
      });
    }
  }

  DateTime selectedDate = DateTime.now();

  CreateUpdateRecruiterProfileController
      CreateUpdateRecruiterProfileControllerInstanse =
      Get.put(CreateUpdateRecruiterProfileController());

  var formKey = GlobalKey<FormState>() ;

  websiteLink(String value) {
    print("object") ;
    final Uri? uri = Uri.tryParse(value);
    if (!uri!.hasAbsolutePath) {
      return 'Please enter valid url';
    }
  }

  nameInitialize () async {
    SharedPreferences sp = await SharedPreferences.getInstance() ;
    contactPersonNameController.text = sp.getString("name")! ;
  }

  SelectIndustryController selectIndustryController = Get.put(SelectIndustryController()) ;
  final ScrollController scrollController = ScrollController() ;

@override
  void initState() {
  nameInitialize() ;
  selectIndustryController.selectIndustriesApi() ;
    super.initState();
  }

  var _formKey = GlobalKey<FormState>();
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Obx( () {
      switch (selectIndustryController
          .rxRequestStatus.value) {
        case Status.LOADING:
          return const Scaffold(
            body: Center(
                child: CircularProgressIndicator()),
          );

        case Status.ERROR:
          if (selectIndustryController
              .error.value ==
              'No internet') {
            return Scaffold(body: InterNetExceptionWidget(
              onPress: () {},
            ),)
            ;
          } else {
            return Scaffold(body: GeneralExceptionWidget(
                onPress: () {}),)
            ;
          }
        case Status.COMPLETED:
          return SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  controller: scrollController,
                  child: Form(key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * .03,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Image.asset(
                                    "assets/images/icon_back_blue.png",
                                    height: Get.height * .055,
                                  )),
                              SizedBox(
                                width: Get.width * .04,
                              ),
                              Text(
                                "Add your detail",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * .05,
                        ),
                        Container(
                          height: Get.height * .19 + 50,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [

                              GestureDetector(
                                onTap: () {
                                  if (coverImage == null) {
                                    _openCoverImagePickerDialog();
                                  }
                                  return;

                                  print("This is cover imgFile ${coverImage
                                      ?.path}");
                                },
                                child: Container(
                                  height: Get.height * .19,
                                  width: Get.width,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff454545),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      coverImage == null
                                          ? Image.asset(
                                        "assets/images/icon_upload_cv.png",
                                        height: Get.height * .05,
                                      )
                                          : Image.file(
                                        coverImage!,
                                        height: Get.height,
                                        width: Get.width,
                                        fit: BoxFit.cover,
                                      ),
                                      if (coverImage == null)
                                        SizedBox(
                                          width: Get.width * .04,
                                        ),
                                      if (coverImage == null)
                                        Text(
                                          "Upload Cover Image",
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .labelLarge
                                              ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xffFFFFFF)),
                                        )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 10,
                                top: 10,
                                child: coverImage == null ?
                                    const SizedBox() :
                                IconButton(
                                  icon:  Icon(
                                    Icons.edit, color: Colors.white, size: 30,),
                                  onPressed: () {
                                    _openCoverImagePickerDialog();
                                  },)
                                ,
                              ),
                              Positioned(
                                bottom: 5,
                                left: 20,
                                child: CircleAvatar(
                                  radius: 45,
                                  backgroundColor: const Color(0xff353535),
                                  child: ClipOval(
                                    child: profileImage == null
                                        ? Image.asset(
                                      "assets/images/icon_profile.png",
                                      height: 40,
                                      width: 40,
                                      fit: BoxFit.cover,
                                    )
                                        : Image.file(
                                      profileImage!,
                                      height: Get.height,
                                      width: Get.width,
                                      fit: BoxFit.cover,
                                    ),
                                    // :Image.file(imgFile!,height: Get.height,width: Get.width,fit:BoxFit.cover,)
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: -0,
                                left: 85,
                                child: GestureDetector(
                                  onTap: () {
                                    _openProfileImagePickerDialog();
                                    print("This is profile ImgFile ${profileImage?.path}");
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    height: 37,
                                    width: 37,
                                    // height: Get.height * .05,
                                    // width: Get.height * .05,
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
                                    child: profileImage !=null && profileImage?.path.length !=0 ?
                                        const Icon(Icons.edit,color: Colors.white,
                                          size: 18,) :
                                    Image.asset(
                                      "assets/images/camera.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // const SizedBox(height: 58),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: Get.height * .01,),
                              Obx(() =>
                              CreateUpdateRecruiterProfileControllerInstanse
                                  .profileImageError.value.isEmpty ?
                              const SizedBox() :
                              Center(child: Text(
                                CreateUpdateRecruiterProfileControllerInstanse
                                    .profileImageError.value,
                                style: TextStyle(color: Colors.red),))
                              ),
                              Obx(() =>
                              CreateUpdateRecruiterProfileControllerInstanse
                                  .coverImageError.value.isEmpty ?
                              const SizedBox() :
                              Center(child: Text(
                                CreateUpdateRecruiterProfileControllerInstanse
                                    .coverImageError.value,
                                style: TextStyle(color: Colors.red),))
                              ),
                              SizedBox(
                                height: Get.height * .02,
                              ),
                              Text(
                                "Select Profile image",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(color: const Color(0xffFFFFFF)),
                              ),
                              SizedBox(height: Get.height * .031,),
                              Text(
                                "Company name",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: Get.height * .01,
                              ),
                              CommonWidgets.textField(
                                  context, companyNameController,
                                  "Enter company name",
                                  onFieldSubmitted: (value) {}),
                              SizedBox(
                                height: Get.height * .032,
                              ),
                              Text(
                                "Company Location",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: Get.height * .01,
                              ),
                              CommonWidgets.textField(
                                  context, companyLocationController,
                                  "Enter company location",
                                  onFieldSubmitted: (value) {}),
                              SizedBox(
                                height: Get.height * .032,
                              ),
                              Text(
                                "Add Bio",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: Get.height * .01,
                              ),
                              CommonWidgets.textFieldMaxLines(
                                context, addBioController, "Enter bio ",
                                onFieldSubmitted: (value) {},
                                maxCharacter: 1000,
                              ),
                              // SizedBox(height: Get.height*.01,),
                              CommonWidgets.divider(),
                              SizedBox(height: Get.height * .01,),
                              Text(
                                "Contact Person Name",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: Get.height * .01,
                              ),
                              CommonWidgets.textField(
                                context, contactPersonNameController,
                                "Enter contact person name",
                                onFieldSubmitted: (value) {

                                },),
                              SizedBox(
                                height: Get.height * .01,
                              ),
                              CommonWidgets.divider(),
                              SizedBox(height: Get.height * .01,),
                              Text(
                                "Website Link",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: Get.height * .01,
                              ),
                              TextFormField(
                                controller: websiteLinkController,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyMedium,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(35),
                                        borderSide: const BorderSide(
                                            color: Color(0xff373737))),
                                    filled: true,
                                    fillColor: const Color(0xff373737),
                                    hintText: "Enter website link",
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(35),
                                      // borderSide: BorderSide(color: Colors.white),
                                    ),
                                    errorBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(35.0)),
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                    disabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(35.0)),
                                      borderSide: BorderSide(
                                          color: Color(0xff373737)),
                                    ),
                                    hintStyle: Theme
                                        .of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                        color: const Color(0xffCFCFCF)),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: Get.width * .06,
                                        vertical: Get.height * .027)),
                                validator: (value) {
                                  String pattern = r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
                                  RegExp regExp = new RegExp(pattern);
                                  if (value?.length == 0) {
                                    return 'Please enter url';
                                  }
                                  else if (!regExp.hasMatch(value!)) {
                                    return 'Please enter valid url';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: Get.height * .025,
                              ),
                              CommonWidgets.divider(),
                              Text(
                                "About",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              // SizedBox(
                              //   height: Get.height * .028,
                              // ),
                              // Text(
                              //   "Title name",
                              //   style: Theme
                              //       .of(context)
                              //       .textTheme
                              //       .titleSmall
                              //       ?.copyWith(fontWeight: FontWeight.w700),
                              // ),
                              // SizedBox(
                              //   height: Get.height * .01,
                              // ),
                              // CommonWidgets.textField(
                              //   context, titleNameController,
                              //   "Enter award name", onFieldSubmitted: (value) {
                              //
                              // },),
                              SizedBox(height: Get.height * .02,),

                              Text(
                                "Description",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: Get.height * .01,
                              ),
                              CommonWidgets.textFieldMaxLines(
                                context,
                                aboutDescriptionController,
                                "Enter description",
                                onFieldSubmitted: (value) {},
                              ),
                              SizedBox(
                                height: Get.height * .01,
                              ),
                              CommonWidgets.divider(),
                              SizedBox(
                                height: Get.height * .01,
                              ),
                              Text(
                                "Industry",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: Get.height * .01,
                              ),
                              Center(
                                child: DropdownButtonHideUnderline(
                                  child: Obx( () =>
                                    DropdownButton2(
                                      isExpanded: true,
                                      hint: Row(
                                        children: [
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Enter industry',
                                              style: Get.theme.textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                  fontWeight: FontWeight.w400),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      items: selectIndustryController.getIndustriesData.value.industries?.map((item) =>
                                          DropdownMenuItem<String>(
                                            onTap: (){
                                              setState(() {
                                                industry = item.id.toString() ;
                                                socialValue = item.industryPreferences ;
                                              });

                                            },
                                            value: item.industryPreferences,
                                            child: Text(
                                              "${item.industryPreferences}",
                                              style: Get.theme.textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                  color: AppColors.white),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                          .toList(),
                                      value: socialValue,
                                      onChanged: (String? value) {
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: Get.height * 0.078,
                                        width: double.infinity,
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(35),
                                          color: const Color(0xff373737),
                                        ),
                                        elevation: 2,
                                      ),
                                      iconStyleData: IconStyleData(
                                        icon: Image.asset(
                                            'assets/images/arrowdown.png'),
                                        iconSize: 14,
                                        iconEnabledColor: Colors.yellow,
                                        iconDisabledColor: Colors.grey,
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: Get.height * 0.35,
                                        width: Get.width * 0.902,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(14),
                                          color: const Color(0xff353535),
                                        ),
                                        offset: const Offset(5, 0),
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(40),
                                          thickness: MaterialStateProperty.all<
                                              double>(6),
                                          thumbVisibility:
                                          MaterialStateProperty.all<bool>(true),
                                        ),
                                      ),
                                      menuItemStyleData: const MenuItemStyleData(
                                        height: 40,
                                        padding: EdgeInsets.only(
                                            left: 14, right: 14),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Obx(() =>
                              CreateUpdateRecruiterProfileControllerInstanse
                                  .industryError.value.isEmpty ?
                              const SizedBox() :
                              Center(child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    CreateUpdateRecruiterProfileControllerInstanse
                                        .industryError.value,
                                    style: TextStyle(color: Colors.red),)))
                              ),
                              SizedBox(
                                height: Get.height * .04,
                              ),
                              Text(
                                "Company Size",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: Get.height * .01,
                              ),
                              Center(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: Text(
                                      'Select employees',
                                      style: Get.theme.textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                          fontWeight: FontWeight.w400),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    items: itemsCompanySize
                                        .map((String item) =>
                                        DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: Get.theme.textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                color: AppColors.white),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                        .toList(),
                                    value: sizeValues,
                                    onChanged: (String? value) {
                                      setState(() {
                                        sizeValues = value;
                                        companySize = value;
                                      });
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: Get.height * 0.078,
                                      width: Get.width,
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(35),
                                        color: const Color(0xff373737),
                                      ),
                                      elevation: 2,
                                    ),
                                    iconStyleData: IconStyleData(
                                      icon: Image.asset(
                                          'assets/images/arrowdown.png'),
                                      iconSize: 14,
                                      iconEnabledColor: Colors.yellow,
                                      iconDisabledColor: Colors.grey,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: Get.height * 0.35,
                                      width: Get.width * 0.902,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: const Color(0xff353535),
                                      ),
                                      offset: const Offset(5, 0),
                                      scrollbarTheme: ScrollbarThemeData(
                                        radius: const Radius.circular(40),
                                        thickness: MaterialStateProperty.all<
                                            double>(6),
                                        thumbVisibility:
                                        MaterialStateProperty.all<bool>(true),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding: EdgeInsets.only(
                                          left: 14, right: 14),
                                    ),
                                  ),
                                ),
                              ),
                              Obx(() =>
                              CreateUpdateRecruiterProfileControllerInstanse
                                  .companySizeError.value.isEmpty ?
                              const SizedBox() :
                              Center(child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    CreateUpdateRecruiterProfileControllerInstanse
                                        .companySizeError.value,
                                    style: TextStyle(color: Colors.red),)))
                              ),
                              SizedBox(
                                height: Get.height * .04,
                              ),
                              Text(
                                "Founded",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: Get.height * .01,
                              ),
                              GestureDetector(
                                onTap: () => _selectDate(context),
                                child: Container(
                                  height: Get.height * 0.08,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff373737),
                                      borderRadius: BorderRadius.circular(35)),
                                  child: Padding(
                                    padding:
                                    EdgeInsets.symmetric(
                                        horizontal: Get.width * .04),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                          selectedDateString,
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                        GestureDetector(
                                          onTap: () => _selectDate(context),
                                          child: Image.asset(
                                            "assets/images/icon_calendar_blue.png",color: AppColors.blueThemeColor,
                                            height: Get.height * 0.030,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Obx(() =>
                              CreateUpdateRecruiterProfileControllerInstanse
                                  .foundedError.value.isEmpty ?
                              const SizedBox() :
                              Center(child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    CreateUpdateRecruiterProfileControllerInstanse
                                        .foundedError.value,
                                    style: TextStyle(color: Colors.red),)))
                              ),
                              SizedBox(
                                height: Get.height * .04,
                              ),
                              Text(
                                "Specialization",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: Get.height * .01,
                              ),
                              CommonWidgets.textFieldMaxLines(
                                context,
                                aboutySpecialtiesController,
                                "Enter Specialization",
                                onFieldSubmitted: (value) {},

                              ),
                              SizedBox(
                                height: Get.height * .05,
                              ),
                              Obx(
                                    () =>
                                    Center(
                                      child: MyButton(
                                        loading: CreateUpdateRecruiterProfileControllerInstanse
                                            .loading.value,
                                        title: "CONTINUE",
                                        onTap1: () {
                                          CreateUpdateRecruiterProfileControllerInstanse
                                              .profileImageError.value = "";
                                          CreateUpdateRecruiterProfileControllerInstanse
                                              .coverImageError.value = "";
                                          CreateUpdateRecruiterProfileControllerInstanse
                                              .industryError.value = "";
                                          CreateUpdateRecruiterProfileControllerInstanse
                                              .companySizeError.value = "";
                                          CreateUpdateRecruiterProfileControllerInstanse
                                              .foundedError.value = "";
                                          if (profileImage == null) {
                                            CreateUpdateRecruiterProfileControllerInstanse
                                                .profileImageError.value =
                                            "Please select profile image";
                                            scrollController.animateTo(0,
                                                duration: Duration(
                                                    microseconds: 100),
                                                curve: Curves.easeOut);
                                          } else if (coverImage == null) {
                                            CreateUpdateRecruiterProfileControllerInstanse
                                                .coverImageError.value =
                                            "Please select cover image";
                                            scrollController.animateTo(0,
                                                duration: Duration(
                                                    microseconds: 100),
                                                curve: Curves.easeOut);
                                          }

                                          else {
                                            if (formKey.currentState!
                                                .validate()) {
                                              if (industry == null) {
                                                CreateUpdateRecruiterProfileControllerInstanse
                                                    .industryError.value =
                                                "Please choose industry";
                                              } else if (companySize == null) {
                                                CreateUpdateRecruiterProfileControllerInstanse
                                                    .companySizeError.value =
                                                "Please select company size";
                                              } else if (founded == null) {
                                                CreateUpdateRecruiterProfileControllerInstanse
                                                    .foundedError.value =
                                                "Please select founded date";
                                              } else {
                                                CreateUpdateRecruiterProfileControllerInstanse
                                                    .createUpdateRecruiterProfileApi(
                                                    profilePath: profileImage
                                                        ?.path,
                                                    coverPath: coverImage?.path,
                                                    companyName: companyNameController
                                                        .text,
                                                    companyLocation:
                                                    companyLocationController
                                                        .text,
                                                    addBio: addBioController
                                                        .text,
                                                    homeTitleName: homeTitleNameController
                                                        .text,
                                                    homeDescription:
                                                    addBioController.text,
                                                    websiteLink: websiteLinkController
                                                        .text,
                                                    aboutTitleName: aboutTitleNameController
                                                        .text,
                                                    aboutDescription:
                                                    aboutDescriptionController
                                                        .text,
                                                    industry: industry,
                                                    companySize: companySize
                                                        ?.replaceAll(
                                                        "employees", ""),
                                                    founded: selectedDateString,
                                                    specialties: aboutySpecialtiesController.text,
                                                    contactPerson: contactPersonNameController
                                                        .text
                                                );
                                              }
                                            }
                                          }
                                        },
                                      ),
                                    ),
                              ),
                              SizedBox(
                                height: Get.height * .1,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ));
      }
    }
    );
  }
}
