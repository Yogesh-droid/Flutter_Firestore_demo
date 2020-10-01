import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final inputnameController=TextEditingController();
  final inputSurnameController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('data'),),
      body: Container(
        child: Column(
          children: [
            TextField(controller:inputnameController,
        decoration: InputDecoration(labelText: 'name'),),
            TextField(controller:inputSurnameController,
              decoration: InputDecoration(labelText: 'name'),),
            RaisedButton(
              child: Text('input'),
              onPressed: (){
              var myMap={'name':inputnameController.text,'surname':inputSurnameController.text};
              saveData(myMap);
            },),
            RaisedButton(
              onPressed: (){
                extractData();
              },
            )
          ],
        ),
      ),
    );
  }

   Future<void> saveData(Map myMap)async {
      FirebaseFirestore.instance.collection('a').add(myMap);
  }

  Future<void> extractData()async {
    FirebaseFirestore.instance.collection('a').getDocuments().then((value) {
      value.documents.forEach((element) {
        print(element.data());
      });
    });
  }

}

