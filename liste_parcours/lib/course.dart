class Course {
  String element;
  bool bought = false;

  Course(this.element);

  update() {
    bought = !bought;
  }
}
