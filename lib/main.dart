// ignore_for_file: use_key_in_widget_constructors, library_prefixes

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as httpClient;
import 'package:shared_pref_rev/Models/wallpaperFile.dart';
import 'package:shared_pref_rev/slas.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomePage> {
  late Future<WallpaperModelClass> wallpaperobj;
  var ser = TextEditingController();
  @override
  void initState() {
    super.initState();
    wallpaperobj = getWallpapers('cat');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Wallpapers',
            style: TextStyle(fontSize: MediaQuery.of(context).size.width * .07),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Developed By Amit Kushwah',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * .03),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: ser,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    hintText: ' Search',
                    hintStyle: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * .05),
                    suffixIcon: InkWell(
                      onTap: () {
                        wallpaperobj = getWallpapers(ser.text.toString());
                        setState(() {});
                      },
                      child: Icon(
                        Icons.search,
                        size: MediaQuery.of(context).size.width * .06,
                      ),
                    )),
              ),
            ),
            Expanded(
              child: FutureBuilder<WallpaperModelClass>(
                future: wallpaperobj,
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GridView.builder(
                        itemCount: snapshot.data!.photos!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 9 / 16,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                        ),
                        itemBuilder: (_, index) {
                          var photo = snapshot.data!.photos![index];
                          return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Detail(
                                                i: photo.src!.portrait!)));
                                  },
                                  child: Image.network(
                                    photo.src!.portrait!,
                                    fit: BoxFit.cover,
                                  )));
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ));
  }

  Future<WallpaperModelClass> getWallpapers(String mQuery) async {
    var mUrl = 'https://api.pexels.com/v1/search?query=$mQuery&per_page=28';
    var response = await httpClient.get(Uri.parse(mUrl), headers: {
      "Authorization":
          "GYJm0cNufW4Kyb11oaox1HyiCUdi9Gf3SDC4tFAsXBa65gVqS6RFvqp6"
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WallpaperModelClass.fromJson(data);
    } else {
      return WallpaperModelClass();
    }
  }
}
