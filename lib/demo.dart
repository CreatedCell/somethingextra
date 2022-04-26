import 'package:flutter/material.dart';
import 'package:extra_credit/add_contact.dart';
import 'package:extra_credit/contacts.dart';
import 'package:extra_credit/helper.dart';

class Demo extends StatefulWidget {
  Demo({Key? key}) : super(key: key);

  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
        backgroundColor: Color.fromARGB(255, 27, 25, 25),
      ),
      
      body: FutureBuilder<List<Contact>>(
        future: DBHelper.readContacts(), 
        builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
          
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Loading...'),
                ],
              ),
            );
          }
          
          return snapshot.data!.isEmpty
              ? Center(
                  child: Text('No Contact in List yet!'),
                )
              : ListView(
                  children: snapshot.data!.map((contacts) {
                    return Center(
                      child: ListTile(
                        title: Text(contacts.name),
                        subtitle: Text(contacts.contact),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            await DBHelper.deleteContacts(contacts.id!);
                            setState(() {
                              
                            });
                          },
                        ),
                        onTap: () async {
                          
                          final refresh = await Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (_) => AddContacts(
                                        contact: Contact(
                                          id: contacts.id,
                                          name: contacts.name,
                                          contact: contacts.contact,
                                        ),
                                      )));

                          if (refresh) {
                            setState(() {
                              
                            });
                          }
                        },
                      ),
                    );
                  }).toList(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final refresh = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AddContacts()));

          if (refresh) {
            setState(() {
              
            });
          }
        },
      ),
    );
  }
}