final String url1 = "http://localhost:8080/";
final String url2 = "https://feed-food.herokuapp.com/";
final String url = url1;

String decoder(String body) {
  body = body.replaceAll('Ã§', 'ç');
  body = body.replaceAll('Ãµ', 'õ');
  body = body.replaceAll('Ã', 'Ç');
  body = body.replaceAll('Ã©', 'é');
  return body;
}
