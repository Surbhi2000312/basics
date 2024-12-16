import 'package:flutter/material.dart';

class Tut1 extends StatefulWidget {
  const Tut1({super.key});

  @override
  State<Tut1> createState() => _Tut1State();
}

class _Tut1State extends State<Tut1> {

  List<Map<String,dynamic>> mData = [
    {
      "img": "https://img.freepik.com/free-photo/bohemian-man-with-his-arms-crossed_1368-3542.jpg?w=1380&t=st=1729491347~exp=1729491947~hmac=dab191250d4d822f5267fd9f11e603b77cf0ba44e21fce08eee86755d49efb0a",
      "name" : "sur",
      "msg" : "I'm using flutter",
      "time" : "10:11 am",
      "unreadCount" : "2",
    },
    {
      "img": "https://img.freepik.com/free-photo/cheerful-curly-business-girl-wearing-glasses_176420-206.jpg?w=1800&t=st=1729491313~exp=1729491913~hmac=fbcba8d4b04c7f098feb09412b6afce5cd9f54f1fd58085f8245357934add21d",
      "name" : "sid",
      "msg" : "componder",
      "time" : "11:11 am",
      "unreadCount" : "1",
    },
    {
      "img":"https://img.freepik.com/free-photo/indoor-shot-displeased-intense-european-man-with-beard-moustache-trendy-glasses-holding-hands-crossed-chest-looking-with-await-being-offended-wanting-hear-apology_176420-22484.jpg?w=1800&t=st=1729491420~exp=1729492020~hmac=53f494780a41cbb8b1edf844d94494786bdfee2175bf6dbf84cb229627ef6f32",
      "name" : "him",
      "msg" : "receptanist ",
      "time" : "12:11 am",
      "unreadCount" : "3",
    },
    {
      "img":"https://img.freepik.com/free-photo/happiness-wellbeing-confidence-concept-cheerful-attractive-african-american-woman-curly-haircut-cross-arms-chest-self-assured-powerful-pose-smiling-determined-wear-yellow-sweater_176420-35063.jpg?w=1800&t=st=1729491447~exp=1729492047~hmac=298bc1f2ea6b263f41bf314f6401b9e055b90f4a835cbb900da76c2166a310bf",
      "name" : "rik",
      "msg" : "using Android",
      "time" : "11:19 am",
      "unreadCount" : "2",
    },
    {
      "img":"https://img.freepik.com/free-photo/lifestyle-beauty-fashion-people-emotions-concept-young-asian-female-office-manager-ceo-with-pleased-expression-standing-white-background-smiling-with-arms-crossed-chest_1258-59329.jpg?w=1800&t=st=1729491550~exp=1729492150~hmac=7b315b682374a2a9aea0580f6ac7e7cb520de90848c3ae1a460391ac09700568",
      "name" : "krishna",
      "msg" : "doing b.tech",
      "time" : "08:13 am",
      "unreadCount" : "3",
    },
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: mData.length,
        itemBuilder: (_,index){
          return ListTile(
            leading: Container(
              width: 50,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                      // image:NetworkImage("https://img.freepik.com/free-photo/bohemian-man-with-his-arms-crossed_1368-3542.jpg?w=1380&t=st=1729491347~exp=1729491947~hmac=dab191250d4d822f5267fd9f11e603b77cf0ba44e21fce08eee86755d49efb0a")
                    image: NetworkImage('${mData[index]["img"]}')
                  ),
                ),


            ),


            title: Text('${mData[index]["name"]}'),
            subtitle: Text('${mData[index]["msg"]}'),

            trailing: Column(
              children: [
                Text('${mData[index]["time"]}'),
                CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.lightGreen,
                  child: Text(mData[index]["unreadCount"]),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

