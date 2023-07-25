import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fiservonboardingexp/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Firestore Example'),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData) {
              return Center(child: Text('No data available'));
            }

            // Firestore 中的数据已准备好
            QuerySnapshot querySnapshot =
                snapshot.data as QuerySnapshot<Object?>;
            List<DocumentSnapshot> documents = querySnapshot.docs;

            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                // 获取单个文档数据
                DocumentSnapshot documentSnapshot = documents[index];
                Object? data = documentSnapshot.data();

                // 显示文档数据
                return ListTile(
                    // title: Text(data['name']),
                    // subtitle: Text(data['email']),
                    );
              },
            );
          },
        ),
      ),
    );
  }
}
