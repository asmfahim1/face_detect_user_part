import 'database_helper.dart';

class DatabaseRepo {
  final conn = DBHelper.dbHelper;
  DBHelper dbHelper = DBHelper();


  // method for inserting data.  //insert product nature
  Future<int> insertPersonInfo() async {
    var dbClient = await conn.db;
    int result = 0;
    try {
      // Check if the product nature already exists in the local storage
      var existingProductNature = await dbClient!.query(
        DBHelper.personInfoTable,
        where: 'zid = ? AND xcode = ?',
        whereArgs: [
          // productNatureModel.zid,
          // productNatureModel.xcode,
        ],
      );

      if (existingProductNature.isEmpty) {
        // Product nature does not exist, proceed with insertion
        /*result = await dbClient.insert(
          DBHelper.personInfoTable,
          personInfoModel.toJson(),
        );*/
      } else {
        // Product nature already exists, perform update
        result = await dbClient.update(
          DBHelper.personInfoTable,
          {
           // 'xlong': productNatureModel.xlong,
          },
          where: 'zid = ? AND xcode = ?',
          whereArgs: [
            // productNatureModel.zid,
            // productNatureModel.xcode,
          ],
        );
      }
    } catch (e) {
      print('There are some issues inserting product nature insertProductNature method : $e');
    }
    return result;
  }
}
