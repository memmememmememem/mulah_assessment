import 'package:csv/csv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb){
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyDxMWH64pXvCbgdYTfJneWmVEWMhNGqR38',
          appId: '1:1070882089674:web:31a821daa9382c1ca6e233',
          messagingSenderId: '1070882089674',
          projectId: 'mulah-67131',
          storageBucket: 'mulah-67131.appspot.com',
          authDomain: 'mulah-67131.firebaseapp.com',
          measurementId: 'G-B8ZYSGNESZ'
      )
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ana Sofiya',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
        home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<dynamic>> _data = [];
  List<List<dynamic>> _data2 = [
    ['Alpha',''],
    ['Beta',''],
    ['Charlie',''],
  ];

  @override
  void initState() {
    super.initState();
    _loadCSV();
  }

  void _loadCSV() async {
    try {
      final rawData =
      await rootBundle.loadString("assets/Table_Input.csv");
      List<List<dynamic>> listData =
      const CsvToListConverter().convert(rawData);
      setState(() {
        _data = listData;
        _data2[0][1] = (_data[5][1] as num) + (_data[20][1] as num);
        _data2[1][1] = (_data[15][1] as num) / (_data[7][1] as num);
        _data2[2][1] = (_data[13][1] as num) * (_data[12][1] as num);
      });
    } catch (e) {
      print("Error loading CSV file: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 90),
                            width: 500,
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Align(alignment: Alignment.topLeft,),
                                Text(
                                  'table 1.',
                                  style: TextStyle(
                                      fontFamily: 'Raleway', fontSize: 40
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                ),
                const SizedBox(width: 5,),
                Expanded(
                  child: ListView.builder(
                    itemCount: _data.length,
                    itemBuilder: (_, index) {
                      return Container(
                        height: 60,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Card(
                            child: ListTile(
                              title: Row(
                                children: [
                                  const Spacer(),
                                  Text(_data[index][0].toString()),
                                  const Spacer(),
                                  Text(_data[index][1].toString()),
                                  const Spacer(),
                                ],
                              )
                            ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5,),
          const Divider(thickness: 2,),
          const SizedBox(height: 5,),
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 90),
                            width: 500,
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Align(alignment: Alignment.topLeft,),
                                Text(
                                  'table 2.',
                                  style: TextStyle(
                                      fontFamily: 'Raleway', fontSize: 40
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                ),
                const SizedBox(width: 5,),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Card(
                          child: ListTile(
                            title: Row(
                              children: const [
                                Spacer(),
                                Text('Category'),
                                Spacer(),
                                Text('Value'),
                                Spacer(),
                              ],
                            ),
                          ),
                        ),
                        for (var index = 0; index < _data2.length; index++)
                        Card(
                          child: ListTile(
                            title: Row(
                              children: [
                                const Spacer(),
                                Text('${_data2[index][0]}'),
                                const Spacer(),
                                Text('${_data2[index][1]}'),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}
