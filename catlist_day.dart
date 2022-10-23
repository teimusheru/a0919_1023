import 'dart:math';

import 'package:a0919/syousai.dart';
import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/indicator/custom_indicator.dart';
import 'package:intl/intl.dart';


import 'card/firestore_cats.dart';
import 'cat_detail.dart';
import 'cat_detail_edit.dart';

import 'card/firestore_helper.dart';
import 'item/app_text.dart';
import 'item/colors.dart';
import 'main_sub.dart';
import 'map.dart';



class CatList_day extends StatefulWidget {
// catsテーブルの中の1件のデータに対する操作を行うクラス

  final String dateFormat;
  final DateTime date;


  const CatList_day({Key? key,


    required this.dateFormat,
    required this.date,

  })
      : super(key: key);

  @override
  _CatDetailState createState() => _CatDetailState();
}

class _CatDetailState extends State<CatList_day> {
  late Cats cats;


  List<DocumentSnapshot> catSnapshot = [];
  List<Cats> catList = []; //catsテーブルの全件を保有する
  bool isLoading = false; //テーブル読み込み中の状態を保有する
  static const String userId = 'test@apricotcomic.com'; //仮のユーザID。認証機能を実装したら、本物のIDに変更する。

// Stateのサブクラスを作成し、initStateをオーバーライドすると、wedgit作成時に処理を動かすことができる。
// ここでは、初期処理としてCatsの全データを取得する。
  @override
  void initState() {
    super.initState();
    getCatsList();
  }



// initStateで動かす処理。
// catsテーブルに登録されている全データを取ってくる
  Future getCatsList() async {
    setState(() => isLoading = true);                   //テーブル読み込み前に「読み込み中」の状態にする
    catSnapshot = await FirestoreHelper.instance
        .selectAllCats_day(userId,dateFormat);

    //users配下のcatsコレクションのドキュメントをを全件読み込む
    catList = catSnapshot
        .map((doc) => Cats(
        id: doc['id'],
        name: doc['name'],
        name1: doc['name1'],
        gender: doc['gender'],
        birthday: doc['birthday'],

        memo: doc['memo'],
        imageURL: doc['imageURL'],
        workday: doc['workday'],

        syokusyu: doc['syokusyu'],
        koutuhi: doc['koutuhi'],
        motimono: doc['motimono'],
        sonota: doc['sonota'],
        naiyou: doc['naiyou'],
        tyui: doc['tyui'],

        workmap: doc['workmap'],
        workmap_gm: doc['workmap_gm'],
        ido: doc['ido'],
        keido: doc['keido'],
        kinkyu: doc['kinkyu'],





        createdAt: doc['createdAt'].toDate()))
        .toList();
    setState(() => isLoading = false);                  //「読み込み済」の状態にする
  }




  final double width = 524;
  final double height = 360;
  final Color borderColor = Color(0xffE2E2E2);
  final double borderRadius = 28;


  @override
  Widget build(BuildContext context) {


    CalendarAgendaController _calendarAgendaControllerAppBar =
    CalendarAgendaController();
    CalendarAgendaController _calendarAgendaControllerNotAppBar =
    CalendarAgendaController();

    DateTime _selectedDateAppBBar;
    DateTime _selectedDateNotAppBBar;

    Random random = new Random();

    final int pageCount = 4;
    late PageController _controller = PageController(initialPage: 3);
    CustomTabBarController _tabBarController = CustomTabBarController();

/*    @override
    void initState() {
      super.initState();
      _selectedDateAppBBar = _selectedDateAppBBar;
      _selectedDateNotAppBBar = DateTime.now();
    }*/

   // final cat = catList[0];
    late String dateFormat;
    late  DateTime date ;
    late  DateTime _selectedDateAppBBar1 ;


    return Scaffold(
      ///tab スライド日付
      appBar: CalendarAgenda(

        controller: _calendarAgendaControllerAppBar,
        appbar: true,
        selectedDayPosition: SelectedDayPosition.left,
        leading: IconButton(
          icon: Icon(
            Icons.place,
            color: Colors.white,
          ),
          /*onPressed: () {
            _calendarAgendaControllerAppBar.goToDay(DateTime.now());
            getCatsList;  //これ読み直してるかな;
          },*/

          onPressed: () async {                                       // ＋ボタンを押したときの処理を設定
            await Navigator.of(context).push(                         // ページ遷移をNavigatorで設定
              MaterialPageRoute(
                  builder: (context) =>  map1()// 詳細更新画面（元ネタがないから新規登録）を表示するcat_detail_edit.dartへ遷移
              ),
            );
            getCatsList();                                            // 新規登録されているので、catテーブル全件読み直し
          },
        ),
        weekDay: WeekDay.long,
        fullCalendarScroll: FullCalendarScroll.horizontal,
        fullCalendarDay: WeekDay.long,
        selectedDateColor: Colors.green.shade900,
        locale: 'ja_JP',
        initialDate:widget.date,
        calendarEventColor: Colors.green,
        firstDate: widget.date.subtract(Duration(days: 0)),
        lastDate: widget.date.add(Duration(days: 180)),
        events: List.generate(
            100,
                (index) =>
                DateTime.now()
                    .subtract(Duration(days: index * random.nextInt(5)))),
        onDateSelected: (date1) {
          setState(() {
            _selectedDateAppBBar1 = date1;
            //debugPrint('debug: $date');  ///デバッグ確認方法1012
            //これが変数になってるのでは　1023

            ///dateを　２０２２年１１月１日　
            setState(() {
              dateFormat = DateFormat("yyyyMMdd").format(_selectedDateAppBBar1)  ;
            });

            getCatsList;  //これ読み直してるかな
            Navigator.of(context).push(   // ページ遷移をNavigatorで設定
              MaterialPageRoute(

                  builder: (context) => CatList_day(
                    dateFormat: dateFormat,
                    date: date1,



                  )

              ),
            );


          });
          //FirestoreHelper(date);


        },
        calendarLogo: Image.network(
          'https://www.kindpng.com/picc/m/355-3557482_flutter-logo-png-transparent-png.png',
          scale: 5.0,
        ),
        selectedDayLogo: NetworkImage(
          'https://www.kindpng.com/picc/m/355-3557482_flutter-logo-png-transparent-png.png',
          scale: 15.0,
        ),

      ),///


      body:

      isLoading                               //「読み込み中」だったら「グルグル」が表示される
          ? const Center(
        child: CircularProgressIndicator(),   // これが「グルグル」の処理
      )
          : SizedBox(
        child: ListView.builder(              // 取得したcatsテーブル全件をリスト表示する
          itemCount: catList.length,          // 取得したデータの件数を取得
          itemBuilder: (BuildContext context, int index) {


            final cat = catList[index];

            // 1件分のデータをcatに取り出す
            return Card(                      // ここで1件分のデータを表示
              child: InkWell(                 // cardをtapしたときにそのcardの詳細画面に遷移させる
                child: Padding(               // cardのpadding設定
                  padding: const EdgeInsets.all(15.0),
                  child: Row(                 // cardの中身をRowで設定
                      children: <Widget>[               // Rowの中身を設定
                        Container(
                          width: width,
                          height: height,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: borderColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              borderRadius,
                            ),
                          ),
                          child: Padding(  //枠線とのpadding
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Expanded(
                                  child: Center(

                                    child: Image.network(cat.imageURL),

                                  ),
                                ),
                                SizedBox(
                                  height: 1,
                                ),

                                ///タイトル１
                                AppText(
                                  text:cat.name1,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,


                                ),


                                ///  横　coloum 参考
                                /* Container(
                                    child: new Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: <Widget>[
                                          new Row(
                                            children: <Widget>[
                                              AppText(
                                                text: cat.name,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF7C7C7C),
                                              ),
                                              Text(
                                                '￥-999.999.999,95',
                                                style: new TextStyle(
                                                    fontSize: 14.0,
                                                    fontFamily: 'Roboto',
                                                    color: new Color(0xFF212121)),
                                              ),
                                            ],
                                          ),
                                        ])),*/
                                SizedBox(
                                  height: 3,
                                ),
                                ///住所
                                AppText(
                                  text: cat.workday,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF7C7C7C),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  children: [

                                    ///金額
                                    AppText(
                                      text: "￥${cat.memo}",
                                      fontSize: 18,
                                      //fontWeight: FontWeight.bold,
                                    ),
                                    Spacer(),
                                    addWidget()
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        //Text(cat.name,style: const TextStyle(fontSize: 30),),
                        //Text(cat.memo,style: const TextStyle(fontSize: 30),),
                        // catのnameを表示
                      ]
                  ),
                ),
                onTap: () async {                     // cardをtapしたときの処理を設定
                  await Navigator.of(context).push(   // ページ遷移をNavigatorで設定
                    MaterialPageRoute(
                      builder: (context) => syousai(

                        userId: userId,
                        name: cat.name,
                        memo: cat.memo,
                        imageURL: cat.imageURL,
                        //追加1017
                        name1: cat.name1,
                        gender: cat.gender,
                        birthday: cat.birthday,
                        syokusyu: cat.syokusyu,

                        koutuhi: cat.koutuhi,
                        motimono: cat.motimono,
                        sonota: cat.sonota,

                        naiyou: cat.naiyou,
                        tyui: cat.tyui,
                        workmap: cat.workmap,
                        workmap_gm: cat.workmap_gm,


                        ido: cat.ido,
                        keido: cat.keido,
                        kinkyu: cat.kinkyu,

                        workday: cat.workday,
                        //createdAt: cat.createdAt,





                        // cardのデータの詳細を表示するcat_detail.dartへ遷移
                      ),
                    ),
                  );
                  getCatsList();    // データが更新されているかもしれないので、catsテーブル全件読み直し
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(                   // ＋ボタンを下に表示する
        child: const Icon(Icons.add),                               // ボタンの形を指定
        onPressed: () async {                                       // ＋ボタンを押したときの処理を設定
          await Navigator.of(context).push(                         // ページ遷移をNavigatorで設定
            MaterialPageRoute(
                builder: (context) => const CatDetailEdit(userId: userId) // 詳細更新画面（元ネタがないから新規登録）を表示するcat_detail_edit.dartへ遷移
            ),
          );
          getCatsList();// 新規登録されているので、catテーブル全件読み直し
          initState(); //まだエラー出る
        },
      ),

    );
  }
  /* Widget imageWidget() {
    return Container(
      child: Image.asset(item.imagePath),
    );
  }*/

  Widget addWidget() {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: AppColors.primaryColor),
      child: Center(
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 25,
        ),
      ),
    );
  }

}


