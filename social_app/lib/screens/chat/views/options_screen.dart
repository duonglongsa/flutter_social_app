import 'package:flutter/material.dart';
import 'package:social_app/view/chat/views/chat_screen.dart';

class OptionsScreen extends StatefulWidget {
  @override
  _OptionsScreenState createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xff202466),
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios)),
            SizedBox(width: 10,),
            Text("Options", style: TextStyle(fontSize: 20)),
          ],
        ),
        backgroundColor: const Color(0xff312B83),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),

      body: Column(
        children: [
          SizedBox(width: 450, height: 30,),
          CircleAvatar(backgroundImage: AssetImage("lib/assets/avatar.jpg"), radius: 80,),
          SizedBox(width: 450, height: 20,),
          Text("Girl", style: TextStyle(fontSize: 30, color: Colors.white)),
          SizedBox(width: 450, height: 60,),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff312B83),
                padding: EdgeInsets.fromLTRB(20, 20, 70, 20),
                elevation: 0,
              ),
              onPressed: (){},
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row( children:[
                      Icon(Icons.person_outline),
                      SizedBox(width: 10),
                      Text('User profile'),
                    ]
                )
              ),
          ),
          SizedBox(width: 0, height: 1,),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff312B83),
                padding: EdgeInsets.fromLTRB(20, 20, 70, 20),
                elevation: 0,
              ),
              onPressed: (){},
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row( children:[
                    Icon(Icons.block),
                    SizedBox(width: 10),
                    Text('Block user'),
                  ]
                  )
              ),
          ),
          SizedBox(width: 0, height: 1,),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff312B83),
                padding: EdgeInsets.fromLTRB(20, 20, 70, 20),
                elevation: 0,
              ),
              onPressed: (){},
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row( children:[
                    Icon(Icons.delete_sweep_outlined),
                    SizedBox(width: 10),
                    Text('Delete conversation'),
                  ]
                  )
              ),
          ),
        ],
      )
    );
  }

}
