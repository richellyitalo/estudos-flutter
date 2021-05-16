import 'adaptives/text_field_adaptative.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'adaptives/button_adaptative.dart';

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
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          // Solução para androids antigos
          // padding: EdgeInsets.only(
          //   top: 10,
          //   right: 10,
          //   left: 10,
          //   bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          // ),
          child: Column(
            children: <Widget>[
              TextFieldAdaptative(
                inputController: _titleController,
                placeholder: 'Título',
                onSubmit: (_) => _submit(),
              ),
              TextFieldAdaptative(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputController: _valueController,
                placeholder: 'Valor',
                onSubmit: (_) => _submit(),
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
                  ButtonAdaptative(
                    Text('Adicionar Transação'),
                    _submit,
                  )
                ],
              )
            ],
          ),
        ),
        elevation: 5,
      ),
    );
  }
}
