import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_movies/customs/custom_textfield.dart';
import 'package:my_movies/my_intoduction_screen.dart';
import 'package:my_movies/my_provider.dart';
import 'package:provider/provider.dart';
import 'data.dart';
import 'package:introduction_screen/introduction_screen.dart';

class HomeScreen extends StatelessWidget {
  TextEditingController addedNameController = TextEditingController();
  TextEditingController addedDirectorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MyProvider();
    return Scaffold(
            resizeToAvoidBottomInset: false,
            //  backgroundColor: Colors.black,
            floatingActionButton:
                Consumer<MyProvider>(builder: (context, provider, child) {
              return CircleAvatar(
                radius: 35,
                backgroundColor: Colors.black,
                child: IconButton(
                  icon: Icon(
                    Icons.add,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                        backgroundColor: Color.fromARGB(255, 161, 161, 161),
                        isScrollControlled: true,
                        context: context,
                        builder: (_) {
                          return Padding(
                            padding: EdgeInsets.only(
                                top: 20,
                                right: 20,
                                left: 20,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: SizedBox(
                              height: 300,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomTextField(
                                    controller: addedNameController,
                                    icon: Icons.movie,
                                    labelText: 'Movie Name',
                                  ),
                                  CustomTextField(
                                    controller: addedDirectorController,
                                    icon: Icons.movie_edit,
                                    labelText: 'Director name',
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      provider.getPicture();
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Add movie poster',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        Icon(
                                          Icons.image,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (provider.imageFile == null ||
                                          addedDirectorController
                                              .text.isEmpty ||
                                          addedNameController.text.isEmpty) {
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text('Alert'),
                                            content: const Text(
                                                'Please fill all data'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        provider.addData(
                                          Data(
                                              addedNameController.text,
                                              addedDirectorController.text,
                                              provider.imageFile!.path,
                                              '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}'),
                                        );
                                        addedDirectorController.clear();
                                        addedNameController.clear();
                                        provider.imageFile = null;
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Text('Add Movie'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                ),
              );
            }),
            body: Consumer<MyProvider>(builder: (context, provider, child) {
              return Center(
                child: Stack(
                  children: [
                    Center(
                        child: Text(
                      provider.centerText,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    )),
                    SizedBox(
                      child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ...provider.data.map((e) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 8),
                                  child: Dismissible(
                                    key: ValueKey(e),
                                    onDismissed: (direction) {
                                      provider.removeData(e);
                                    },
                                    background: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 8),
                                      child: Card(
                                        color: Colors.red,
                                        elevation: 10,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Icon(Icons.delete),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Icon(Icons.delete),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    child: Card(
                                      elevation: 10,
                                      color: Colors.red,
                                      child: Container(
                                        height: 120,
                                        child: Center(
                                          child: ListTile(
                                            leading: Image.file(
                                              File(e.image),
                                            ),
                                            title: Text(e.name),
                                            subtitle: Text(e.director),
                                            trailing: Text(e.date),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              })
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),
          );
  }
}
