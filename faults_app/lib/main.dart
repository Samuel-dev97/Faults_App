import 'package:flutter/material.dart';
import 'package:faults_app/api/api.dart';
import 'package:provider/provider.dart';
import 'screens/addFault.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FaultProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final faultP = Provider.of<FaultProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('ATM  Faults'),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: faultP.faults.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    faultP.deleteFault(faultP.faults[index]);
                  }),
              title: Text(faultP.faults[index].title),
              subtitle: Text(
                (faultP.faults[index].description),
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => AddFaultScreen()));
          }),
    );
  }
}
