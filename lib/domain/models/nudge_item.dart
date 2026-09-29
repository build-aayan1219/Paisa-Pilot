import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum NudgeType {
  shortfallRisk,
  weekendSpike,
  subscriptionLeak,
  categorySurge,
  savingMilestone,
  safeSpendTip,
  anomalyAlert,
}

class NudgeFactData extends Equatable {
  final String metric;
  final num value;
  final String unit;
  final Map<String, dynamic> metadata;

  const NudgeFactData({
    required this.metric,
    required this.value,
    this.unit = 'INR',
    this.metadata = const {},
  });

  Map<String, dynamic> toJson() => {
        'metric': metric,
        'value': value,
        'unit': unit,
        'metadata': metadata,
      };

  factory NudgeFactData.fromJson(Map<String, dynamic> json) => NudgeFactData(
        metric: json['metric'] as String? ?? '',
        value: (json['value'] as num?) ?? 0,
        unit: json['unit'] as String? ?? 'INR',
        metadata: (json['metadata'] as Map<String, dynamic>?) ?? {},
      );

  @override
  List<Object?> get props => [metric, value, unit, metadata];
}

class NudgeItem extends Equatable {
  final String id;
  final String userId;
  final DateTime timestamp;
  final NudgeType type;
  final String title;
  final String body;
  final String? impactChip;
  final List<NudgeFactData> facts;
  final String? feedback; // 'helpful', 'dismissed', null
  final bool isUrgent;
  final IconData? icon;

  const NudgeItem({
    required this.id,
    required this.userId,
    required this.timestamp,
    required this.type,
    required this.title,
    required this.body,
    this.impactChip,
    this.facts = const [],
    this.feedback,
    this.isUrgent = false,
    this.icon,
  });

  NudgeItem copyWith({
    String? id,
    String? userId,
    DateTime? timestamp,
    NudgeType? type,
    String? title,
    String? body,
    String? impactChip,
    List<NudgeFactData>? facts,
    String? feedback,
    bool? isUrgent,
    IconData? icon,
  }) {
    return NudgeItem(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      title: title ?? this.title,
      body: body ?? this.body,
      impactChip: impactChip ?? this.impactChip,
      facts: facts ?? this.facts,
      feedback: feedback ?? this.feedback,
      isUrgent: isUrgent ?? this.isUrgent,
      icon: icon ?? this.icon,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        timestamp,
        type,
        title,
        body,
        impactChip,
        facts,
        feedback,
        isUrgent,
      ];
}
