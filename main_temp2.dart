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
      home:  MyHomePage(title: 'My Orion (2023)'),
    );
  }
}


 
class MyHomePage extends StatelessWidget {
   MyHomePage({required this.title});


  final String title;
String description = "Hello Orion";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(title),
      ),
      body: Container(
        child: Text('Page1'),
      ), 
      
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context, 
          MaterialPageRoute(builder: (context)=> Page2(description: "Orion Ja",)) , //_incrementCounter,
        //tooltip: 'Increment',
        ),child: const Icon(Icons.arrow_forward),
        
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
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