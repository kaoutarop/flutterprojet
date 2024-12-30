import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page ',
          style: TextStyle(color: Colors.white,fontSize: 60),),backgroundColor: Colors.blueGrey,

      ),
      drawer: Drawer(child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(decoration: BoxDecoration(color: Colors.blue),child: Column(
            children: [
              CircleAvatar(
                  backgroundImage: AssetImage('images/avatar.jpeg'),
                  radius: 30),
              Text('Elhachemy kaoutar',style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,fontWeight: FontWeight.bold
              ),),
              Text('k.elhachemy@gmail.com')
            ],
          )),
          ListTile(leading: Icon(Icons.home,color: Colors.purple,),title: Text('Covid tracker'),onTap:(){Navigator.pop(context);}
          ),
          ListTile(leading: Icon(Icons.settings,color: Colors.pink,),title: Text('Emsi Chatbot'),onTap:(){Navigator.pop(context);}
          ),
          ListTile(leading: Icon(Icons.account_circle,color: Colors.deepOrange,),title: Text('Profile'),onTap:(){Navigator.pop(context);}
          ),
          ListTile(leading: Icon(Icons.settings,color: Colors.green,),title: Text('settings'),onTap:(){Navigator.pop(context);}
          ),

          ListTile(leading: Icon(Icons.logout),title: Text('log out'),onTap:(){Navigator.pop(context);}
          ),
        ],
      ),),
      body: Center(
        child: Text('Welcome to the Home Page',
          style: TextStyle(color: Colors.blueGrey,fontSize: 60),),
      ),
    );
  }
}
