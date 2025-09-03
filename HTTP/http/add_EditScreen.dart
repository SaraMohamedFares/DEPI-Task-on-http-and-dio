import 'package:depi/models/item_Model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddEditScreen extends StatefulWidget {
  final Item? item;

  AddEditScreen({this.item});

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _amountController;
  late TextEditingController _noteController;
  String _category = "Food";
  late int _date;

  String formatDate(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('dd-MM-yyyy').format(date);
  }

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(
      text: widget.item?.amount.toString() ?? "",
    );
    _noteController = TextEditingController(
      text: widget.item?.note ?? "",
    );
    _category = widget.item?.category ?? "Food";
    _date = widget.item?.date ?? DateTime.now().millisecondsSinceEpoch;
  }

  void _saveExpense() {
    if (_formKey.currentState!.validate()) {
      final item = Item(
          id: widget.item?.id,
        date: _date,
        amount: int.parse(_amountController.text),
        category: _category,
        note: _noteController.text,
      );


      Navigator.pop(context, item);
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.fromMillisecondsSinceEpoch(_date),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _date = picked.millisecondsSinceEpoch;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item == null ? "Add Expense" : "Edit Expense"),
        actions: [IconButton(icon: Icon(Icons.check), onPressed: _saveExpense)],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Amount"),
                validator: (value) =>
                value == null || value.isEmpty ? "Enter amount" : null,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: InputDecoration(labelText: "Category"),
                items: ["Food", "Transport", "Shopping", "Other"]
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (val) => setState(() => _category = val!),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _noteController,
                decoration: InputDecoration(labelText: "Note"),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text("Date: ${formatDate(_date)}"),
                  Spacer(),
                  TextButton(onPressed: _pickDate, child: Text("Pick Date")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
