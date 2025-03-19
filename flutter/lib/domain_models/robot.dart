enum Robot { darren, erica }

extension RobotExt on Robot {
  String get name {
    switch (this) {
      case Robot.darren:
        return 'Darren';
      case Robot.erica:
        return 'Erica';
    }
  }

  String get iconPath {
    switch (this) {
      case Robot.darren:
        return 'assets/icons/ic_darren.png';
      case Robot.erica:
        return 'assets/icons/ic_erica.png';
    }
  }
}
