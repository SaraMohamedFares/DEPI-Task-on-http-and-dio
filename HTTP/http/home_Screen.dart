
import 'package:depi/http/add_EditScreen.dart';
import 'package:depi/models/item_Model.dart';
import 'package:depi/services/services_Helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Item> items=[];
  @override
  void initState(){
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems() async {
    final newItems = await ServicesHelper.getItems();
    setState(() {
      items = newItems;
    });
  }

  Future<void> updateItem(Item item) async {
    await ServicesHelper.updateItem(item, context);
    fetchItems();
    setState(() {});
  }

  Future<void> addItem(Item item) async {
    await ServicesHelper.addItem(item, context);
    fetchItems();
    setState(() {});
  }

  Future<void> deleteItem(Item item) async {
    await ServicesHelper.deleteItem(item.id! , context);
    fetchItems();
    setState(() {});
  }

  Future<void> clearAll() async {
    // final newItems = await ServicesHelper.getItems();
    fetchItems();
    setState(() {
      items = [];
    });
  }
  void addOrEditItem({Item? item, int? index}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddEditScreen(item: item)),
    );
    print(result.runtimeType);
    if (result != null) {
      if (index == null) {
        await addItem(result!);
      } else {
        await updateItem(result!);
      }
      fetchItems();
      setState(() {});

    }
  }

  String formatDate(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('dd-MM-yyyy').format(date);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: clearAll,
            tooltip: "Clear All",
          ),
        ],
      ),
      body: items.isEmpty
          ? Center(child: Text("No expenses yet."))
          : ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    "\$${item.amount}",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              title: Text(item.category),
              subtitle: Text(
                "${item.note} - ${formatDate(item.date)}",
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () =>
                        addOrEditItem(item: item,index: index),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteItem(item),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => addOrEditItem(),
      ),
    );
  }
}
