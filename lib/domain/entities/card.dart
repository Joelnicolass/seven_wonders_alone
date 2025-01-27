// Entidad que representa la carta

class GenericCard {
  final String id;
  final String name;
  final String imageFront;
  final String imageBack;
  CardMode mode;
  bool isUniqueUse;

  GenericCard({
    required this.id,
    required this.name,
    required this.imageFront,
    required this.imageBack,
    required this.mode,
    this.isUniqueUse = false,
  });
}

enum CardMode { front, back }
