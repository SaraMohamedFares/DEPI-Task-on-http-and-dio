class Item {
  final int amount;
  final String category;
  final int date;
  final String? id;
  final String note;

  Item(
      {required this.amount, required this.category, required this.date, this.id, required this.note});

  Map<String, dynamic> toMap() {
    return {
      'amount': this.amount,
      'category': this.category,
      'date': this.date,
      'id': this.id,
      'note': this.note,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      amount: map['amount'] as int,
      category: map['category'] as String,
      date: map['date'] as int,
      id: map['id'] as String,
      note: map['note'] as String,
    );
  }

}