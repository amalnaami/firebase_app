class UserData {
  String email;
  String password;
  String name;
  String phone;
  String address;
  // int age;
  // List work;
  // Map family;

  UserData({this.email, this.password, this.name, this.phone,this.address});

  UserData.fromMap(Map map) {
    this.email = map['email'];
    this.password = map['password'];

    this.name = map['name'];
    this.phone = map['phone'];
    this.address = map['address'];
  }

  toJason(){
    return{
    'email':this.email,
    'password':this.password,
    'name':this.name,
    'phone':this.phone,
    'address':this.address,
  };
  }
}
