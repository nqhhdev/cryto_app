class Chart {
  Chart({
    required this.currency,
    required this.timestamps,
    required this.prices,
  });

  String currency;
  List<DateTime> timestamps;
  List<String> prices;

  factory Chart.fromJson(Map<String, dynamic> json) => Chart(
        currency: json["currency"],
        timestamps: List<DateTime>.from(
            json["timestamps"].map((x) => DateTime.parse(x))),
        prices: List<String>.from(json["prices"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "currency": currency,
        "timestamps":
            List<dynamic>.from(timestamps.map((x) => x.toIso8601String())),
        "prices": List<dynamic>.from(prices.map((x) => x)),
      };
}
