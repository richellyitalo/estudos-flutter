import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState(this.onSubmit);
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final void Function(String, double) onSubmit;

  _TransactionFormState(this.onSubmit);

  _submit() {
    final String title = _titleController.text;
    final double value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    _titleController.clear();
    _valueController.clear();

    widget.onSubmit(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Título',
              ),
              onSubmitted: (_) => _submit(),
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: _valueController,
              decoration: InputDecoration(
                labelText: 'Valor',
              ),
              onSubmitted: (_) => _submit(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _submit,
                  child: Text(
                    'Adicionar Transação',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      elevation: 5,
    );
  }
}
