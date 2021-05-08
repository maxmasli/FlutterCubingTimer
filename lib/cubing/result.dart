class Result {
  String _scramble;
  double _time;
  bool _dnf;
  bool _plus2;

  Result(time, scramble, {dnf = false, plus2 = false}) {
    _time = time;
    _scramble = scramble;
    _dnf = dnf;
    _plus2 = plus2;
  }

  double getTime(){
    return _time;
  }

  String getScramble() {
    return _scramble;
  }

  bool isDNF () {
    return _dnf;
  }

  void setDNF(bool b) => _dnf = b;

  bool isPlus2 () {
    return _plus2;
  }

  void setPlus2(bool b) {
    if (b) {
      _time = ((_time + 2)*1000).roundToDouble()/1000;
    } else {
      _time = ((_time - 2)*1000).roundToDouble()/1000;
    }
    _plus2 = b;
  }

}