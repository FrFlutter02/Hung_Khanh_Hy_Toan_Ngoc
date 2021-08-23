class HowToCookModel {
  final String id;
  final int step;
  final String textHowToCook;
  final String duration;

  const HowToCookModel({
    required this.id,
    required this.step,
    required this.textHowToCook,
    required this.duration,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'step': "$step",
        'stepText': textHowToCook,
        'duration': duration,
      };
}
