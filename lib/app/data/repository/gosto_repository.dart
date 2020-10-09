import 'package:socialfood/app/data/model/gosto.dart';
import 'package:socialfood/app/data/provider/gosto_provider.dart';

class GostoRepository{
  final gostoProvider = GostoProvider();

  Future<bool> salvar(Gosto gosto)async{
    return gostoProvider.salvar(gosto);
  }
}