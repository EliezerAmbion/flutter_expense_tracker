import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction({
    super.key,
    required this.addTx,
  });

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    // for error handling
    if (_amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    // to close that top most screen that is displayed, i.e. the modal in this example.
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    // flutter default to show date picker
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
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
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                suffixIcon: IconButton(
                  onPressed: () {
                    _titleController.clear();
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.black,
                  ),
                  iconSize: 18,
                ),
              ),
              controller: _titleController,
              // you can add (_) => _submitData() to add data on the press of the check in the keyboard
              // notice that it has a parenthesis ()
              // NOTE: you commented it (below code) because you don't want that behaviour
              // onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
                suffixIcon: IconButton(
                  onPressed: () {
                    _amountController.clear();
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.black,
                  ),
                  iconSize: 18,
                ),
              ),
              controller: _amountController,
              keyboardType: TextInputType.number,
              // you can add (_) => _submitData() to add data on the press of the check in the keyboard
              // notice that it has a parenthesis ()
              // NOTE: you commented it out because you don't want that behaviour
              // onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}',
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: _presentDatePicker,
                    child: const Text(
                      'Choose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).textTheme.button!.color,
              ),
              // this _submitData has no parenthesis, study why
              onPressed: _submitData,
              child: const Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
