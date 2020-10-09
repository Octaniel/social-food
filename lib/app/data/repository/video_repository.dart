import 'package:socialfood/app/data/model/video.dart';
import 'package:socialfood/app/data/provider/video_provider.dart';

class VideoRepository{
  final videoProvider = VideoProvider();

  Future<List<Video>> listar() async {
    return await videoProvider.listar();
  }

  Future<bool> salvar(Video video)async{
    return await videoProvider.salvar(video);
  }
}