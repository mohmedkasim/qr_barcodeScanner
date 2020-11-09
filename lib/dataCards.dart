class CardsProvides {
  List<Providers> providers;

  CardsProvides({this.providers});

  CardsProvides.fromJson(Map<String, dynamic> json) {
    if (json['Providers'] != null) {
      providers = new List<Providers>();
      json['Providers'].forEach((v) {
        providers.add(new Providers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.providers != null) {
      data['Providers'] = this.providers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Providers {
  String name;

  Providers({this.name});

  Providers.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    return data;
  }
}
