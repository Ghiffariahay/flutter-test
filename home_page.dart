import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference _items =
      FirebaseFirestore.instance.collection('items');
  final TextEditingController _controller = TextEditingController();

  void _addItem() async {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      await _items.add({'name': text});
      _controller.clear();
      Navigator.pop(context);
    }
  }

  void _editItem(DocumentSnapshot doc) {
    _controller.text = doc['name'];
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Item"),
        content: TextField(controller: _controller),
        actions: [
          TextButton(
            onPressed: () async {
              await _items.doc(doc.id).update({'name': _controller.text});
              _controller.clear();
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          )
        ],
      ),
    );
  }

  void _deleteItem(String id) async {
    await _items.doc(id).delete();
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Tambah Item"),
        content: TextField(controller: _controller),
        actions: [
          TextButton(onPressed: _addItem, child: const Text("Tambah")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CRUD Firestore Web")),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _items.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (_, i) {
              final doc = docs[i];
              return ListTile(
                title: Text(doc['name']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () => _editItem(doc),
                        icon: const Icon(Icons.edit)),
                    IconButton(
                        onPressed: () => _deleteItem(doc.id),
                        icon: const Icon(Icons.delete)),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
