
import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import 'firestore_cats.dart';
import 'dart:developer';


var now = DateTime.now();

final now1 ='${now.year}-${now.month}-${now.day}'; //2021-6-22



var dateFormat = DateTime.now();
//上のときはでた　　Stringにするとくるくる

// catsテーブルへのアクセスをまとめたクラス
  class FirestoreHelper {
  // DbHelperをinstance化する
  static final FirestoreHelper instance = FirestoreHelper._createInstance();

  FirestoreHelper._createInstance();

  // catsテーブルのデータを全件取得する
  selectAllCats(String userId) async {
    final db = FirebaseFirestore.instance;
    final snapshot =
    db.collection("users").doc("cats").collection("cats4").withConverter(
      fromFirestore: Cats.fromFirestore,
      toFirestore: (Cats cats, _) => cats.toFirestore(),
    );
    final cats = await snapshot.get();
    return cats.docs;
  }

  // catsテーブルのデータ日付データとる　　１０２３
  selectAllCats_day(String userId, dateFormat) async {
    final db = FirebaseFirestore.instance;
    final snapshot =
    db.collection("users").doc("cats").collection("cats4")
        .where('kinkyu', isEqualTo: '00099999')
        .withConverter(
      fromFirestore: Cats.fromFirestore,
      toFirestore: (Cats cats, _) => cats.toFirestore(),
    );
    final cats = await snapshot.get();
    return cats.docs;
  }

// _idをキーにして1件のデータを読み込む  //詳細画面shousai
  catData(String userId, String name, String memo, String imageURL) async {     // catsのキーはnameに変更している
    final db = FirebaseFirestore.instance;
    final docRef = db
        .collection("users")
        .doc("cats")
        .collection("cats4")
        .doc(name)
        .withConverter(
      fromFirestore: Cats.fromFirestore,
      toFirestore: (Cats cats, _) => cats.toFirestore(),
    );
    final catdata = await docRef.get();
    final cat = catdata.data();
    return cat;
  }

// データをinsertする
  Future insert(Cats cats, String userId) async {  // updateも同じ処理で行うことができるので、共用している
    final db = FirebaseFirestore.instance;
    final docRef = db
        .collection("users")
        .doc("cats")
        .collection("cats4")
        .doc(cats.name)
        .withConverter(
      fromFirestore: Cats.fromFirestore,
      toFirestore: (Cats cats, options) => cats.toFirestore(),
    );
    await docRef.set(cats);
  }

// データを削除する
  Future delete(String userId, String name) {
    final db = FirebaseFirestore.instance;
    return db
        .collection("users")
        .doc("favorite")
        .collection("LIKE")
        .doc(name)
        .delete();
  }
  //1012void main(date) { debugPrint('debug: $date'); }
}

