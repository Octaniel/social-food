import 'package:socialfood/app/data/model/video.dart';
import 'package:socialfood/app/data/provider/video_provider.dart';

class VideoRepository{
  final videoProvider = VideoProvider();

  Future<List<Video>> listar(int page, String nome) async {
    return await videoProvider.listar(page, nome);
  }

  Future<bool> salvar(Video video)async{
    return await videoProvider.salvar(video);
  }

  Future<bool> atlauizar(Video video)async{
    return await videoProvider.atlauizar(video);
  }
}