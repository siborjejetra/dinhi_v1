import 'dart:io';

import 'package:Dinhi_v1/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductParent extends StatelessWidget {
  const ProductParent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Add Product',
      home: ProductChild(),
    );
  }
}

class ProductChild extends StatefulWidget {
  const ProductChild({Key? key}) : super(key: key);

  @override
  State<ProductChild> createState() => _ProductChildState();
}

class _ProductChildState extends State<ProductChild> {
  String text = '';
  final title = 'Add Product';
  TextEditingController nameController = new TextEditingController(); 
  TextEditingController priceController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController unitController = new TextEditingController();

  File? inputImage;
  String path = '';
  bool hasUploaded = false;

  @override
  void initState(){
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 236, 163),
      appBar: buildAppbar(context, title),
      body: Container(
        padding: EdgeInsets.all(10),
        child: GestureDetector(
          onTap: (){
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
                      child: inputImage != null ? Container(
                        child:Image.file(inputImage!, 
                          width: 128,
                          height:128,)
                        ): Container(
                          child:Image.asset('assets/images/AddImage.png', 
                          width: 128,
                          height:128,)
                        ),
                      onTap: () {
                        pickImage(ImageSource.gallery);
                      },
                    )
                  ),
                ),
                const SizedBox(height: 20),
                buildTextField('Name', nameController),
                const SizedBox(height: 20),
                buildTextField('Price', priceController),
                const SizedBox(height: 20),
                buildTextField('Unit', unitController),
                const SizedBox(height: 20),
                buildTextField('Decription', descriptionController),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style:ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 111, 174, 23)),
                        padding:MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 50)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )
                        )
                      ),
                      onPressed: () {
                        
                      }, 
                      child: Text(
                        'SAVE',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          letterSpacing: 2.2,
                          color: Colors.white
                        ),
                      ),
                    ),
                    OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        padding:MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 50)),
                        elevation: MaterialStateProperty.all(2), 
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )
                        )
                      ),
                      onPressed: (){
                        Get.back();
                      }, 
                      child: Text(
                        'CANCEL',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          letterSpacing: 2.2,
                          color: Color.fromARGB(255, 111, 174, 23)
                        ),
                      )
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );;
  }

  Widget buildTextField(String label, TextEditingController controller){
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: EdgeInsets.only(bottom: 3, left: 10),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: label,
        hintStyle: TextStyle(
          fontSize: 16,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      )
    );
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