class ApiRoutes {
  static String baseUrl = "http://localhost:8080";
  static String getContatos = "$baseUrl/contacts";
  static String postContatos = "$baseUrl/contacts";
  static String putContato(int id) => "$baseUrl/contact/$id";
  static String deleteContato(int id) => "$baseUrl/contact/$id";
}
