import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTx;

  NewTransaction(this.addNewTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitTx() {
    try {
      if (_amountController.text.isEmpty) {
        return;
      }

      final enteredTitle = _titleController.text;
      final enteredAmount = double.parse(_amountController.text);
      if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
        return;
      }
      widget.addNewTx(
        enteredTitle,
        enteredAmount,
        _selectedDate,
      );
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5.0,
        child: Container(
          padding: EdgeInsets.only(
            top: 10.0,
            left: 10.0,
            right: 10.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title...',
                ),
                textAlign: TextAlign.center,
                controller: _titleController,
                onSubmitted: (_) => _submitTx(),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount...',
                ),
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitTx(),
              ),
              Container(
                height: 70.0,
                child: Row(
                  children: <Widget>[
                    Text(
                      _selectedDate == null
                          ? 'No Date chosen!'
                          : 'Picked Date: ${DateFormat.yMMMd().format(_selectedDate)}',
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    IconButton(
                      color: Theme.of(context).primaryColor,
                      icon: Icon(Icons.date_range),
                      onPressed: _presentDatePicker,
                    )
                  ],
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).textTheme.button.color,
                child: Text(
                  'Add Transaction',
                ),
                onPressed: _submitTx,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
