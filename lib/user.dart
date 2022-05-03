class Books {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  Books({this.count, this.next, this.previous, this.results});

  Books.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        List v1 = v['authors'];
        if (v1.isNotEmpty) {
          results!.add(Results.fromJson(v));
      
        }

        
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  String? title;
  List<Authors>? authors;

  List<String>? subjects;
  List<String>? bookshelves;
  List<String>? languages;
  bool? copyright;
  String? mediaType;
  Formats? formats;
  int? downloadCount;

  Results(
      {this.id,
      this.title,
      this.authors,
      this.subjects,
      this.bookshelves,
      this.languages,
      this.copyright,
      this.mediaType,
      this.formats,
      this.downloadCount});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['authors'] != null) {
      authors = <Authors>[];
      json['authors'].forEach((v) {
        authors!.add(new Authors.fromJson(v));
      });
    }

    subjects = json['subjects'].cast<String>();
    bookshelves = json['bookshelves'].cast<String>();
    languages = json['languages'].cast<String>();
    copyright = json['copyright'];
    mediaType = json['media_type'];
    formats =
        json['formats'] != null ? Formats.fromJson(json['formats']) : null;
    downloadCount = json['download_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.authors != null) {
      data['authors'] = this.authors!.map((v) => v.toJson()).toList();
    }

    data['subjects'] = this.subjects;
    data['bookshelves'] = this.bookshelves;
    data['languages'] = this.languages;
    data['copyright'] = this.copyright;
    data['media_type'] = this.mediaType;
    if (this.formats != null) {
      data['formats'] = this.formats!.toJson();
    }
    data['download_count'] = this.downloadCount;
    return data;
  }
}

class Authors {
  String? name;
  int? birthYear;
  int? deathYear;

  Authors({this.name, this.birthYear, this.deathYear});

  Authors.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    birthYear = json['birth_year'];
    deathYear = json['death_year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['birth_year'] = birthYear;
    data['death_year'] = this.deathYear;
    return data;
  }
}

class Formats {
  String? applicationEpubZip;
  String? applicationRdfXml;
  String? applicationXMobipocketEbook;
  String? applicationZip;
  String? imageJpeg;
  String? textPlainCharsetUtf8;
  String? textHtmlCharsetUtf8;
  String? textHtml;
  String? textPlainCharsetUsAscii;
  String? applicationOctetStream;
  String? textPlain;
  String? textHtmlCharsetUsAscii;
  String? textHtmlCharsetIso88591;
  String? applicationPdf;
  String? textPlainCharsetIso88591;

  Formats(
      {this.applicationEpubZip,
      this.applicationRdfXml,
      this.applicationXMobipocketEbook,
      this.applicationZip,
      this.imageJpeg,
      this.textPlainCharsetUtf8,
      this.textHtmlCharsetUtf8,
      this.textHtml,
      this.textPlainCharsetUsAscii,
      this.applicationOctetStream,
      this.textPlain,
      this.textHtmlCharsetUsAscii,
      this.textHtmlCharsetIso88591,
      this.applicationPdf,
      this.textPlainCharsetIso88591});

  Formats.fromJson(Map<String, dynamic> json) {
    applicationEpubZip = json['application/epub+zip'];
    applicationRdfXml = json['application/rdf+xml'];
    applicationXMobipocketEbook = json['application/x-mobipocket-ebook'];
    applicationZip = json['application/zip'];
    imageJpeg = json['image/jpeg'];
    textPlainCharsetUtf8 = json['text/plain; charset=utf-8'];
    textHtmlCharsetUtf8 = json['text/html; charset=utf-8'];
    textHtml = json['text/html'];
    textPlainCharsetUsAscii = json['text/plain; charset=us-ascii'];
    applicationOctetStream = json['application/octet-stream'];
    textPlain = json['text/plain'];
    textHtmlCharsetUsAscii = json['text/html; charset=us-ascii'];
    textHtmlCharsetIso88591 = json['text/html; charset=iso-8859-1'];
    applicationPdf = json['application/pdf'];
    textPlainCharsetIso88591 = json['text/plain; charset=iso-8859-1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['application/epub+zip'] = this.applicationEpubZip;
    data['application/rdf+xml'] = this.applicationRdfXml;
    data['application/x-mobipocket-ebook'] = this.applicationXMobipocketEbook;
    data['application/zip'] = this.applicationZip;
    data['image/jpeg'] = this.imageJpeg;
    data['text/plain; charset=utf-8'] = this.textPlainCharsetUtf8;
    data['text/html; charset=utf-8'] = this.textHtmlCharsetUtf8;
    data['text/html'] = this.textHtml;
    data['text/plain; charset=us-ascii'] = this.textPlainCharsetUsAscii;
    data['application/octet-stream'] = this.applicationOctetStream;
    data['text/plain'] = this.textPlain;
    data['text/html; charset=us-ascii'] = this.textHtmlCharsetUsAscii;
    data['text/html; charset=iso-8859-1'] = this.textHtmlCharsetIso88591;
    data['application/pdf'] = this.applicationPdf;
    data['text/plain; charset=iso-8859-1'] = this.textPlainCharsetIso88591;
    return data;
  }
}
