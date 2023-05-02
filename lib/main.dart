import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main()=>runApp(MyApp());
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
String? stringResponse;
Map? mapResponse;
List? listResponse;


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  get child => null;

  Future apicall() async{
    http.Response response;
    response=await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
    if(response.statusCode==200){
      setState(() {
        stringResponse=response.body;
        mapResponse=json.decode(response.body);
        listResponse=mapResponse?['data'];
      });
    }
  }
  @override
  void initState() {
    apicall();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    var height=size.height;
    var width=size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Api Demo'),
      ),
      body:ListView.builder(itemBuilder: (context,index){
        return Container(
          height: height/5,
          width: width/2,
          child: Column(
            children:[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  margin:EdgeInsets.fromLTRB( 10,0,250,0),

                    child: Image.network(listResponse?[index]['avatar']),),
              ),

              Text(listResponse?[index]['first_name']),
              Text(listResponse?[index]['email']),
            ],
          ),
        );
    },
      itemCount: listResponse==null?0:listResponse?.length,
    ));
  }
}
