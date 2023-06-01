import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/bloc/expense_bloc.dart';



void popUp(
    BuildContext context,
    TextEditingController reasoncontroller,
    TextEditingController amountcontroller,
    TextEditingController timecontroller) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Text('Add New Expense',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          ),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: reasoncontroller,
                    decoration: InputDecoration(
                        hintText: 'Reason',
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color.fromARGB(255, 216, 211, 211)
                        //  icon: Icon(Icons.account_box),
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100,
                          child: TextField(
                            controller: amountcontroller,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Amount',
                                filled: true,
                                fillColor: Color.fromARGB(255, 216, 211, 211)),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: TextField(
                            controller: timecontroller,
                            decoration: InputDecoration(
                                hintText: 'Time',
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Color.fromARGB(255, 216, 211, 211)),
                            onTap: () async {
                              TimeOfDay? selectedtime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                              if (selectedtime != null) {
                                timecontroller.text =
                                    selectedtime.format(context);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'cancel',
              ),
            ),
            SizedBox(
              width: 130,
            ),
            ElevatedButton(
                child: Text("Add"),
                onPressed: () {
                  BlocProvider.of<ExpenseBloc>(context).add(
                      Add(reasoncontroller, amountcontroller, timecontroller));
                  Navigator.pop(context);
                })
          ],
        );
      });

  Container(
    width: 50,
    height: 50,
    color: Colors.black,
  );
}
