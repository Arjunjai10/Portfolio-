class Education {
  final String institution;
  final String degree;
  final String score;
  final String period;

  Education({
    required this.institution,
    required this.degree,
    required this.score,
    required this.period,
  });
}

class Experience {
  final String role;
  final String company;
  final String description;
  final String period;
  final List<String> technologies;

  Experience({
    required this.role,
    required this.company,
    required this.description,
    required this.period,
    required this.technologies,
  });
}

class Project {
  final String title;
  final String description;
  final String period;
  final List<String> technologies;
  final String? link;
  final String? apkLink;

  Project({
    required this.title,
    required this.description,
    required this.period,
    required this.technologies,
    this.link,
    this.apkLink,
  });
}

class Skill {
  final String category;
  final List<String> names;

  Skill({
    required this.category,
    required this.names,
  });
}
