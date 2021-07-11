class Coin {
  Coin({
    required this.id,
    required this.currency,
    required this.symbol,
    required this.name,
    required this.logoUrl,
    required this.status,
    required this.price,
    required this.priceDate,
    required this.priceTimestamp,
    required this.circulatingSupply,
    required this.maxSupply,
    required this.marketCap,
    required this.marketCapDominance,
    required this.numExchanges,
    required this.numPairs,
    required this.numPairsUnmapped,
    required this.firstCandle,
    required this.firstTrade,
    required this.rank,
    required this.high,
    required this.the1H,
    required this.the1D,
    required this.the7D,
  });

  String? id;
  String? currency;
  String? symbol;
  String? name;
  String? logoUrl;
  String? status;
  String? price;
  DateTime priceDate;
  DateTime priceTimestamp;
  String? circulatingSupply;
  String? maxSupply;
  String? marketCap;
  String? marketCapDominance;
  String? numExchanges;
  String? numPairs;
  String? numPairsUnmapped;
  DateTime firstCandle;
  DateTime firstTrade;
  String? rank;
  String? high;
  The1D? the1H;
  The1D? the1D;
  The1D? the7D;

  factory Coin.fromJson(Map<String, dynamic> json) => Coin(
        id: json["id"],
        currency: json["currency"],
        symbol: json["symbol"],
        name: json["name"],
        logoUrl: json["logo_url"],
        status: json["status"],
        price: json["price"],
        priceDate: DateTime.parse(json["price_date"]),
        priceTimestamp: DateTime.parse(json["price_timestamp"]),
        circulatingSupply: json["circulating_supply"],
        maxSupply: json["max_supply"],
        marketCap: json["market_cap"],
        marketCapDominance: json["market_cap_dominance"],
        numExchanges: json["num_exchanges"],
        numPairs: json["num_pairs"],
        numPairsUnmapped: json["num_pairs_unmapped"],
        firstCandle: DateTime?.parse(json["first_candle"]),
        firstTrade: DateTime?.parse(json["first_trade"]),
        rank: json["rank"],
        high: json["high"],
        the1H: The1D.fromJson(json["1h"]),
        the1D: The1D.fromJson(json["1d"]),
        the7D: The1D.fromJson(json["7d"]),
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "currency": currency,
        "symbol": symbol,
        "name": name,
        "logo_url": logoUrl,
        "status": status,
        "price": price,
        "price_date": priceDate.toIso8601String(),
        "price_timestamp": priceTimestamp.toIso8601String(),
        "circulating_supply": circulatingSupply,
        "max_supply": maxSupply,
        "market_cap": marketCap,
        "market_cap_dominance": marketCapDominance,
        "num_exchanges": numExchanges,
        "num_pairs": numPairs,
        "num_pairs_unmapped": numPairsUnmapped,
        "first_candle": firstCandle.toIso8601String(),
        "first_trade": firstTrade.toIso8601String(),
        "rank": rank,
        "high": high,
        "1h": the1H?.toJson(),
        "1d": the1D?.toJson(),
        "7d": the7D?.toJson(),
      };
}

class The1D {
  The1D({
    this.volume,
    this.priceChange,
    this.priceChangePct,
    this.volumeChange,
    this.volumeChangePct,
    this.marketCapChange,
    this.marketCapChangePct,
  });

  String? volume;
  String? priceChange;
  String? priceChangePct;
  String? volumeChange;
  String? volumeChangePct;
  String? marketCapChange;
  String? marketCapChangePct;

  factory The1D.fromJson(Map<String, dynamic>? json) => The1D(
        volume: json?["volume"],
        priceChange: json?["price_change"],
        priceChangePct: json?["price_change_pct"],
        volumeChange: json?["volume_change"],
        volumeChangePct: json?["volume_change_pct"],
        marketCapChange: json?["market_cap_change"],
        marketCapChangePct: json?["market_cap_change_pct"],
      );

  Map<String, dynamic> toJson() => {
        "volume": volume,
        "price_change": priceChange,
        "price_change_pct": priceChangePct,
        "volume_change": volumeChange,
        "volume_change_pct": volumeChangePct,
        "market_cap_change": marketCapChange,
        "market_cap_change_pct": marketCapChangePct,
      };
}
