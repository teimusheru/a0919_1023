import 'package:cloud_firestore/cloud_firestore.dart';

// catsテーブルの定義
class Cats {
  String id;
  String name;
  String name1;
  String gender;
  String birthday;
  String memo;
  String imageURL;
  String workday;
  String syokusyu;
  String koutuhi;
  String motimono;
  String sonota;
  String naiyou;
  String tyui;
  String ido;
  String workmap;

  String workmap_gm;
  String keido;
  String kinkyu;


  DateTime? createdAt;

  Cats({
    required this.id,
    required this.name,
    required this.name1,
    required this.gender,
    required this.birthday,
    required this.memo,
    required this.imageURL,
    required this.syokusyu,
    required this.koutuhi,
    required this.motimono,
    required this.sonota,
    required this.naiyou,
    required this.tyui,
    required this.workmap,
    required this.workmap_gm,
    required this.ido,
    required this.keido,
    required this.kinkyu,



    required this.workday,
    required this.createdAt,


  });

  factory Cats.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Cats(
        id: data?['id'],
        name: data?['name'],
        name1: data?['name1'],
        gender: data?['gender'],
        birthday: data?['birthday'],
        memo: data?['memo'],
        imageURL: data?['imageURL'],
        workday: data?['workday'],



        syokusyu: data?['syokusyu'],
        koutuhi: data?['koutuhi'],
        motimono: data?['motimono'],
        sonota: data?['sonota'],
        naiyou: data?['naiyou'],
        tyui: data?['tyui'],

    workmap: data?['workmap'],
        workmap_gm: data?['workmap_gm'],
        ido: data?['ido'],
        keido: data?['keido'],
        kinkyu: data?['kinkyu'],





        createdAt: data?['createdAt'].toDate());
  }



  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "name": name,
      "name1": name1,

      "gender": gender,
      "birthday": birthday,
      "memo": memo,
      "imageURL": imageURL,
      "workday": workday,

      "syokusyu": syokusyu,
      "koutuhi": koutuhi,
      "motimono": motimono,
      "sonota": sonota,
      "naiyou": naiyou,


      "tyui": tyui,
      "workmap": workmap,
      "workmap_gm": workmap_gm,
      "ido": ido,
      "keido": keido,
      "kinkyu": kinkyu,




      "createdAt": createdAt,
    };
  }
}
