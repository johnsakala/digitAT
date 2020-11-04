class OnBoarding {
  String image;
  String title;
  String description;

  OnBoarding({this.image, this.description,this.title});
}

class OnBoardingList {
  List<OnBoarding> _list;

  List<OnBoarding> get list => _list;

  OnBoardingList() {
    _list = [
      new OnBoarding(image: 'images/f1.png', description: 'Manage all the hospital departments',title: 'Manage Hospital/Clinic'),
      new OnBoarding(image: 'images/f-1.png', description: 'Experience reliable doctor to patient interaction.',title: 'Attend to Patient'),
      new OnBoarding(image: 'images/undraw_alien_science_nonm.png', description: 'Attent to orders clients.',title: 'Services'),
    ];
  }
}
