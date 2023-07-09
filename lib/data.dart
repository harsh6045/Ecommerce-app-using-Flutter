

class data{
  int? _id;
  String? _name;
  String? _lastname;
  int? _mobileno;
  String? _gender;
  int? _age;
  String? _email;
  String? _pass;
  String? _copass;

  data(this._name,this._mobileno,this._email,this._pass,this._copass,[this._lastname,this._age,this._gender]);

  data.withId(this._id,this._name,this._mobileno,this._email,this._pass,this._copass,[this._lastname,this._age,this._gender]);

  int get id => _id!;
  String get name => _name!;
  String get lastname => _lastname!;
  int get mobile => _mobileno!;
  String get gender => _gender!;
  int get age => _age!;
  String get email => _email!;
  String get pass => _pass!;
  String get copass => _copass!;

  set name(String newName){
    this._name = newName;
  }

  set lastname(String newLastName){
    this._lastname = newLastName;
  }

  set mobile(int newMobile){
    this._mobileno = newMobile;
  }

  set gender(String newgender){
    this._gender = newgender;
  }

  set age(int newage){
    this._age = newage;
  }

  set email(String newemail){
    this._email = newemail;
  }

  set pass(String newpass){
    this._pass = newpass;
  }

  set copass(String newcopass){
    this._copass = newcopass;
  }
  Map<String,dynamic>? toMap(){
    var map = Map<String,dynamic>();
    if(id!=null){
      map['id'] = _id;
    }

    map['name'] = _name;
    map['lastname'] = _lastname;
    map['moibleno'] = _mobileno;
    map['gender'] = _gender;
    map['age'] = _age;
    map['email'] = _email;
    map['pass'] = _pass;
    map['copass'] = _copass;
  }
  data.fromMapObject(Map<String,dynamic> map){
    _id = map['id'];
    _name = map['name'];
    _lastname = map['lastname'];
    _mobileno = map['mobileno'];
    _gender = map['gender'];
    _age = map['age'];
    _email = map['email'];
    _pass = map['pass'];
    _copass = map['copass'];
  }
}
