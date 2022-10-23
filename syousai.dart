import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'card/firestore_cats.dart';
import 'card/firestore_helper.dart';
import 'card_favorite/firestore_helper.dart';
import 'favourite_toggle_icon_widget.dart';
import 'item/app_text.dart';



class syousai extends StatefulWidget {
// catsテーブルの中の1件のデータに対する操作を行うクラス

  final String userId;
  final String name;
  final String memo;
  final String imageURL;
  final String name1;
  final String gender;
  final String birthday;
  final String syokusyu;
  final String koutuhi;
  final String motimono;
  final String sonota;
  final String naiyou;
  final String tyui;
  final String workmap;
  final String workmap_gm;

  final String ido;
  final String keido;
  final String kinkyu;
  final String workday;
  //final String createdAt;



  const syousai({Key? key,


    required this.userId,
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
    //required this.createdAt,
  })
      : super(key: key);

  @override
  _CatDetailState createState() => _CatDetailState();
  }

  class _CatDetailState extends State<syousai> {
    late Cats cats;
    bool isLoading = false;
    static const int textExpandedFlex = 1; // 見出しのexpaded flexの比率
    static const int dataExpandedFlex = 4; // 項目のexpanede flexの比率


// Stateのサブクラスを作成し、initStateをオーバーライドすると、wedgit作成時に処理を動かすことができる。
// ここでは、渡されたidをキーとしてcatsテーブルからデータを取得する
    @override
    void initState() {
      super.initState();
      catData();
    }
// initStateで動かす処理
// catsテーブルから指定されたidのデータを1件取得する
    //1018　firestore_helper   引数
    Future catData() async {
      setState(() => isLoading = true);
      cats = await FirestoreHelper.instance.catData(
          widget.userId, widget.name, widget.memo, widget.imageURL);
      setState(() => isLoading = false);
    }

    int amount = 1;

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(



/*          appBar: AppBar(
            title: const Text('猫編集'),
            actions: [
              buildSaveButton(), // 保存ボタンを表示する
            ],
          ),*/
/*          // 左側のアイコン
          actions: [
            IconButton(
              onPressed: ()
              { Navigator.of(context).pop();},
              icon: Icon(Icons.add),
            ),
          ],*/
          // タイトルテキスト　　下戻るボタンつき
          title: const Text('お仕事詳細'),
          // 右側のアイコン一覧
          actions: <Widget>[
            AppText(
              text: "お気に入り",
              fontSize: 14,
                color: Colors.yellow,

              fontWeight: FontWeight.bold,
            ),
            InkWell(
              onTap: () {
                setState(()  {
                  favorite = !favorite;
                  if (favorite = favorite){
                    //favorite = !favorite;
                    addLike(false,
                        widget.name,
                        widget.name,
                      widget.memo,
                      widget.imageURL,
                      widget.name1,
                      widget.gender,
                      widget.birthday,
                      widget.syokusyu,
                      widget.koutuhi,
                      widget.motimono,
                      widget.sonota,
                      widget.naiyou,
                      widget.tyui,
                      widget. workmap,
                      widget.workmap_gm,

                      widget.ido,
                      widget.keido,
                      widget. kinkyu,
                      widget.workday,


                    );

/*
                      Firestore_favoriteHelper.instance
                          .insert(cat,widget.userId, widget.name);//help*/
                  }else{
                    // favorite = favorite;
                    //addLike(true,widget.name);
                    Firestore_favoriteHelper.instance
                        .delete(widget.userId, widget.name);//helper の消去みにいく

                  }
                }


                );
              },
              child: Icon(
                favorite ? Icons.favorite : Icons.favorite_border,
                color: favorite ? Colors.red : Colors.blueGrey,
                size: 35,
              ),
            ),
          ],
        ),

        body: SafeArea(
          child: SingleChildScrollView( // SingleChildScrollViewで子ウィジェットをラップ
            child: Column(
              children: [
                getImageHeaderWidget(),
           /* Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.5),),*/
                Divider(thickness: 1),
                /*getProductDataRowWidget("Nutritions",
                    customWidget: nutritionWidget()),*/    //wiggetあかん
               // Spacer(),//これあかん１０１６
                AppText(
                  text: "募集職種",
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  //fontWeight: FontWeight.bold,
                ),



                Divider(thickness: 1),
                SizedBox(
                  height: 20,
                ),
                AppText(
                  text: "${cats.syokusyu}",
                  fontSize: 30,
                  //fontWeight: FontWeight.bold,
                  //fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 30,
                ),
                Divider(thickness: 1),

                SizedBox(
                  height: 15,
                ),

                AppText(
                  text: "通勤",
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  //fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 1,
                ),
                AppText(
                  text: "${cats.koutuhi}",
                  fontSize: 18,
                  //fontWeight: FontWeight.bold,
                  //fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 4,
                ),
                Divider(thickness: 1),
                SizedBox(
                  height: 15,
                ),




                Divider(thickness: 1),

                SizedBox(
                  height: 15,
                ),

                AppText(
                  text: "持ち物",
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  //fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 15,
                ),




                Divider(thickness: 1),


                AppText(
                  text: "${cats.motimono}",
                  fontSize: 30,
                  //fontWeight: FontWeight.bold,
                  //fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(thickness: 1),
                SizedBox(
                  height: 10,
                ),
                AppText(
                  text: "仕事内容",
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  //fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 20,
                ),
                AppText(
                  text: "${cats.naiyou}",
                  fontSize: 18,
                  //fontWeight: FontWeight.bold,
                  //fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(thickness: 1),
                SizedBox(
                  height: 15,
                ),



                Divider(thickness: 1),

                AppText(
                  text: "施設名",
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  //fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 15,
                ),
                AppText(
                  text: "${cats.workmap}",
                  fontSize: 20,
                  //fontWeight: FontWeight.bold,
                  //fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(thickness: 1),
                getImageHeaderWidget(),

                //1018
                /*ElevatedButton(
                  onPressed: () async {
                    final url = Uri.parse(
                      'https://www.google.com/maps/search/?api=1&parameters',
                    );
                    if (await canLaunchUrl(url)) {
                      launchUrl(url);
                    } else {
                      // ignore: avoid_print
                      print("Can't launch $url");
                    }
                  },
                  child: const Text('Web Link'),
                ),

                ElevatedButton(
                  onPressed: () async {
                    final url = Uri.parse(
                      'https://goo.gl/maps/eWpHPHfRGCE7Zbmy6',
                    );
                    if (await canLaunchUrl(url)) {
                      launchUrl(url);
                    } else {
                      // ignore: avoid_print
                      print("Can't launch $url");
                    }
                  },
                  child: const Text('Map'),
                ),*/

                ElevatedButton(
                  onPressed: () async {
                    final url = Uri.parse(

                        "${cats.workmap_gm}"
                    );
                    if (await canLaunchUrl(url)) {
                      launchUrl(url);
                    } else {
                      // ignore: avoid_print
                      print("Can't launch $url");
                    }
                  },
                  child: const Text('地図　MAP（クリックしてください）'),
                ),
                SizedBox(
                  height: 20,
                ),

                Divider(thickness: 1),
                AppText(
                  text: "その他",
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  //fontWeight: FontWeight.bold,
                ),

                SizedBox(
                  height: 8,
                ),
                AppText(
                  text: "${cats.sonota}",
                  fontSize: 18,
                  //fontWeight: FontWeight.bold,
                  //fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 8,
                ),

                Divider(thickness: 1),
                Divider(thickness: 1),
                SizedBox(
                  height: 15,
                ),



              InkWell(
                onTap: () {
                  setState(()  {
                    favorite = !favorite;
                    if (favorite = favorite){
                      //favorite = !favorite;
                      addLike(false,
                        widget.name,
                          widget.name,

                        widget.memo,
                        widget.imageURL,
                        widget.name1,
                        widget.gender,
                        widget.birthday,
                        widget.syokusyu,
                        widget.koutuhi,
                        widget.motimono,
                        widget.sonota,
                        widget.naiyou,
                        widget.tyui,
                        widget. workmap,
                        widget.workmap_gm,

                        widget.ido,
                        widget.keido,
                        widget. kinkyu,
                        widget.workday,




                      );

/*
                      Firestore_favoriteHelper.instance
                          .insert(cat,widget.userId, widget.name);//help*/
                    }else{
                     // favorite = favorite;
                      //addLike(true,widget.name);
                      Firestore_favoriteHelper.instance
               .delete(widget.userId, widget.name);//helper の消去みにいく

                    }
                  }


                  );
                },
                child: Icon(
                  favorite ? Icons.favorite : Icons.favorite_border,
                  color: favorite ? Colors.red : Colors.blueGrey,
                  size: 30,
                ),
              ),
                Divider(thickness: 1),

              ],
            ),
          ),
        ),
      );
    }
    bool favorite = false;
/*  late Cats cats;

  @override
  void initState() {
    super.initState();
    catData();
  }

// initStateで動かす処理
// catsテーブルから指定されたidのデータを1件取得する
  //1018　firestore_helper   引数
  Future catData() async {

    cats = await FirestoreHelper.instance.catData(
        widget.userId, widget.name, widget.memo, widget.imageURL);

  }*/

    /*@override
    Widget build(BuildContext context) {
      return InkWell(
        onTap: () {
          setState(() async {
            favorite = !favorite;
            if (favorite = favorite){
              //avorite = !favorite;
              addLike(false);
            }else{
              // favorite = favorite;
              addLike(true);
              *//*      await FirestoreHelper.instance
               .delete(widget.userId, widget.name);*//*

            }
          }


          );
        },
        child: Icon(
          favorite ? Icons.favorite : Icons.favorite_border,
          color: favorite ? Colors.red : Colors.blueGrey,
          size: 30,
        ),
      );
    }
*/

    Future<void> addLike(bool liked,userId,name,

        memo,
        imageURL,
        name1,
        gender,
        birthday,
        syokusyu,
        koutuhi,
        motimono,
        sonota,
        naiyou,
        tyui,
        workmap,
        workmap_gm,

        ido,
        keido,
        kinkyu,
        workday,


        ) async {
      liked =!liked;
      if(liked){
/*      DocumentReference ref = _service.db
          .collection('sections')
          .doc('dc');*/
        // final collectionRef = FirebaseFirestore.instance
        //  .collection('sections')

        // CollectionReference
        /*  final querySnapshot = await collectionRef.get(); // QuerySnapshot
      final queryDocSnapshot = querySnapshot.docs; // List<QueryDocumentSnapshot>
      for (final snapshot in queryDocSnapshot) {
        final data = snapshot.data(); // `data()`で中身を取り出す
      }*/

/*        ---
        FirebaseFirestore.instance.collection('users')
            .doc('favorite')
            .collection('LIKE')

            .add({
          *//*        'logoURL': auth.currentUser.photoURL,
          'nameAR': auth.currentUser.photoURL,*//*
          'createDate':DateTime.now(),


        },
            -----*/

        FirebaseFirestore.instance.collection('users')
            .doc('favorite')
            .collection('LIKE')
            .doc(userId)
            .set({
          /*        'logoURL': auth.currentUser.photoURL,
          'nameAR': auth.currentUser.photoURL,*/
          'createDate':DateTime.now(),
          "id": userId,
          "name": name,
          "memo": memo,
          "imageURL": imageURL,
          "gender": gender,
          "birthday": birthday,
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

          "workday": workday,


        },


        ).then(
              (doc) => print("Document add"),
          onError: (e) => print("Error updating document $e"),
        );



      }else{

        // データを削除する
         delete(userId,name) {
          final db = FirebaseFirestore.instance;
          return db
              .collection("users")
              .doc("favorite")
              .collection("LIKE")
              .doc(name)
              .delete()
              .then(
                (doc) => print("Document deleted"),
            onError: (e) => print("Error updating document $e"),
          );
        }
        /*  FirebaseFirestore.instance
          .collection('users')
          .doc("favorite")
          .collection('LIKE')
          .doc('hqDqsg4TK6QmCOfHPKAA')
          .delete()
          .then(
            (doc) => print("Document deleted"),
        onError: (e) => print("Error updating document $e"),
      );*/
        /*  FirebaseFirestore.instance.collection('users')
          .doc('favorite')
          .collection('LIKE')
          .doc()
          .delete();*/



      }


    }
    /// for launching map with specific [latitude] and [longitude]
    static Future<void> openMap({
      required double latitude,
      required double longitude,
      required String label,
    }) async {
      final query = '$latitude,$longitude($label)';
      final uri = Uri(scheme: 'geo', host: '0,0', queryParameters: {'q': query});

      await launch(uri.toString());
    }
    Widget getImageHeaderWidget() {
      return Container(
        height: 550,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        width: double.maxFinite,
        child: Image.network(cats.imageURL),
        /*  decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        gradient: new LinearGradient(
            colors: [
              const Color(0xFF3366FF).withOpacity(0.1),
              const Color(0xFF3366FF).withOpacity(0.09),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),*/
        /*  child: Hero(
        tag: "GroceryItem:" +
            cats.name +
            "-" +
            (cats.memo ?? ""),

        child: Image.network(cats.imageURL),


      ),*/
      );
    }

    Widget getProductDataRowWidget(String label,
        {required Widget customWidget}) {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
          bottom: 20,
        ),
        child: Row(
          children: [
            AppText(text: label, fontWeight: FontWeight.w600, fontSize: 18),
            Spacer(),
            if (customWidget != null) ...[
              customWidget,
              SizedBox(
                width: 20,
              )
            ],
            Icon(
              Icons.arrow_forward_ios,
              size: 20,
            )
          ],
        ),
      );
    }

    Widget nutritionWidget() {
      return Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Color(0xffEBEBEB),
          borderRadius: BorderRadius.circular(5),
        ),
        child: AppText(
          /* text:cats.name,*/
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: Color(0xff7C7C7C),
        ),
      );
    }

    Widget ratingWidget() {
      Widget starIcon() {
        return Icon(
          Icons.star,
          color: Color(0xffF3603F),
          size: 20,
        );
      }

      return Row(
        children: [
          starIcon(),
          starIcon(),
          starIcon(),
          starIcon(),
          starIcon(),
        ],
      );
    }


  }
