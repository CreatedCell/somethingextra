import 'package:flutter/material.dart';
import 'package:extra_credit/helper.dart';

import 'contacts.dart';

class AddContacts extends StatefulWidget {
  AddContacts({Key? key, this.contact}) : super(key: key);

  final Contact? contact;

  @override
  State<AddContacts> createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {
  
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();

  @override
  void initState() {
    
    if (widget.contact != null) {
      _nameController.text = widget.contact!.name;
      _contactController.text = widget.contact!.contact;
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Contacts'),
        backgroundColor: Color.fromARGB(255, 34, 29, 29),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(false),
          
        ),
      ),
      body: Center(
        
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildTextField(_nameController, 'Name'),
              SizedBox(
                height: 30,
              ),
              _buildTextField(_contactController, 'Contact'),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                
                onPressed: () async {
                  
                  if (widget.contact != null) {
                    await DBHelper.updateContacts(Contact(
                      id: widget.contact!.id, 
                      name: _nameController.text,
                      contact: _contactController.text,
                    ));

                    Navigator.of(context).pop(true);
                  } else {
                    await DBHelper.createContacts(Contact(
                      name: _nameController.text,
                      contact: _contactController.text,
                    ));

                    Navigator.of(context).pop(true);
                  }
                },
                child: Text('Add to Contact List'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  
  TextField _buildTextField(TextEditingController _controller, String hint) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: hint,
        hintText: hint,
        border: OutlineInputBorder(),
      ),
    );
  }
}