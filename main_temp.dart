import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: const MyHomePage(title: 'My Orion (2023)'),
      debugShowCheckedModeBanner: false,
    );
  }
}


 
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {

  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Container(
        child: Text('Page1'),
      ), 
        // child: Column(
    
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     Container(
        //       padding: EdgeInsets.all(10.0),
        //       color: Colors.yellow,
              
        //       child: Text("Opas Leangkosakul"),
        //       ),
        //      Text(
        //       'this many times:'
        //     ),
        //   Text(
        //      '[$_counter]',
        //      style: Theme.of(context).textTheme.headlineMedium,
        //    ),
         // ],
        //),
      //),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context, 
          MaterialPageRoute(builder: (context)=> Page2()) , //_incrementCounter,
        //tooltip: 'Increment',
        ),child: const Icon(Icons.arrow_forward),
        
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Page2 extends StatelessWidget {
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
              child: Text('Page2'),
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