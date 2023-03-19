class Choices {
  final String choices;

  Choices({
    required this.choices,
  });

  factory Choices.fromJson(Map<String, dynamic> json) {
    return Choices(
      choices: json['choices'],
    );
  }
}