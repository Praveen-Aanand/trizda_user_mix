class RouteArgument {
  String id;
  String heroTag;
  dynamic param;

  RouteArgument({this.id, this.heroTag, this.param});

  @override
  String toString() {
    return '{id: $id, heroTag:${heroTag.toString()}}';
  }
}

class Data {
  String text;
  int counter;
  String dateTime;
  Data({this.text, this.counter, this.dateTime});
}
