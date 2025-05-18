import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/item.dart';

class MarketplaceService {
  final FirebaseFirestore firebaseFirestore;

  MarketplaceService(this.firebaseFirestore);

  final _currentUser = FirebaseAuth.instance.currentUser;

  final _itemsCollection = FirebaseFirestore.instance.collection('items');

  Future<void> uploadItem(Item item) async {
    await _itemsCollection.add(item.toMap());
  }

  Future<List<Item>?> getUserItems() async {
    try {
      final data = await _itemsCollection
          .where('sellerId', isEqualTo: _currentUser!.uid)
          .get();

      final docs = data.docs;

      final items =
          await Future.wait(docs.map((doc) => Item.fromMap(doc.data())));

      return items;
    } catch (e) {
      print('Error fetching user items: $e');
      return [];
    }
  }
}
