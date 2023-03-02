import '../Models/program.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeriesDetailsProvider extends ChangeNotifier with ReassembleHandler {
  bool isLoading = false;
  bool isLoadingMore = false;
  ScrollController scrollController = ScrollController();
  final SerieRowModel serie;

  SeriesDetailsProvider({required this.serie});

  getDatas(BuildContext context, {bool resetPage = false}) async {}
  @override
  void reassemble() {}
}
