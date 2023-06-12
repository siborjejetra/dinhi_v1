import 'dart:io';

import 'package:Dinhi_v1/Seller/home.dart';
import 'package:Dinhi_v1/database.dart';
import 'package:Dinhi_v1/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localstorage/localstorage.dart';
import 'database.dart';
import 'model/user.dart';

class ProductParent extends StatelessWidget {
  Map userMap;
  ProductParent({Key? key, required this.userMap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Add Product',
      home: ProductChild(userMap: userMap),
    );
  }
}

class ProductChild extends StatefulWidget {
  ProductChild({Key? key, required this.userMap}) : super(key: key);
  Map userMap;
  @override
  State<ProductChild> createState() => _ProductChildState();
}

class _ProductChildState extends State<ProductChild> {
  String text = '';
  final title = 'Add Product';
  TextEditingController nameController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController quantityController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController unitController = new TextEditingController();
  TextEditingController expDateController = new TextEditingController();

  LocalStorage localStorage = LocalStorage('user');

  File? inputImage;
  String path = '';
  bool hasUploaded = false;

  Database db = Database();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map userDetails = widget.userMap;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 236, 163),
      appBar: buildAppbar(context, title, false),
      body: Container(
        padding: EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Center(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 32),
              physics: BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 20),
                Material(
                  color: Colors.transparent,
                  child: Ink(
                      child: InkWell(
                    child: inputImage != null
                        ? Image.file(
                            inputImage!,
                            width: 128,
                            height: 128,
                          )
                        : Image.asset(
                            'assets/images/AddImage.png',
                            width: 128,
                            height: 128,
                          ),
                    onTap: () {
                      pickImage(ImageSource.gallery);
                    },
                  )),
                ),
                const SizedBox(height: 20),
                buildTextField('Name', nameController),
                const SizedBox(height: 20),
                buildTextField('Price', priceController),
                const SizedBox(height: 20),
                buildTextField('Quantity', quantityController),
                const SizedBox(height: 20),
                buildTextField('Unit', unitController),
                const SizedBox(height: 20),
                buildTextField('Decription', descriptionController),
                const SizedBox(height: 20),
                FormBuilderDateTimePicker(
                  name: 'expiration',
                  controller: expDateController,
                  initialEntryMode: DatePickerEntryMode.calendar,
                  initialValue: DateTime.now(),
                  inputType: InputType.date,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: EdgeInsets.only(bottom: 3, left: 10),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Expiration Date',
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 111, 174, 23)),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(horizontal: 50)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ))),
                      onPressed: () {
                        db
                            .createProduct(
                                localStorage.getItem('userID'),
                                inputImage,
                                nameController.text,
                                priceController.text,
                                quantityController.text,
                                unitController.text,
                                "0",
                                descriptionController.text,
                                Timestamp.fromDate(DateTime.now()),
                                userDetails)
                            .then((cloneMap) {
                          print('Here');
                          print(cloneMap);
                          Get.to(HomeSellerParent(userMap: cloneMap));
                        });
                        // Timestamp.fromDate(DateTime.parse(expDateController.text))
                      },
                      child: const Text(
                        'SAVE',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    ),
                    OutlinedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(horizontal: 50)),
                            elevation: MaterialStateProperty.all(2),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ))),
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text(
                          'CANCEL',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                              letterSpacing: 2.2,
                              color: Color.fromARGB(255, 111, 174, 23)),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: EdgeInsets.only(bottom: 3, left: 10),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: label,
          hintStyle: const TextStyle(
            fontSize: 16,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ));
  }

  Future pickImage(ImageSource source) async {
    try {
      XFile? pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        setState(() {
          inputImage = File(pickedImage.path);
        });
      } else
        return;
    } on PlatformException catch (e) {
      // showFailedToChooseDialog(context);
    } catch (e) {
      // showFailedToChooseDialog(context);
    }
  }
}
