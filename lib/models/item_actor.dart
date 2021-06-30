class Actors {
  int _page;
  List<Results> _results;
  int _totalPages;
  int _totalResults;

  Actors({int page, List<Results> results, int totalPages, int totalResults}) {
    this._page = page;
    this._results = results;
    this._totalPages = totalPages;
    this._totalResults = totalResults;
  }

  int get page => _page;
  List<Results> get results => _results;
  int get totalPages => _totalPages;
  int get totalResults => _totalResults;

  Actors.fromJson(Map<String, dynamic> json) {
    _page = json['page'];
    if (json['results'] != null) {
      _results = new List<Results>();
      json['results'].forEach((v) {
        _results.add(new Results.fromJson(v));
      });
    }
    _totalPages = json['total_pages'];
    _totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this._page;
    if (this._results != null) {
      data['results'] = this._results.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this._totalPages;
    data['total_results'] = this._totalResults;
    return data;
  }
}

class Results {
  bool _adult;
  String _name;
  String _profilePath;
  List<KnownFor> _knownFor;
  var _id;
  int _gender;
  String _knownForDepartment;
  double _popularity;
  String _mediaType;

  Results(
      {bool adult,
        String name,
        String profilePath,
        List<KnownFor> knownFor,
        double id,
        int gender,
        String knownForDepartment,
        double popularity,
        String mediaType}) {
    this._adult = adult;
    this._name = name;
    this._profilePath = profilePath;
    this._knownFor = knownFor;
    this._id = id;
    this._gender = gender;
    this._knownForDepartment = knownForDepartment;
    this._popularity = popularity;
    this._mediaType = mediaType;
  }

  bool get adult => _adult;
  String get name => _name;
  String get profilePath => _profilePath;
  List<KnownFor> get knownFor => _knownFor;
  String get id => _id;
  int get gender => _gender;
  String get knownForDepartment => _knownForDepartment;
  double get popularity => _popularity;
  String get mediaType => _mediaType;

  Results.fromJson(Map<String, dynamic> json) {
    _adult = json['adult'];
    _name = json['name'];
    _profilePath = json['profile_path'];
    if (json['known_for'] != null) {
      _knownFor = new List<KnownFor>();
      json['known_for'].forEach((v) {
        _knownFor.add(new KnownFor.fromJson(v));
      });
    }
    _id = json['id'].toString();
    _gender = json['gender'];
    _knownForDepartment = json['known_for_department'];
    _popularity = json['popularity'];
    _mediaType = json['media_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adult'] = this._adult;
    data['name'] = this._name;
    data['profile_path'] = this._profilePath;
    if (this._knownFor != null) {
      data['known_for'] = this._knownFor.map((v) => v.toJson()).toList();
    }
    data['id'] = this._id;
    data['gender'] = this._gender;
    data['known_for_department'] = this._knownForDepartment;
    data['popularity'] = this._popularity;
    data['media_type'] = this._mediaType;
    return data;
  }
}

class KnownFor {
  bool _video;
  String _title;
  String _mediaType;
  String _overview;
  String _releaseDate;
  double _popularity;
  var _voteCount;
  bool _adult;
  String _backdropPath;
  var _id;
  List<int> _genreIds;
  double _voteAverage;
  String _originalLanguage;
  String _originalTitle;
  String _posterPath;

  KnownFor(
      {bool video,
        String title,
        String mediaType,
        String overview,
        String releaseDate,
        double popularity,
        String voteCount,
        bool adult,
        String backdropPath,
        String id,
        List<int> genreIds,
        double voteAverage,
        String originalLanguage,
        String originalTitle,
        String posterPath}) {
    this._video = video;
    this._title = title;
    this._mediaType = mediaType;
    this._overview = overview;
    this._releaseDate = releaseDate;
    this._popularity = popularity;
    this._voteCount = voteCount;
    this._adult = adult;
    this._backdropPath = backdropPath;
    this._id = id;
    this._genreIds = genreIds;
    this._voteAverage = voteAverage;
    this._originalLanguage = originalLanguage;
    this._originalTitle = originalTitle;
    this._posterPath = posterPath;
  }

  bool get video => _video;
  String get title => _title;
  String get mediaType => _mediaType;
  String get overview => _overview;
  String get releaseDate => _releaseDate;
  double get popularity => _popularity;
  String get voteCount => _voteCount;
  bool get adult => _adult;
  String get backdropPath => _backdropPath;
  String get id => _id;
  List<int> get genreIds => _genreIds;
  double get voteAverage => _voteAverage;
  String get originalLanguage => _originalLanguage;
  String get originalTitle => _originalTitle;
  String get posterPath => _posterPath;

  KnownFor.fromJson(Map<String, dynamic> json) {
    _video = json['video'];
    _title = json['title'];
    _mediaType = json['media_type'];
    _overview = json['overview'];
    _releaseDate = json['release_date'];
    _popularity = json['popularity'];
    _voteCount = json['vote_count'].toString();
    _adult = json['adult'];
    _backdropPath = json['backdrop_path'];
    _id = json['id'].toString();
    _genreIds = json['genre_ids'].cast<int>();
    _voteAverage = json['vote_average'];
    _originalLanguage = json['original_language'];
    _originalTitle = json['original_title'];
    _posterPath = json['poster_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['video'] = this._video;
    data['title'] = this._title;
    data['media_type'] = this._mediaType;
    data['overview'] = this._overview;
    data['release_date'] = this._releaseDate;
    data['popularity'] = this._popularity;
    data['vote_count'] = this._voteCount;
    data['adult'] = this._adult;
    data['backdrop_path'] = this._backdropPath;
    data['id'] = this._id;
    data['genre_ids'] = this._genreIds;
    data['vote_average'] = this._voteAverage;
    data['original_language'] = this._originalLanguage;
    data['original_title'] = this._originalTitle;
    data['poster_path'] = this._posterPath;
    return data;
  }
}