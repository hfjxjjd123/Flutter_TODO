import 'dart:async';
import 'package:secare/data/stuff_model.dart';

class BLOC{
  final progressController = StreamController<Future<List<StuffModel>>>();

  get addProgress => progressController.sink.add;
}
