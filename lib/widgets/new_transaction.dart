import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submittedData() {
    final enterTitle = _titleController.text;
    final enterAmount = double.parse(_amountController.text);
    if (_amountController.text.isEmpty) {
      return;
    }

    // ignore: unnecessary_null_comparison
    if (enterTitle.isEmpty || enterAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(enterTitle, enterAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now())
        .then((pickedDate) {
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
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              //  onChanged: (val) {
              //  inputTitle = val;
              // },
              controller: _titleController,
              onSubmitted: (_) => _submittedData(),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              controller: _amountController,
              //onChanged: (val) {
              // inputAmount = val;
              // },
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submittedData(),
            ),

            Container(
              height: 70,
              child: Row(
                children: [
                  // ignore: unnecessary_null_comparison
                  Text(
                      // ignore: unnecessary_null_comparison
                      _selectedDate == null
                          ? 'No Date Choosen!'
                          : 'Date: ${DateFormat.yMMMMEEEEd().format(_selectedDate!)}'),
                  // ignore: deprecated_member_use
                  FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        _presentDatePicker();
                      })
                ],
              ),
            ),
            // ignore: deprecated_member_use
            FlatButton(
                color: Colors.indigo,
                onPressed: () {
                  _submittedData();
                  //print(inputAmount);
                  //print(inputTitle);
                  // print(amountController.text);
                },
                child: Text(
                  'Add Transation',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
