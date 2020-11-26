final String url1 = "http://192.168.0.142:8080/";
final String url11 = "http://197.159.166.11:8080/";
final String url12 = "http://192.168.42.30:8080/";
final String heroku = "https://feed-food-api.herokuapp.com/";
final String ec2 = "http://ec2-15-228-50-178.sa-east-1.compute.amazonaws.com:8080/";
final String ebt = "http://feedfood-env.eba-eimzfix3.sa-east-1.elasticbeanstalk.com/";
final String url = ebt;

String decoder(String body) {
  body = body.replaceAll('Ã§', 'ç');
  body = body.replaceAll('Ãµ', 'õ');
  body = body.replaceAll('Ã', 'Ç');
  body = body.replaceAll('Ã©', 'é');
  body = body.replaceAll('Ã£', 'ã');
  body = body.replaceAll('Ã³', 'ó');
  body = body.replaceAll('Ã', 'Á');
  body = body.replaceAll('Ã­', 'í');
  body = body.replaceAll('Ãº', 'ú');
  body = body.replaceAll('Â°', '°');
  body = body.replaceAll('â¢', '•');
  body = body.replaceAll('ââï¸', '♀');
  return body;
}
