import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sampleproject/SqlDatabase.dart';
import 'package:sampleproject/main.dart';

class addItemScreen extends StatefulWidget {
  @override
  State<addItemScreen> createState() => _addItemScreenState();
}

class _addItemScreenState extends State<addItemScreen> {
  SqlDatabase _sql = new SqlDatabase();

  Map<String, String> getData = {
    'userName': '',
    'password': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add items'),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      FontAwesomeIcons.user,
                      color: Colors.black,
                    ),
                    hintText: 'user name',
                    hintStyle: TextStyle(color: Colors.black),
                    label: Text('user name'),
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black, width: 1.2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.cyan, width: 1.2),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      getData['userName'] = val;
                    });
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.key,
                      color: Colors.black,
                    ),
                    hintText: 'password',
                    hintStyle: TextStyle(color: Colors.black),
                    label: Text('password'),
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black, width: 1.2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.cyan, width: 1.2),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      getData['password'] = val;
                    });
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      alignment: Alignment.center,
                      backgroundColor: MaterialStateProperty.all(
                        Colors.cyan,
                      )),
                  onPressed: () async {
                    //                 "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
                    // "userName" TEXT NOT NULL,
                    // "password" TEXT NOT NULL
                    var res = await _sql.insertData('''
                      INSERT INTO users ('userName', 'password') VALUES ('${getData['userName']}', '${getData['password']}')
                     ''');
                    print('====== items added ====== \n $res');
                    Get.off(() => homeApp());
                  },
                  child: Container(
                      margin: EdgeInsets.all(15), child: Text('Continue')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
