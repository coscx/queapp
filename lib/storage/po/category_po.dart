import 'package:equatable/equatable.dart';


/// 说明: 收藏夹数据库-数据模型

// """
// CREATE TABLE IF NOT EXISTS category(
//     id INTEGER PRIMARY KEY AUTOINCREMENT,
//     name VARCHAR(64) NOT NULL,
//     color VARCHAR(9) DEFAULT '#FF2196F3',
//     info VARCHAR(256) DEFAULT '这里什么都没有...',
//     created DATETIME NOT NULL,
//     updated DATETIME NOT NULL,
//     priority INTEGER DEFAULT 0,
//     image VARCHAR(128) NULL image DEFAULT ''
//     );"""; //建表语句

class CategoryPo extends Equatable {
  final int id;
  final String name;
  final String color;
  final String info;
  final DateTime created;
  final DateTime updated;
  final String image;
  final int count;
  final int priority;

  const CategoryPo(
      {this.id,
      this.name,
      this.color = '#FFF2F2F2',
      this.created,
      this.updated,
        this.count = 0,
      this.priority = 0,
      this.info = '这里什么都没有...',
      this.image = ''});

  factory CategoryPo.fromJson(Map<String, dynamic> map) {
    return CategoryPo(
        id: map['id'],
        name: map['name'],
        color: map["color"],
        created: DateTime.parse(map["created"]),
        image: map["image"],
        priority: map["priority"],
        count: map["count"],
        updated: DateTime.parse(map["updated"]),
        info: map["info"]);
  }


  @override
  String toString() {
    return 'CategoryPo{id: $id, name: $name, color: $color, info: $info, created: $created, updated: $updated, image: $image, count: $count, priority: $priority}';
  }

  @override
  List<Object> get props =>
      [id, name, color, created, image, info, updated, priority,count];
}
