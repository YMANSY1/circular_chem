import 'package:circular_chem_app/core/models/category_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/models/company.dart';
import '../models/item.dart';

class MarketplaceService {
  final FirebaseFirestore firebaseFirestore;

  MarketplaceService(this.firebaseFirestore);

  final _currentUser = FirebaseAuth.instance.currentUser;

  final _itemsCollection = FirebaseFirestore.instance.collection('items');

  final _usersCollection = FirebaseFirestore.instance.collection('users');

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

  Future<List<Item>?> getApprovedItems({CategoryType? category}) async {
    try {
      var query = await _itemsCollection
          .where('sellerId', isNotEqualTo: _currentUser!.uid)
          .where('isApproved', isEqualTo: true);

      if (category != null) {
        query = query.where('category', isEqualTo: category.name);
      }

      final data = await query.get();
      final docs = data.docs;

      final items =
          await Future.wait(docs.map((doc) => Item.fromMap(doc.data())));

      print(items);
      return items;
    } catch (e) {
      print('Error fetching user items: $e');
      return [];
    }
  }

  Future<List<Company>?> getSellers(bool isFeatured) async {
    try {
      var query = FirebaseFirestore.instance
          .collection('users')
          .orderBy('echo_points', descending: true);

      if (isFeatured) {
        query = query
            .where(FieldPath.documentId, isNotEqualTo: _currentUser!.uid)
            .limit(8);
      }

      final data = await query.get();
      final docs = data.docs;

      final sellers = await Future.wait(
        docs.map((doc) async => Company.fromMap(doc.data(), id: doc.id)),
      );

      return sellers;
    } catch (e) {
      print('Error fetching user items: $e');
      return <Company>[];
    }
  }
}
