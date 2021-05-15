import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState(this.onSubmit);
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final void Function(String, double, DateTime) onSubmit;
  DateTime _selectedDate = DateTime.now();

  _TransactionFormState(this.onSubmit);

  _submit() {
    final String title = _titleController.text;
    final double value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    _titleController.clear();
    _valueController.clear();

    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() async {
    DateTime dt = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (dt != null) {
      setState(() {
        _selectedDate = dt;
      });
    }
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
              children: <Widget>[
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'Nenhuma data selecionada'
                        : 'Data selecionada: ${DateFormat('d/MM/y').format(_selectedDate)}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                TextButton(
                  child: Text(
                    'Selecionar data',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onPressed: _showDatePicker,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
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
