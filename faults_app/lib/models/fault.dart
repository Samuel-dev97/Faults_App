class Fault {
  int id;
  final String title;
  final String description;

  Fault({required this.id, required this.title, required this.description});

  factory Fault.fromJson(Map<String, dynamic> json) {
    return Fault(
        id: json['id'], title: json['title'], description: json['description']);
  }
}
