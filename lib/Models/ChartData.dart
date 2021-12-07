import 'dart:convert';

class ChartData {
  ChartData({
    required this.labels,
    required this.datasets,
  });

  List<DateTime> labels;
  List<Dataset> datasets;

  factory ChartData.fromRawJson(String str) => ChartData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChartData.fromJson(Map<String, dynamic> json) => ChartData(
        labels: List<DateTime>.from(json['labels'].map((x) => DateTime.parse(x))),
        datasets: List<Dataset>.from(json['datasets'].map((x) => Dataset.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'labels': List<dynamic>.from(labels.map((x) => "${x.year.toString().padLeft(4, '0')}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}")),
        'datasets': List<dynamic>.from(datasets.map((x) => x.toJson())),
      };
}

class Dataset {
  Dataset({
    required this.label,
    required this.data,
  });

  String label;
  List<double> data;

  factory Dataset.fromRawJson(String str) => Dataset.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Dataset.fromJson(Map<String, dynamic> json) => Dataset(
        label: json['label'],
        data: List<double>.from(json['data'].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        'label': label,
        'data': List<dynamic>.from(data.map((x) => x)),
      };
}
