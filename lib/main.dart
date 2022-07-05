import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sampleproject/SqlDatabase.dart';
import 'package:sampleproject/addItemScreen.dart';
import 'package:sampleproject/updateData.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: homeApp(),
    ),
  );
}

class homeApp extends StatelessWidget {
  SqlDatabase _sql = new SqlDatabase();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.cyan,
        onPressed: () {
          Get.to(() => addItemScreen());
        },
        label: Text('add item'),
        icon: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('SQL Lite'),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder(
          future: _sql.readData('''SELECT * FROM 'users' '''),
          builder: ((context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            print('${snapshot.data!.length}');
            if (snapshot.data!.length > 0) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: ((context, index) {
                  return Center(
                    child: Column(
                      children: [
                        Card(
                          margin: EdgeInsets.all(10),
                          color: Colors.cyan[300],
                          child: ListTile(
                            title: Text(
                              '${(snapshot.data![index] as dynamic)['userName']}',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${(snapshot.data![index] as dynamic)['password']}',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white70,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    Get.to(
                                      () => updateDataScreen(
                                        id: snapshot.data[index]['id'],
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                  onPressed: () async {
                                    var res = await _sql.delateData('''
                                      DELETE FROM 'users' WHERE id = ${snapshot.data[index]['id']}
                                  ''');
                                    print('Deleted');
                                    Get.to(() => homeApp());
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
              );
            } else {
              return Center(
                child: Text(
                  'No Items',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}
