class QueueModel {
  final int currentNumber;
  final int lastNumber;
  final int estimatedPerPatientMinutes;

  QueueModel({
    required this.currentNumber,
    required this.lastNumber,
    required this.estimatedPerPatientMinutes,
  });

  factory QueueModel.fromJson(Map<String, dynamic> json) {
    return QueueModel(
      currentNumber: json['current_number'] ?? 0,
      lastNumber: json['last_number'] ?? 0,
      estimatedPerPatientMinutes: json['estimated_per_patient_minutes'] ?? 10,
    );
  }
}
