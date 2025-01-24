// Entidad que representa la carta

class GenericCard {
  final String id;
  final String name;
  final String imageFront;
  final String imageBack;
  CardMode mode;

  GenericCard({
    required this.id,
    required this.name,
    required this.imageFront,
    required this.imageBack,
    required this.mode,
  });
}

enum CardMode { front, back }
