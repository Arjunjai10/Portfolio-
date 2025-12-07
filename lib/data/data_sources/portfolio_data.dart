import 'package:my_portfolio/data/models/models.dart';

class PortfolioData {
  static const String name = "Arjun Jai Shanmugam P.V.N";
  static const String tagline = "Full Stack Developer | Flutter & MERN";
  static const String phone = "+91 9345999935";
  static const String email = "arjunjaishanmugam.pvn2023lcse@sece.ac.in";
  static const String githubUrl = "https://github.com/Arjunjai10"; // Placeholder logic needed if invalid
  static const String linkedinUrl = "https://www.linkedin.com/in/arjun-jai-shanmugam-pvn-5788a1364/"; // Placeholder

  static final List<Education> education = [
    Education(
      degree: "BE-CSE",
      institution: "Sri Eshwar College of Engineering",
      score: "7.9 (up to sem 4)",
      period: "2023 – 2027",
    ),
    Education(
      degree: "DIPLOMA(CSE)",
      institution: "NACHIMUTHU Polytechnic College",
      score: "85%",
      period: "2021 – 2023",
    ),
    Education(
      degree: "SSLC",
      institution: "AROKIAMATHA Matric Higher Secondary School",
      score: "pass",
      period: "2020 – 2021",
    ),
  ];

  static final List<Experience> experience = [
    Experience(
      role: "MERN Stack Intern",
      company: "Rampex",
      description:
          "Acquired practical experience with MongoDB, Express, ReactJS, and NodeJS, enabling development of full-stack web applications using the MERN stack. Collaborated on real-world projects, improved RESTful API integration skills, and followed best practices in code structure and version control using Git.",
      period: "2025",
      technologies: ["MongoDB", "Express", "ReactJS", "NodeJS", "Git"],
    ),
    Experience(
      role: "Flutter Development Intern",
      company: "Unknown", // Resume doesn't specify company explicitly for this one, implies same or freelance? Assuming generic or add placeholder
      description:
          "Gained hands-on experience with Flutter and Dart, building responsive UIs, implementing efficient state management, and integrating Firebase and local storage for cross-platform mobile apps.",
      period: "2025",
      technologies: ["Flutter", "Dart", "Firebase"],
    ),
  ];

  static final List<Project> projects = [
    Project(
      title: "Movie Recommendation System",
      description:
          "Built a secure, personalized movie recommendation web app with JWT authentication, intuitive UI, and search/filter features.",
      period: "2025",
      technologies: ["MERN Stack", "JWT"],
    ),
    Project(
      title: "Blogging Platform",
      description:
          "Developed a responsive platform for users to create, edit, and manage blog posts with a dynamic interface and optimized backend APIs.",
      period: "2025",
      technologies: ["MERN Stack"],
    ),
    Project(
      title: "SkyCast-Flutter Weather App",
      description:
          "Developed a cross-platform weather application that provides real-time weather forecast, location based features, dynamic layouts and interactive weather effects.",
      period: "2025",
      technologies: ["Flutter", "Dart", "Weather API"],
    ),
  ];

  static final List<Skill> skills = [
    Skill(category: "Languages", names: ["C", "C++", "Java", "Python", "React", "Dart"]),
    Skill(category: "Core", names: ["Full Stack (Tester and Developer)"]),
    Skill(category: "Frameworks", names: ["React", "Flutter (State Management)"]),
    Skill(category: "Tools", names: ["VS Code", "Power BI", "GitHub", "Canvas", "Android Studio"]),
  ];

  static final List<String> certifications = [
    "MERN | Rampex | 2025",
    "Learning React | Infy springboard | 2025",
    "MongoDB | Infy springboard | 2025",
    "Networking Basics | Cisco Networking Academy | 2025",
    "Fundamentals of Deep Learning | NVIDIA | 2025",
    "Java programming | Udemy | 2024",
    "Python programming | SkillRack | 2023",
  ];
  
  static final List<String> achievements = [
    "LeetCode: 100+ Problems",
    "CodeChef: 100+ Problems",
    "SkillRack: 450+ Problems – 58480 Rank",
  ];
}
