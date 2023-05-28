import 'package:Dinhi_v1/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:intl/intl.dart';
import 'database.dart';

class RegParent extends StatelessWidget {
  const RegParent({Key? key, required}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration Page',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: FormBuilderLocalizations.delegate.supportedLocales,
      home: const RegChild(),
    );
  }
}

class RegChild extends StatefulWidget {
  const RegChild({Key? key}) : super(key: key);

  @override
  State<RegChild> createState() {
    return _RegChildState();
  }
}

class _RegChildState extends State<RegChild> {
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final _formKey = GlobalKey<FormBuilderState>();
  bool _fnHasError = false;
  bool _lnHasError = false;
  bool _honorificHasError = false;
  bool _cnHasError = false;
  bool _emailHasError = false;
  bool _pwordHasError = false;
  bool _cpwordHasError = false;
  bool _addressHasError = false;
  bool _userTypeHasError = false;
  bool _userIdHasError = false;

  var userOptions = ['Buyer', 'Seller', 'Courier'];
  var honorificOptions = ['Mr.', 'Mrs.', 'Ms.', 'Mx.'];
  var pword = '';
  String idno = '';
  List user1 = [];
  List user2 = [];
  List user3 = [];
  List user4 = [];

  void _onChanged(dynamic val) => debugPrint(val.toString());

  Future<void> storeUserID() async {
    List<dynamic> userList = await db.readUsers();
    for (dynamic item in userList) {
      if (item['usertype'] == 'Admin') {
        user1.add(item['idno']);
      } else if (item['usertype'] == 'Buyer') {
        user2.add(item['idno']);
      } else if (item['usertype'] == 'Courier') {
        user3.add(item['idno']);
      } else {
        user4.add(item['idno']);
      }
    }
  }

  String setIndicator(String value) {
    String indicator = '';
    if (value == 'Admin') {
      indicator = 'A';
    } else if (value == 'Buyer') {
      indicator = 'B';
    } else if (value == 'Courier') {
      indicator = 'C';
    } else {
      indicator = 'S';
    }
    return indicator;
  }

  String getIdNo(String indicator) {
    List userType = [];
    String temp = '';
    String temp1 = '';
    var temp2 = 0;
    if (indicator == 'A') {
      userType = user1;
    } else if (indicator == 'B') {
      userType = user2;
    } else if (indicator == 'C') {
      userType = user3;
    } else {
      userType = user4;
    }

    temp = userType.last;
    temp1 = temp.substring(1, 4);
    temp2 = int.parse(temp1);
    idno = indicator + (temp2 + 1).toString().padLeft(3, '0');

    return idno;
  }

  Database db = Database();
  Map<String, dynamic> newUser = {};

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController firstnameController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();
  TextEditingController honorificController = new TextEditingController();
  TextEditingController idnoController = new TextEditingController();
  TextEditingController usertypeController = new TextEditingController();
  TextEditingController cellnumberController = new TextEditingController();
  TextEditingController birthdayController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    storeUserID();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 171, 195, 47),
      // appBar: AppBar(title: const Text('Registration Form'), centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/images/Logo.PNG',
                width: 150,
                height: 150,
              ),
              FormBuilder(
                key: _formKey,
                // enabled: false,
                onChanged: () {
                  _formKey.currentState!.save();
                  // debugPrint(_formKey.currentState!.value.toString());
                },
                autovalidateMode: AutovalidateMode.disabled,
                // initialValue: const {
                //   'firstname': 'First Name',
                //   'lastname': 'Last Name',
                //   'cellnumber': '09XXXXXXXXX',
                //   'email': 'Email',
                //   'password': 'Password',
                //   'cpassword': 'Confirm Password',
                //   'address': 'Address',
                //   'honorific': 'Mx.',
                //   'usertype': 'Buyer',
                // },
                skipDisabled: true,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 15),
                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.disabled,
                      name: 'firstname',
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 3, left: 10),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'First Name',
                        hintText: 'Enter First Name',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 117, 113, 113),
                        ),
                        // suffixIcon: _fnHasError
                        //     ? const Icon(Icons.error, color: Colors.red)
                        //     : const Icon(Icons.check, color: Colors.green),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _fnHasError = !(_formKey
                                      .currentState?.fields['firstname']
                                      ?.validate() !=
                                  null
                              ? true
                              : false);
                        });
                      },
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 10),
                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.disabled,
                      name: 'lastname',
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 3, left: 10),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Last Name',
                        hintText: 'Enter Last Name',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 117, 113, 113),
                        ),
                        // suffixIcon: _lnHasError
                        //     ? const Icon(Icons.error, color: Colors.red)
                        //     : const Icon(Icons.check, color: Colors.green),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _lnHasError = !(_formKey
                                      .currentState?.fields['lastname']
                                      ?.validate() !=
                                  null
                              ? true
                              : false);
                        });
                      },
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        // FormBuilderValidators.numeric(),
                        // FormBuilderValidators.max(70),
                      ]),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 10),
                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.disabled,
                      name: 'cellnumber',
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 3, left: 10),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Contact Number',
                        hintText: 'Enter Contact Number',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 117, 113, 113),
                        ),
                        // suffixIcon: _cnHasError
                        //     ? const Icon(Icons.error, color: Colors.red)
                        //     : const Icon(Icons.check, color: Colors.green),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _cnHasError = !(_formKey
                                      .currentState?.fields['cellnumber']
                                      ?.validate() !=
                                  null
                              ? true
                              : false);
                        });
                      },
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 10),
                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.disabled,
                      name: 'email',
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 3, left: 10),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Email',
                        hintText: 'Enter Email',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 117, 113, 113),
                        ),
                        // suffixIcon: _emailHasError
                        //     ? const Icon(Icons.error, color: Colors.red)
                        //     : const Icon(Icons.check, color: Colors.green),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _emailHasError = !(_formKey
                                      .currentState?.fields['email']
                                      ?.validate() !=
                                  null
                              ? true
                              : false);
                        });
                      },
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                      ]),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 10),
                    FormBuilderTextField(
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.disabled,
                      name: 'password',
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 3, left: 10),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Password',
                        hintText: 'Enter Password',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 117, 113, 113),
                        ),
                        // suffixIcon: _pwordHasError
                        //     ? const Icon(Icons.error, color: Colors.red)
                        //     : const Icon(Icons.check, color: Colors.green),
                      ),
                      onChanged: (val) {
                        setState(() {
                          pword = _formKey.currentState?.value['password'];
                          _pwordHasError = !(_formKey
                                      .currentState?.fields['password']
                                      ?.validate() !=
                                  null
                              ? true
                              : false);
                        });
                      },
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 10),
                    FormBuilderTextField(
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.disabled,
                      name: 'cpassword',
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 3, left: 10),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Confirm Password',
                        hintText: 'Confirm Password',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 117, 113, 113),
                        ),
                        // suffixIcon: _cpwordHasError
                        //     ? const Icon(Icons.error, color: Colors.red)
                        //     : const Icon(Icons.check, color: Colors.green),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _cpwordHasError = !(_formKey
                                      .currentState?.fields['cpassword']
                                      ?.validate() !=
                                  null
                              ? true
                              : false);
                        });
                      },
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.match(pword),
                      ]),
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 10),
                    FormBuilderDateTimePicker(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'birthday',
                      initialEntryMode: DatePickerEntryMode.calendar,
                      initialValue: DateTime.now(),
                      inputType: InputType.date,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 3, left: 10),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Date of Birth',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _formKey.currentState!.fields['birthday']
                                ?.didChange(null);
                          },
                        ),
                      ),
                      // locale: const Locale.fromSubtags(languageCode: 'fr'),
                    ),
                    const SizedBox(height: 10),
                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.disabled,
                      name: 'address',
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 3, left: 10),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Complete Address',
                        hintText: 'Enter Complete Address',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 117, 113, 113),
                        ),
                        // suffixIcon: _addressHasError
                        //     ? const Icon(Icons.error, color: Colors.red)
                        //     : const Icon(Icons.check, color: Colors.green),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _addressHasError = !(_formKey
                                      .currentState?.fields['address']
                                      ?.validate() !=
                                  null
                              ? true
                              : false);
                        });
                      },
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      keyboardType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 10),
                    FormBuilderDropdown<String>(
                      // autovalidate: true,
                      name: 'honorific',
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 3, left: 10),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Title/Honorific',
                        hintText: 'Select Honorific',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 117, 113, 113),
                        ),
                        // suffix: _honorificHasError
                        //     ? const Icon(Icons.error)
                        //     : const Icon(Icons.check),
                      ),
                      // hint: const Text('Select User'),
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()]),
                      items: honorificOptions
                          .map((user) => DropdownMenuItem(
                                alignment: AlignmentDirectional.center,
                                value: user,
                                child: Text(user),
                              ))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _honorificHasError = !(_formKey
                                      .currentState?.fields['honorific']
                                      ?.validate() !=
                                  null
                              ? true
                              : false);
                        });
                      },
                      valueTransformer: (val) => val?.toString(),
                    ),
                    const SizedBox(height: 10),
                    FormBuilderDropdown<String>(
                      // autovalidate: true,
                      name: 'usertype',
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 3, left: 10),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'User Type',
                        hintText: 'Select User Type',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 117, 113, 113),
                        ),
                        // suffix: _userTypeHasError
                        //     ? const Icon(Icons.error)
                        //     : const Icon(Icons.check),
                      ),
                      // hint: const Text('Select User'),
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()]),
                      items: userOptions
                          .map((user) => DropdownMenuItem(
                                alignment: AlignmentDirectional.center,
                                value: user,
                                child: Text(user),
                              ))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _userTypeHasError = !(_formKey
                                      .currentState?.fields['usertype']
                                      ?.validate() !=
                                  null
                              ? true
                              : false);
                          idno = getIdNo(setIndicator(
                              _formKey.currentState?.value['usertype']));
                        });
                      },
                      valueTransformer: (val) => val?.toString(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 9, 117, 8)),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 50)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ))),
                    onPressed: () async {
                      if (_formKey.currentState?.saveAndValidate() ?? false) {
                        debugPrint(_formKey.currentState!.value.toString());
                        newUser = _formKey.currentState!.value;
                        Map<String, dynamic> cloneMap = {...newUser};
                        cloneMap['idno'] = idno;
                        cloneMap['image'] = '';
                        cloneMap['about'] = '';
                        if (idno.startsWith('S', 0)) {
                          cloneMap['products'] = <String>[];
                          cloneMap['orderlist'] = <String>[];
                        } else if (idno.startsWith('B', 0)) {
                          cloneMap['cart'] = <String>[];
                          cloneMap['orderlist'] = <String>[];
                        }
                        await db
                            .createUser(cloneMap)
                            .then((value) => Get.off(const LoginParent()));
                      } else {
                        debugPrint(_formKey.currentState?.value.toString());
                        debugPrint('Validation failed');
                      }
                    },
                    child: const Text(
                      'SUBMIT',
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ))),
                      onPressed: () {
                        Get.off(const LoginParent());
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
