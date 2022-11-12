import 'package:flutter/material.dart';

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
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
    );

    // to close that top most screen that is displayed, i.e. the modal in this example.
    Navigator.of(context).pop();
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
                    titleController.clear();
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.black,
                  ),
                  iconSize: 18,
                ),
              ),
              controller: titleController,
              // you can add (_) => submitData() to add data on the press of the check in the keyboard
              // notice that it has a parenthesis ()
              // NOTE: you commented it out because you don't want that behaviour
              // onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
                suffixIcon: IconButton(
                  onPressed: () {
                    amountController.clear();
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.black,
                  ),
                  iconSize: 18,
                ),
              ),
              controller: amountController,
              keyboardType: TextInputType.number,
              // you can add (_) => submitData() to add data on the press of the check in the keyboard
              // notice that it has a parenthesis ()
              // NOTE: you commented it out because you don't want that behaviour
              // onSubmitted: (_) => submitData(),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.deepPurple),
              // this submitData has no parenthesis, study why
              onPressed: submitData,
              child: const Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
