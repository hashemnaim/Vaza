import 'package:faza_app/utils/values.dart';
import 'package:faza_app/Module/components/appbar.dart';
import 'package:faza_app/Module/setting/edit_profile/controller/edit_profile_controller.dart';
import 'package:faza_app/widgets/custom_button.dart';
import 'package:faza_app/widgets/custom_input.dart';
import 'package:faza_app/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:form_field_validator/form_field_validator.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var editProfileController = Get.put(EditProfileController());
    return Scaffold(
      appBar: customAppBar('EDIT_PROFILE'.tr),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.all(kPadding),
          child: Container(
            width: widthOfScreen(context),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.backgroundColor,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(kPadding),
              child: Form(
                key: editProfileController.formKey,
                child: Column(
                  children: [
                    const SpaceH20(),
                    SizedBox(
                      height: 115,
                      width: 115,
                      child: Stack(
                        fit: StackFit.expand,
                        clipBehavior: Clip.none,
                        children: [
                          Obx(
                            () => editProfileController.filePath.value.path !=
                                    ''
                                ? Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: FileImage(
                                          editProfileController.filePath.value,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                :
                                // editProfileController.imagePath.value == ""
                                //     ? CustomAvatar(
                                //         text: editProfileController
                                //             .editProfileUserNameController.text,
                                //         size: 100,
                                //       )
                                //     :
                                CustomNetworkImage(
                                    imagePath:
                                        editProfileController.imagePath.value,
                                    height: 100,
                                    width: 100,
                                    borderRadius: 100,
                                    boxFit: BoxFit.cover,
                                  ),
                          ),
                          Positioned(
                            right: 5,
                            bottom: 5,
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  backgroundColor: AppColors.primaryColor,
                                ),
                                onPressed: () {
                                  changeProfileModal(
                                      context, editProfileController);
                                },
                                child: const Icon(Icons.camera_enhance),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SpaceH20(),
                        Text(
                          'USERNAME'.tr,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        CustomInput(
                          title: '',
                          hint: "ENTER_YOUR_NAME".tr,
                          textInputType: TextInputType.text,
                          controller: editProfileController
                              .editProfileUserNameController,
                          formValidator: MultiValidator([
                            RequiredValidator(
                                errorText: "USERNAME_IS_REQUIRED".tr),
                          ]),
                        ),
                        const SpaceH20(),
                        Text(
                          'EMAIL'.tr,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        CustomInput(
                          title: '',
                          hint: "ENTER_YOUR_EMAIL".tr,
                          textInputType: TextInputType.text,
                          controller:
                              editProfileController.editProfileEMailController,
                          formValidator: MultiValidator([
                            RequiredValidator(
                                errorText: "EMAIL_IS_REQUIRED".tr),
                          ]),
                        ),
                        const SpaceH36(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: CustomPrimaryButton(
          text: "SAVE_CHANGES".tr,
          onPress: () {
            // editProfileController.filePath.value.path.isEmpty
            //     ?
            editProfileController.editProfileBtn();
            // : editProfileController.uploadImage(context);
          },
          color: AppColors.primaryColor,
          textColor: AppColors.primaryTextColor,
        ),
      ),
    );
  }
}

changeProfileModal(
    BuildContext context, EditProfileController editProfileController) {
  Get.defaultDialog(
    contentPadding: const EdgeInsets.symmetric(
      horizontal: kPadding,
    ),
    title: "",
    titlePadding: const EdgeInsets.all(0),
    content: Container(
      color: AppColors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          editProfileController.filePath.value.path.isNotEmpty
              ? Container(
                  height: 115,
                  width: 115,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: FileImage(
                        editProfileController.filePath.value,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              :
              //  editProfileController.imagePath.value == ""
              //     ? CustomAvatar(
              //         text: editProfileController
              //             .editProfileUserNameController.text,
              //         size: 80,
              //       )
              //     :
              CustomNetworkImage(
                  imagePath: editProfileController.imagePath.value,
                  height: 115,
                  width: 115,
                  borderRadius: 100,
                  boxFit: BoxFit.cover,
                ),
          const SpaceH8(),
          Text(
            "UPDATE_YOUR_PROFILE_PICTURE".tr,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
            textAlign: TextAlign.center,
          ),
          const SpaceH8(),
          Text(
            "UPLOAD_PHOTO_FROM_YOUR_CAMERA_ROLL".tr,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.grey,
                ),
            textAlign: TextAlign.center,
          ),
          const SpaceH8(),
          CustomTextButton(
            text: "OPEN_CAMERA".tr,
            color: AppColors.primaryColor,
            onPress: () {
              if (Get.isDialogOpen!) Get.back();
              editProfileController.updateProfilePhoto(false);
            },
          ),
          CustomTextButton(
            text: "OPEN_PHOTO_LIBRARY".tr,
            color: AppColors.primaryColor,
            onPress: () {
              if (Get.isDialogOpen!) Get.back();
              editProfileController.updateProfilePhoto(true);
            },
          ),
        ],
      ),
    ),
  );
}
