class Profile{

    String id;
  String name;
  String lname;
  String phone;
  String city;
  String gender;

  Profile.init();
  Profile.min(this.id,this.name,this.city);
  Profile(this.id,this.name,this.lname,this.phone,this.city);
}