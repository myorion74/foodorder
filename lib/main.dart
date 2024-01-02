import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      
      theme: ThemeData(
     
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: FormPage(), //MyHomePage(title: 'My Orion (2023)'),
    );
  }
}


 
class MyHomePage extends StatelessWidget {
   MyHomePage({required this.title, required this.data, required this.age, required this.menu});
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
              SaveMessage(data,menu),
            ],
            
     
        ),
      ), 
      
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context, 
          MaterialPageRoute(builder: (context)=> Page2(description: "Hello $data",)) , 
        ),child: const Icon(Icons.arrow_forward),
        
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
Widget SaveMessage(String data,List<String> menu){
  
  return Container(
    width: 300,
    height: 300,
    child: Center(
      child: Column(
            children: menu.map((e) => Text(e)).toList(),
    )
    ));
}

class FormPage extends StatefulWidget{
 @override
 _FormPageState createState () => _FormPageState();

} 

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String lastname;
  late int age;
  late String selectedSex="male";
  late bool _isOption1=false;
  late bool _isOption2=false;
  late bool _isOption3=false;
  late bool _isOption4=false;

  late String errormessage="";

  List<String> selectedOptions = [];

void _onRadioChange(String value){
    setState(() {
    selectedSex = value;
  });
  print(value);
}

@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      title: Text('Form'),
    ),

     body: Center(
       child: Container(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key:  _formKey,
          child: Column(
            children: <Widget>[
              Text("First Name:"),
              TextFormField(
              initialValue: "",
              onSaved: (value) => setState(() {
                name = value!;
              }), //,
              ),
              Text("LastName:"),
              TextFormField(
                initialValue: "",
                onSaved: (value)=> setState(() {
                  lastname = value!;
                }),
              ),
              Text("Age"),
              TextFormField(
                initialValue: "",
                onSaved: (value)=>setState(() {
                  age = int.parse(value!);
                }),
              ),
              Text("Gender:"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Radio(value: 'male', groupValue: selectedSex, 
                  onChanged: (value) => _onRadioChange(value!)),
                  Text('male'),
                  Radio(value: 'female', groupValue: selectedSex, 
                  onChanged: (value) => _onRadioChange(value!)),
                  Text('female')
                ],
              ),
    Column(children: [
        CheckboxListTile(
          title: const Text('เนื้อหมูย่าง'), 
          value: _isOption1 , 
          onChanged: (val) {
            setState(() {
              _isOption1 =!_isOption1;
              if(_isOption1){
                selectedOptions.add("Pork1");
              }else{
                selectedOptions.remove("Pork1");
              }
              selectedOptions.remove("Fire Rice");
            });
          } ),
          CheckboxListTile(
            title: const Text("ซีกโครงหมูย่าง"),
            value: _isOption2, 
            onChanged: (val)=>
            setState(() {
              _isOption2=!_isOption2;
              if(_isOption2)
              {
                selectedOptions.add("Pork2");
              }else{
                selectedOptions.remove("Pork2");
              }

            })
            ),
            CheckboxListTile(
              title: Text("ไก่ทอดซอสเกาหลี"),
              value: _isOption3, 
              onChanged: (val)=>
              setState(() {
                _isOption3=!_isOption3;
                if(_isOption3)
                {
                  selectedOptions.add("Pork3");
                }else
                {
                  selectedOptions.remove("Pork3");
                }
              })),
              CheckboxListTile(
                title: Text("ปีกไก่ทอด"),
                value: _isOption4,
                onChanged: (val)=>
                setState(() {
                  _isOption4 =!_isOption4;
                  if(_isOption4)
                  {
                    selectedOptions.add("fire_chicken");
                  }else{
                    selectedOptions.remove("fire_chicken");
                  }
                })
                )
    ],),
              ElevatedButton(
              onPressed: (){
                if(_formKey.currentState!.validate()) {
                  //if(name!="" && lastname !="" )
                  if(1==1)
                  {
                    _formKey.currentState!.save();
                    print(name);
                    print(selectedOptions);
                    print('Save');
                  
                    Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context)=> 
                      MyHomePage(
                        title: "Orders",
                        data: "$selectedSex $name $lastname",
                        age: age,
                        menu: selectedOptions
                        )));
                  }else
                  {
                    errormessage ="Name or Lastname are empty";
                     print(name);
                      print(lastname);
                    print("Name or Lastname are empty");
                  }
                }
              }, 
              child: Text('Save'),
              ),
              
            ],
          ),
         ),
       ),
     ),
);
}//Scaffold
  
}

class Page2 extends StatelessWidget {
  final String description;

  const Page2({super.key, required this.description});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(

        title: Text('Page2'),
        ),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width:300,
              height: 300,
              child: Image.asset('assets/IMG_7846.jpeg')),
            
            Container(
              padding: EdgeInsets.all(15.0),

              child: Text(description),
            ), ElevatedButton(
              onPressed: () => Navigator.pop(context), 
              //MaterialPageRoute(builder:  (context) =>  MyHomePage(title:'Page1',)),
              //), 
              child: Text('Back'),),
          ]
      ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}