import 'package:sky_score_generator/data/constants.dart';

class Chord {
  Chord._({
    bool c_1 = false,
    bool d_1 = false,
    bool e_1 = false,
    bool f_1 = false,
    bool g_1 = false,
    bool a_1 = false,
    bool b_1 = false,
    bool c_2 = false,
    bool d_2 = false,
    bool e_2 = false,
    bool f_2 = false,
    bool g_2 = false,
    bool a_2 = false,
    bool b_2 = false,
    bool c_3 = false,
  })  : _c_1 = c_1,
        _d_1 = d_1,
        _e_1 = e_1,
        _f_1 = f_1,
        _g_1 = g_1,
        _a_1 = a_1,
        _b_1 = b_1,
        _c_2 = c_2,
        _d_2 = d_2,
        _e_2 = e_2,
        _f_2 = f_2,
        _g_2 = g_2,
        _a_2 = a_2,
        _b_2 = b_2,
        _c_3 = c_3;

  bool _c_1;
  bool _d_1;
  bool _e_1;
  bool _f_1;
  bool _g_1;
  bool _a_1;
  bool _b_1;
  bool _c_2;
  bool _d_2;
  bool _e_2;
  bool _f_2;
  bool _g_2;
  bool _a_2;
  bool _b_2;
  bool _c_3;

  static Chord empty() {
    return Chord._();
  }

  static Chord fromSoundKeys(List<SoundKey> soundKeys) {
    Chord chord = Chord._();
    soundKeys.forEach((key) {
      chord.setSound(key, true);
    });

    return chord;
  }

  void setSound(SoundKey soundKey, bool flag) {
    switch (soundKey) {
      case SoundKey.c_1:
        this._c_1 = flag;
        break;
      case SoundKey.d_1:
        this._d_1 = flag;
        break;
      case SoundKey.e_1:
        this._e_1 = flag;
        break;
      case SoundKey.f_1:
        this._f_1 = flag;
        break;
      case SoundKey.g_1:
        this._g_1 = flag;
        break;
      case SoundKey.a_1:
        this._a_1 = flag;
        break;
      case SoundKey.b_1:
        this._b_1 = flag;
        break;
      case SoundKey.c_2:
        this._c_2 = flag;
        break;
      case SoundKey.d_2:
        this._d_2 = flag;
        break;
      case SoundKey.e_2:
        this._e_2 = flag;
        break;
      case SoundKey.f_2:
        this._f_2 = flag;
        break;
      case SoundKey.g_2:
        this._g_2 = flag;
        break;
      case SoundKey.a_2:
        this._a_2 = flag;
        break;
      case SoundKey.b_2:
        this._b_2 = flag;
        break;
      case SoundKey.c_3:
        this._c_3 = flag;
        break;
    }
  }

  void toggleSound(SoundKey soundKey) {
    switch (soundKey) {
      case SoundKey.c_1:
        this._c_1 = !this._c_1;
        break;
      case SoundKey.d_1:
        this._d_1 = !this._d_1;
        break;
      case SoundKey.e_1:
        this._e_1 = !this._e_1;
        break;
      case SoundKey.f_1:
        this._f_1 = !this._f_1;
        break;
      case SoundKey.g_1:
        this._g_1 = !this._g_1;
        break;
      case SoundKey.a_1:
        this._a_1 = !this._a_1;
        break;
      case SoundKey.b_1:
        this._b_1 = !this._b_1;
        break;
      case SoundKey.c_2:
        this._c_2 = !this._c_2;
        break;
      case SoundKey.d_2:
        this._d_2 = !this._d_2;
        break;
      case SoundKey.e_2:
        this._e_2 = !this._e_2;
        break;
      case SoundKey.f_2:
        this._f_2 = !this._f_2;
        break;
      case SoundKey.g_2:
        this._g_2 = !this._g_2;
        break;
      case SoundKey.a_2:
        this._a_2 = !this._a_2;
        break;
      case SoundKey.b_2:
        this._b_2 = !this._b_2;
        break;
      case SoundKey.c_3:
        this._c_3 = !this._c_3;
        break;
    }
  }

  bool get(SoundKey soundKey) {
    switch (soundKey) {
      case SoundKey.c_1:
        return this._c_1;
      case SoundKey.d_1:
        return this._d_1;
      case SoundKey.e_1:
        return this._e_1;
      case SoundKey.f_1:
        return this._f_1;
      case SoundKey.g_1:
        return this._g_1;
      case SoundKey.a_1:
        return this._a_1;
      case SoundKey.b_1:
        return this._b_1;
      case SoundKey.c_2:
        return this._c_2;
      case SoundKey.d_2:
        return this._d_2;
      case SoundKey.e_2:
        return this._e_2;
      case SoundKey.f_2:
        return this._f_2;
      case SoundKey.g_2:
        return this._g_2;
      case SoundKey.a_2:
        return this._a_2;
        break;
      case SoundKey.b_2:
        return this._b_2;
      case SoundKey.c_3:
        return this._c_3;
      default:
        return null;
    }
  }

  void reset() {
    this._c_1 = false;
    this._d_1 = false;
    this._e_1 = false;
    this._f_1 = false;
    this._g_1 = false;
    this._a_1 = false;
    this._b_1 = false;
    this._c_2 = false;
    this._d_2 = false;
    this._e_2 = false;
    this._f_2 = false;
    this._g_2 = false;
    this._a_2 = false;
    this._b_2 = false;
    this._c_3 = false;
  }

  List<SoundKey> toSoundKeys() {
    return <SoundKey>[
      if (this._c_1) SoundKey.c_1,
      if (this._d_1) SoundKey.d_1,
      if (this._e_1) SoundKey.e_1,
      if (this._f_1) SoundKey.f_1,
      if (this._g_1) SoundKey.g_1,
      if (this._a_1) SoundKey.a_1,
      if (this._b_1) SoundKey.b_1,
      if (this._c_2) SoundKey.c_2,
      if (this._d_2) SoundKey.d_2,
      if (this._e_2) SoundKey.e_2,
      if (this._f_2) SoundKey.f_2,
      if (this._g_2) SoundKey.g_2,
      if (this._a_2) SoundKey.a_2,
      if (this._b_2) SoundKey.b_2,
      if (this._c_3) SoundKey.c_3,
    ];
  }

  bool allMatch(List<SoundKey> inputtedKeys) {
    return this.toSoundKeys().every((key) => inputtedKeys.contains(key));
  }

  bool isEnabled(SoundKey soundKey) {
    switch (soundKey) {
      case SoundKey.c_1:
        return this._c_1;
        break;
      case SoundKey.d_1:
        return this._d_1;
        break;
      case SoundKey.e_1:
        return this._e_1;
        break;
      case SoundKey.f_1:
        return this._f_1;
        break;
      case SoundKey.g_1:
        return this._g_1;
        break;
      case SoundKey.a_1:
        return this._a_1;
        break;
      case SoundKey.b_1:
        return this._b_1;
        break;
      case SoundKey.c_2:
        return this._c_2;
        break;
      case SoundKey.d_2:
        return this._d_2;
        break;
      case SoundKey.e_2:
        return this._e_2;
        break;
      case SoundKey.f_2:
        return this._f_2;
        break;
      case SoundKey.g_2:
        return this._g_2;
        break;
      case SoundKey.a_2:
        return this._a_2;
        break;
      case SoundKey.b_2:
        return this._b_2;
        break;
      case SoundKey.c_3:
        return this._c_3;
        break;
      default:
        return false;
    }
  }

  bool isSetAny() {
    return this._c_1 ||
        this._d_1 ||
        this._e_1 ||
        this._f_1 ||
        this._g_1 ||
        this._a_1 ||
        this._b_1 ||
        this._c_2 ||
        this._d_2 ||
        this._e_2 ||
        this._f_2 ||
        this._g_2 ||
        this._a_2 ||
        this._b_2 ||
        this._c_3;
  }

  Chord copyWith({
    bool c_1,
    bool d_1,
    bool e_1,
    bool f_1,
    bool g_1,
    bool a_1,
    bool b_1,
    bool c_2,
    bool d_2,
    bool e_2,
    bool f_2,
    bool g_2,
    bool a_2,
    bool b_2,
    bool c_3,
  }) {
    return new Chord._(
      c_1: c_1 ?? this._c_1,
      d_1: d_1 ?? this._d_1,
      e_1: e_1 ?? this._e_1,
      f_1: f_1 ?? this._f_1,
      g_1: g_1 ?? this._g_1,
      a_1: a_1 ?? this._a_1,
      b_1: b_1 ?? this._b_1,
      c_2: c_2 ?? this._c_2,
      d_2: d_2 ?? this._d_2,
      e_2: e_2 ?? this._e_2,
      f_2: f_2 ?? this._f_2,
      g_2: g_2 ?? this._g_2,
      a_2: a_2 ?? this._a_2,
      b_2: b_2 ?? this._b_2,
      c_3: c_3 ?? this._c_3,
    );
  }

  @override
  String toString() {
    return 'Chord{_c_1: $_c_1, _d_1: $_d_1, _e_1: $_e_1, _f_1: $_f_1, _g_1: $_g_1, _a_1: $_a_1, _b_1: $_b_1, _c_2: $_c_2, _d_2: $_d_2, _e_2: $_e_2, _f_2: $_f_2, _g_2: $_g_2, _a_2: $_a_2, _b_2: $_b_2, _c_3: $_c_3}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Chord &&
          runtimeType == other.runtimeType &&
          _c_1 == other._c_1 &&
          _d_1 == other._d_1 &&
          _e_1 == other._e_1 &&
          _f_1 == other._f_1 &&
          _g_1 == other._g_1 &&
          _a_1 == other._a_1 &&
          _b_1 == other._b_1 &&
          _c_2 == other._c_2 &&
          _d_2 == other._d_2 &&
          _e_2 == other._e_2 &&
          _f_2 == other._f_2 &&
          _g_2 == other._g_2 &&
          _a_2 == other._a_2 &&
          _b_2 == other._b_2 &&
          _c_3 == other._c_3);

  @override
  int get hashCode =>
      _c_1.hashCode ^
      _d_1.hashCode ^
      _e_1.hashCode ^
      _f_1.hashCode ^
      _g_1.hashCode ^
      _a_1.hashCode ^
      _b_1.hashCode ^
      _c_2.hashCode ^
      _d_2.hashCode ^
      _e_2.hashCode ^
      _f_2.hashCode ^
      _g_2.hashCode ^
      _a_2.hashCode ^
      _b_2.hashCode ^
      _c_3.hashCode;

  factory Chord.fromMap(Map<String, dynamic> map) {
    return new Chord._(
      c_1: map['_c_1'] as bool,
      d_1: map['_d_1'] as bool,
      e_1: map['_e_1'] as bool,
      f_1: map['_f_1'] as bool,
      g_1: map['_g_1'] as bool,
      a_1: map['_a_1'] as bool,
      b_1: map['_b_1'] as bool,
      c_2: map['_c_2'] as bool,
      d_2: map['_d_2'] as bool,
      e_2: map['_e_2'] as bool,
      f_2: map['_f_2'] as bool,
      g_2: map['_g_2'] as bool,
      a_2: map['_a_2'] as bool,
      b_2: map['_b_2'] as bool,
      c_3: map['_c_3'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      '_c_1': this._c_1,
      '_d_1': this._d_1,
      '_e_1': this._e_1,
      '_f_1': this._f_1,
      '_g_1': this._g_1,
      '_a_1': this._a_1,
      '_b_1': this._b_1,
      '_c_2': this._c_2,
      '_d_2': this._d_2,
      '_e_2': this._e_2,
      '_f_2': this._f_2,
      '_g_2': this._g_2,
      '_a_2': this._a_2,
      '_b_2': this._b_2,
      '_c_3': this._c_3,
    } as Map<String, dynamic>;
  }
}
