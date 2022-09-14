import 'package:sqflite/sqflite.dart';
import 'package:task/api_helper/cartlist_model.dart';
import 'package:path/path.dart';

class DbHelper {
  Database? db;

  Future openDB() async {
    try {
      // Get a location using getDatabasesPath
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'shopping.db');

      // open the database
      db = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          print(db);
          this.db = db;
          createTables();
        },
      );
      return true;
    } catch (e) {
      print("ERROR IN OPEN DATABASE $e");
      return Future.error(e);
    }
  }

  createTables() async {
    try {
      var qry = "CREATE TABLE IF NOT EXISTS cart_list ( "
          "id INTEGER PRIMARY KEY,"
          "shop_id INTEGER,"
          "title TEXT,"
          "featured_image Text,"
          "price REAL)";

      await db?.execute(qry);
    } catch (e) {
      print("ERROR IN CREATE TABLE");
      print(e);
    }
  }

  Future getCartList() async {
    try {
      var list = await db?.rawQuery('SELECT * FROM cart_list', []);
      return list ?? [];
    } catch (e) {
      return Future.error(e);
    }
  }

  Future addToCart(CartData data) async {
    await this.db?.transaction((txn) async {
      var qry =
          'INSERT INTO cart_list(shop_id, title, price, featured_image) VALUES(${data.id}, "${data.title}",${data.price}, "${data.featuredImage}")';
      int id1 = await txn.rawInsert(qry);
      return id1;
    });
  }

  Future removeFromCart(int shopId) async {
    var qry = "DELETE FROM cart_list where shop_id = ${shopId}";
    return await this.db?.rawDelete(qry);
  }
}
