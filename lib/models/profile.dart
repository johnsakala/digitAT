class Profile{

    int id;
  String name;
  String lname;
  String sname;
  String phone;
  String city;
  String gender;
  String email;
  String emailId;
  String phoneId;
 

  Profile.init();
  Profile.min(this.id,this.name,this.city);
  Profile.first(this.id,this.name,this.phone,this.city);
  Profile(this.id,this.name, this.sname,this.lname,this.phone,this.city,this.email,this.emailId,this.phoneId, this.gender);
}