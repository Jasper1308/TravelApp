enum ExperienceType { culture, culinary, historic, localEstablishments, nature }

extension ExperienceTypeExtension on ExperienceType {
  String get toString {
    switch (this) {
      case ExperienceType.culture:
        return 'Cultura';
      case ExperienceType.culinary:
        return 'Culinaridade';
      case ExperienceType.historic:
        return 'História';
      case ExperienceType.localEstablishments:
        return 'Estabelecimentos Locais';
      case ExperienceType.nature:
        return 'Natureza';
    }
  }
}
