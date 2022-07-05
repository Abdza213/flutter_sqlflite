import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sampleproject/SqlDatabase.dart';
import 'package:sampleproject/main.dart';

class updateDataScreen extends StatefulWidget {
  var id;
  updateDataScreen({required this.id});
  @override
  State<updateDataScreen> createState() => _updateDataScreenState();
}

class _updateDataScreenState extends State<updateDataScreen> {
  SqlDatabase _sql = new SqlDatabase();

  Map<String, String> getData = {
    'userName': '',
    'password': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Data'),
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
                          UPDATE users SET 
                          userName = '${getData['userName']}' ,
                         'password' = '${getData['password']}'
                          WHERE id = ${widget.id}
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
