class Estado {
  int id;
  String uf;

  Estado(this.id, this.uf);

  factory Estado.fromJson(Map<String, dynamic> json) {
    return Estado(json["id"] as int, json["uf"] as String);
  }
  Map<String, dynamic> toJson() => {if (id != 0) 'id': id, 'uf': uf};
}
