import 'package:anubhuti/data/model/Journel.dart';
import 'package:hive/hive.dart';

int index_data=0;

class JournelRepo {

  final Box<Journel> _box = Hive.box<Journel>('Journel_Box');

  Journel? getData(int index) {
    if (index < 0 || index >= _box.length) return null;
    return _box.getAt(index);
  }

  Future<void> addData(Journel Data) async {
    await _box.add(Data);
  }

  Future<void> deleteData(int index) async {
    if (index >= 0 && index < _box.length) {
      await _box.deleteAt(index);
    }
  }

  List<Journel> getAllData() {
    return _box.values.toList();
  }

  void setIndex(int index) {
    index_data = index;
  }

  int getIndex() {
    return index_data;
  }
}
