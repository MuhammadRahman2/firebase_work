import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore/screen/auth_screen.dart';
// import 'package:flutter_firestore/widget/auth_form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override     
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(20)
          // )
        )
      ),
      home: AuthScreen(),
    );
  }
}


class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(title: const TextField()),
          body: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('tests').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final doucuments = snapshot.data!.docs;
                return ListView.builder(
                    itemCount: doucuments.length,
                    itemBuilder: (ctx, index) {
                      return Text(doucuments[index]['name']);
                    });
              }),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              FirebaseFirestore.instance.collection('tests').add({
                'name': "we add text to firestore "
              });
            },
            child: const Icon(Icons.add),
          ),
    );
  }
}
