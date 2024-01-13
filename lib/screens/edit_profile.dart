// import 'dart:io';
// import 'package:dinesh_project/bloc/user_bloc/user_bloc.dart';
// import 'package:dinesh_project/custom_widget/bnb.dart';
// import 'package:dinesh_project/custom_widget/custom_button.dart';
// import 'package:dinesh_project/custom_widget/custom_text_field.dart';
// import 'package:dinesh_project/custom_widget/gap.dart';
// import 'package:dinesh_project/models/user_model.dart';
// import 'package:dinesh_project/repository/app_repo.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:sizer/sizer.dart';
// import 'package:path/path.dart' as path;
//
// class EditProfileScreen extends StatefulWidget {
//   const EditProfileScreen({
//     Key? key,
//     this.name,
//     this.email,
//     this.phoneNumber,
//     this.profileImage,
//   }) : super(key: key);
//   final String? name;
//   final String? email;
//   final String? phoneNumber;
//   final String? profileImage;
//
//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }
//
// class _EditProfileScreenState extends State<EditProfileScreen> {
//   late TextEditingController nameController;
//   late TextEditingController phoneNumberController;
//   late TextEditingController emailController;
//   bool isLoading = false;
//   final _formKey = GlobalKey<FormState>();
//   final picker = ImagePicker();
//   String? imgUrl;
//   File? image;
//
//   @override
//   void initState() {
//     super.initState();
//     initController();
//   }
//
//   void initController() {
//     nameController = TextEditingController(text: widget.name ?? '');
//     phoneNumberController =
//         TextEditingController(text: widget.phoneNumber?.toString() ?? '');
//     emailController = TextEditingController(text: widget.email ?? '');
//     imgUrl = widget.profileImage ?? '';
//   }
//
//   @override
//   void dispose() {
//     nameController.dispose();
//     phoneNumberController.dispose();
//     emailController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           iconTheme: IconThemeData(color: Colors.white),
//           backgroundColor: Colors.deepPurple,
//           centerTitle: true,
//           title: Text(
//             'Edit Profile screen',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(8.0.sp),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   Text("Profile "),
//                   Gap1(),
//                   Stack(
//                     children: [
//                       CircleAvatar(
//                         backgroundImage: image != null
//                             ? FileImage(File(image!.path))
//                             : (imgUrl != null && imgUrl!.isNotEmpty
//                                     ? NetworkImage(imgUrl!)
//                                     : NetworkImage(
//                                         'https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg'))
//                                 as ImageProvider<
//                                     Object>, // Cast to ImageProvider<Object> type
//                         radius: 45.sp,
//                       ),
//                       Positioned(
//                         bottom: 0,
//                         right: 0,
//                         child: Material(
//                           type: MaterialType.transparency,
//                           child: Ink(
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: const Color(0xffFEEDE3),
//                                 width: 1,
//                               ),
//                               color: const Color(0xffFEEDE3),
//                               borderRadius: BorderRadius.circular(20.sp),
//                             ),
//                             child: InkWell(
//                               borderRadius: BorderRadius.circular(2.sp),
//                               highlightColor: Colors.transparent,
//                               splashColor: Colors.transparent,
//                               onTap: () {
//                                 showDialog(
//                                   context: context,
//                                   builder: (context) => AlertDialog(
//                                       title: const Text('Select the source'),
//                                       actions: [
//                                         Center(
//                                           child: Column(
//                                             children: [
//                                               ElevatedButton(
//                                                 onPressed: () {
//                                                   getImageFromCamera();
//                                                   Navigator.pop(context);
//                                                 },
//                                                 child: const Text('Camera'),
//                                               ),
//                                               ElevatedButton(
//                                                 onPressed: () {
//                                                   getImageFromGallery();
//                                                   Navigator.pop(context);
//                                                 },
//                                                 child: const Text('Gallery'),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ]),
//                                 );
//                               },
//                               child: Padding(
//                                 padding: EdgeInsets.all(2.sp),
//                                 child: const Icon(
//                                   Icons.edit,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Gap3(),
//                   CustomTextFieldTitle(
//                     controller: nameController,
//                     fieldTitle: "User Name",
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a name';
//                       }
//                       return null;
//                     },
//                   ),
//                   Gap2(),
//                   CustomTextFieldTitle(
//                     inputType: TextInputType.phone,
//                     controller: phoneNumberController,
//                     fieldTitle: "Phone Number",
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a phone number';
//                       }
//                       return null;
//                     },
//                   ),
//                   Gap2(),
//                   CustomTextFieldTitle(
//                     controller: emailController,
//                     fieldTitle: "Email",
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter an email address';
//                       }
//                       final emailRegExp =
//                           RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//
//                       if (!emailRegExp.hasMatch(value)) {
//                         return 'Please enter a valid email address';
//                       }
//
//                       return null;
//                     },
//                   ),
//                   const Gap3(),
//                   CustomButton(
//                     isLoading: isLoading,
//                     onTap: () async {
//                       setState(() {
//                         isLoading = true;
//                       });
//                       if (_formKey.currentState?.validate() ?? false) {
//                         if (image?.path != null) {
//                           String fileName = path.basename(image!.path);
//                           firebase_storage.Reference ref = firebase_storage
//                               .FirebaseStorage.instance
//                               .ref()
//                               .child('users/$fileName');
//                           firebase_storage.UploadTask uploadTask =
//                               ref.putFile(image!);
//                           firebase_storage.TaskSnapshot snapshot =
//                               await uploadTask;
//                           imgUrl = await snapshot.ref.getDownloadURL();
//                         }
//                         context.read<UserBloc>().add(UpdateProfileDataEvent(
//                             user: UserModel(
//                                 email: emailController.text,
//                                 userName: nameController.text,
//                                 phoneNumber: phoneNumberController.text,
//                                 profileImage: imgUrl,
//                                 uid: AppRepo().uid)));
//                         Navigator.pop(context);
//
//                       }      setState(() {
//                         isLoading = false;
//                       });
//                     },
//                     textColor: Colors.white,
//                     buttonText: "Submit",
//                     buttonColor: Colors.deepPurple,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }
//
//   Future getImageFromGallery() async {
//     final galleryPic =
//         await picker.pickImage(source: ImageSource.gallery, imageQuality: 97);
//     setState(() {
//       image = File(galleryPic!.path);
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Image Selected Successfully'),
//       ),
//     );
//   }
//
//   Future getImageFromCamera() async {
//     final cameraPic =
//         await picker.pickImage(source: ImageSource.camera, imageQuality: 97);
//     setState(() {
//       image = File(cameraPic!.path);
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         duration: Duration(seconds: 3),
//         content: Text('Image Selected Successfully'),
//       ),
//     );
//   }
// }
