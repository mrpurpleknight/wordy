abstract class Repository<T> {
  void write(T t);
  Future<List<T>> readAll();
}