class UserModel {
  final int id;
  final String? username;
  final String? image;

  UserModel(this.id, {this.username, this.image});

  UserModel.fromMap(Map<String, dynamic> user)
      : id = user['id'],
        username = user['username'],
        image = user['image'];

  Map<String, dynamic> toMap() =>
      {'id': id, 'username': username, 'image': image};
}
