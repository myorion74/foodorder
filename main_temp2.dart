import 'dart:convert';
//import 'dart:html';
import 'package:http/http.dart' as http;
//import 'package:cors/cors.dart';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:developer' as developer;

int code = -100;
String message = "";
Future<void> makeApiCall() async {
  // Replace 'YOUR_API_ENDPOINT' with the actual API endpoint you want to call
  const apiUrl = 'https://stage.fundconnext.com/api/auth';

  // Replace 'YOUR_JWT_TOKEN' with the actual JWT token you want to use for authentication
  //const jwtToken = '';

  try {
    // Create the request body
    var headers = {
      'Content-Type': 'application/json',
      //'Authorization': 'Bearer $jwtToken',
    };
    var request = http.Request('POST', Uri.parse(apiUrl));
    //http.Response response = await http.Post(Uri.parse(url));
    request.body =
        json.encode({"username": "API_YUANTA01", "password": "password"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var result = await http.Response.fromStream(response);

    code = -110; //response.statusCode.toString();
    if (response.statusCode == 200) {
      final data = json.decode(result.body);
      message = '${data['access_token']}';
      code = 200;
    } else {
      code = -120;
      final errMsg = json.decode(result.body);
      message = "API Error: ${errMsg['errMsg']['message']}";
      // developer.log(
      //   'API Error: ${response.reasonPhrase} - ${response.stream.bytesToString()}');
    }
  } catch (e) {
    // Handle network or ot
    //her errors

    message = 'try: ${e.toString()}';
    //print('$e');
    developer.log('Error: $e');
  }
}

void main() {
  makeApiCall();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Center',

      theme: ThemeData(
          primarySwatch: Colors.pink,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: FormPage(code, message), //MyHomePage(title: 'My Orion (2023)'),
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatelessWidget {
  MyHomePage(
      {super.key,
      required this.title,
      required this.data,
      required this.age,
      required this.menu});

  final String title;
  final String data;
  final int age;
  final List<String> menu;
  String description = "Hello Orion";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Image.network('https://en.wikipedia.org/wiki/Buldak#/media/File:Korean_barbeque-Buldak-01.jpg'),
            Text(data),
            Text("อายุ $age ปี"),
            SaveMessage(data, menu),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Page2(
                    description: "Hello $data",
                  )),
        ),
        child: const Icon(Icons.arrow_forward),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// ignore: non_constant_identifier_names
Widget SaveMessage(String data, List<String> menu) {
  return SizedBox(
      width: 300,
      height: 300,
      child: Center(
          child: Column(
        children: menu.map((e) => Text(e)).toList(),
      )));
}

class FormPage extends StatefulWidget {
  const FormPage(int code, String data2, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  late String name = "";
  late String lastname = "";
  late int age = 0;
  late String selectedSex = "male";
  late bool _isOption1 = false;
  late bool _isOption2 = false;
  late bool _isOption3 = false;
  late bool _isOption4 = false;

  late String errormessage = "";

  List<String> selectedOptions = [];

  void _onRadioChange(String value) {
    setState(() {
      selectedSex = value;
    });
    developer.log(
      'onRadioChange',
      name: '_FormPageState',
      error: value,
    );
    //print(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Form'),
        ),
        body: Center(
            child: Container(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      const Text("First Name:"),
                      TextFormField(
                        initialValue: "",
                        onSaved: (value) => setState(() {
                          name = value!;
                        }), //,
                      ),
                      const Text("LastName:"),
                      TextFormField(
                        initialValue: "",
                        onSaved: (value) => setState(() {
                          lastname = value!;
                        }),
                      ),
                      const Text("Age"),
                      TextFormField(
                        initialValue: "",
                        onSaved: (value) => setState(() {
                          age = int.parse(value!);
                        }),
                      ),
                      const Text("Gender:"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Radio(
                              value: 'male',
                              groupValue: selectedSex,
                              onChanged: (value) => _onRadioChange(value!)),
                          const Text('male'),
                          Radio(
                              value: 'female',
                              groupValue: selectedSex,
                              onChanged: (value) => _onRadioChange(value!)),
                          const Text('female')
                        ],
                      ),
                      Column(children: [
                        QrImageView(
                          data: '0818118145',
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                      ]),
                      Column(
                        children: [
                          CheckboxListTile(
                              title: const Text('เนื้อหมูย่าง'),
                              value: _isOption1,
                              onChanged: (val) {
                                setState(() {
                                  _isOption1 = !_isOption1;
                                  if (_isOption1) {
                                    selectedOptions.add("Pork1");
                                  } else {
                                    selectedOptions.remove("Pork1");
                                  }
                                  selectedOptions.remove("Fire Rice");
                                });
                              }),
                          CheckboxListTile(
                              title: const Text("ซีกโครงหมูย่าง"),
                              value: _isOption2,
                              onChanged: (val) => setState(() {
                                    _isOption2 = !_isOption2;
                                    if (_isOption2) {
                                      selectedOptions.add("Pork2");
                                    } else {
                                      selectedOptions.remove("Pork2");
                                    }
                                  })),
                          CheckboxListTile(
                              title: const Text("ไก่ทอดซอสเกาหลี"),
                              value: _isOption3,
                              onChanged: (val) => setState(() {
                                    _isOption3 = !_isOption3;
                                    if (_isOption3) {
                                      selectedOptions.add("Pork3");
                                    } else {
                                      selectedOptions.remove("Pork3");
                                    }
                                  })),
                          CheckboxListTile(
                              title: const Text("ปีกไก่ทอด"),
                              value: _isOption4,
                              onChanged: (val) => setState(() {
                                    _isOption4 = !_isOption4;
                                    if (_isOption4) {
                                      selectedOptions.add("fire_chicken");
                                    } else {
                                      selectedOptions.remove("fire_chicken");
                                    }
                                  })),
                          Text('$code'),
                          Text(message),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                    title: const Text('ยืนยันการสั่งอาหาร'),
                                    content: const Text('รายการอาหาร'),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('ยกเลิก'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          developer.log("check validate");
                                          if (_formKey.currentState!
                                              .validate()) {
                                            //if(name!="" && lastname !="" )
                                            if (1 == 1) {
                                              _formKey.currentState!.save();

                                              developer.log(name);
                                              developer.log(
                                                  selectedOptions.toString());
                                              developer.log("Save");

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => MyHomePage(
                                                          title: "Orders",
                                                          data:
                                                              "$selectedSex $name $lastname",
                                                          age: age,
                                                          menu:
                                                              selectedOptions)));
                                            } else {
                                              //errormessage = "Name or Lastname are empty";
                                              developer.log(
                                                'onRadioChange',
                                                name: '_FormPageState',
                                                error:
                                                    "$name $lastname is Empty",
                                              );
                                            }
                                          }
                                        },
                                        child: const Text('ยืนยัน'),
                                      )
                                    ])),
                        child: const Text('พร้อม'),
                      )
                    ])))));
  } //Scaffold
}

class Page2 extends StatelessWidget {
  final String description;

  const Page2({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page2'),
      ),
      body: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          SizedBox(
              width: 300,
              height: 300,
              child: Image.asset('assets/IMG_7846.jpeg')),
          SizedBox(
            width: 300,
            height: 300,
            child: Image.network(
                'https://www.manjarokitchen.com/wp-content/uploads/rpress/2020/05/grilled-chicken-spicy.png'),
          ),
          Container(
            padding: const EdgeInsets.all(15.0),
            child: Text(description),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            //MaterialPageRoute(builder:  (context) =>  MyHomePage(title:'Page1',)),
            //),
            child: const Text('Back'),
          ),
        ]), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
