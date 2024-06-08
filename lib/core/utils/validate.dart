

class Validate{
  static bool phoneValidate(String phone){
    var re = RegExp(r'^(\+84|84|0)[35789][0-9]{8}$');
    if(re.hasMatch(phone)){
      return true;
    }
    return false;
  }
  static bool passwordValidate(String password){
    // Minimum eight characters, at least one uppercase letter,
    // one lowercase letter, one number and one special character
    var re = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    if(re.hasMatch(password)){
      return true;
    }
    return false;
  }
}