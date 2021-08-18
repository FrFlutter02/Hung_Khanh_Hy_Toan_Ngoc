class ListUser {
  final String name;
  final String time;
  final String avatar;
  final List<String> images;

  ListUser(
      {required this.name,
      required this.time,
      required this.avatar,
      required this.images});
}

const List user_data = [
  {
    "name": "Nick Evan",
    "time": "2",
    "avatar": "assets/users/user0.png",
    "images": [
      "assets/images/recipe_book/dau.jpg"
          "assets/images/potato_recipes/rucxJkblWt8.jpg",
      "assets/images/potato_recipes/8YBHgP0WrEo.jpg",
      "assets/images/potato_recipes/A6DyhlsAXyM.jpg",
    ]
  },
  {
    "name": "Peter Chue",
    "time": "8",
    "avatar": "assets/users/user1.png",
    "images": [
      "assets/images/potato_recipes/Uf0aVyl5C70.jpg",
      "assets/images/potato_recipes/8YBHgP0WrEo.jpg",
      "assets/images/potato_recipes/XNM9O4Kfy2o.jpg",
    ]
  },
  {
    "name": "Join Kerry",
    "time": "3",
    "avatar": "assets/users/user2.png",
    "images": [
      "assets/images/potato_recipes/8YBHgP0WrEo.jpg"
          "assets/images/potato_recipes/A6DyhlsAXyM.jpg",
      "assets/images/potato_recipes/rucxJkblWt8.jpg",
      "assets/images/potato_recipes/XNM9O4Kfy2o.jpg",
    ]
  },
  {
    "name": "Adele Hehe",
    "time": "18",
    "avatar": "assets/users/user3.png",
    "images": [
      "assets/images/potato_recipes/A6DyhlsAXyM.jpg",
      "assets/images/potato_recipes/8YBHgP0WrEo.jpg",
      "assets/images/potato_recipes/rucxJkblWt8.jpg",
    ]
  },
  {
    "name": "Anabel Haha",
    "time": "1",
    "avatar": "assets/images/potato_recipes/A6DyhlsAXyM.jpg",
    "images": [
      "assets/images/potato_recipes/8YBHgP0WrEo.jpg",
      "assets/images/potato_recipes/rucxJkblWt8.jpg",
    ]
  }
];
