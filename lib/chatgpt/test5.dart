import 'package:flutter/material.dart';

class CheckboxListScreen extends StatefulWidget {
  @override
  _CheckboxListScreenState createState() => _CheckboxListScreenState();
}

class _CheckboxListScreenState extends State<CheckboxListScreen> {
  // Create a list of items and their selection state
  List<Map<String, dynamic>> _items = [
    {'name': 'Item 1', 'selected': false},
    {'name': 'Item 2', 'selected': false},
    {'name': 'Item 3', 'selected': false},
    {'name': 'Item 4', 'selected': false},
  ];

  // Select or unselect all items
  void selectAll(bool value) {
    setState(() {
      _items = _items.map((item) {
        return {...item, 'selected': value};
      }).toList();
    });
  }

  // Check if all items are selected
  bool get isAllSelected {
    return _items.every((item) => item['selected']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkbox List with Select All'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CheckboxListTile(
            title: const Text('Select All'),
            value: isAllSelected,
            onChanged: (value) {
              selectAll(value!);
            },
          ),
          const Divider(),
          ..._items.map((item) {
            return CheckboxListTile(
              title: Text(item['name']),
              value: item['selected'],
              onChanged: (value) {
                setState(() {
                  item['selected'] = value!;
                });
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}
