class ApiResponse {
  final List<Content> content;
  final Pageable pageable;
  final int totalPages;
  final int totalElements;
  final bool last;
  final int size;
  final int number;
  final Sort sort;
  final int numberOfElements;
  final bool first;
  final bool empty;

  ApiResponse({
    required this.content,
    required this.pageable,
    required this.totalPages,
    required this.totalElements,
    required this.last,
    required this.size,
    required this.number,
    required this.sort,
    required this.numberOfElements,
    required this.first,
    required this.empty,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      content:
      (json['content'] as List).map((item) => Content.fromJson(item)).toList(),
      pageable: Pageable.fromJson(json['pageable']),
      totalPages: json['totalPages'],
      totalElements: json['totalElements'],
      last: json['last'],
      size: json['size'],
      number: json['number'],
      sort: Sort.fromJson(json['sort']),
      numberOfElements: json['numberOfElements'],
      first: json['first'],
      empty: json['empty'],
    );
  }
}

class Content {
  final int id;
  final String name;
  final String url;
  final String status;
  final BookedUser? bookedUser;
  final int folderId;
  final dynamic tracingResponses;

  Content({
    required this.id,
    required this.name,
    required this.url,
    required this.status,
    this.bookedUser,
    required this.folderId,
    this.tracingResponses,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      status: json['status'],
      bookedUser: json['bookedUser'] != null
          ? BookedUser.fromJson(json['bookedUser'])
          : null,
      folderId: json['folderId'],
      tracingResponses: json['tracingResponses'],
    );
  }
}

class BookedUser {
  final int id;
  final String fullname;
  final String email;
  final String role;

  BookedUser({
    required this.id,
    required this.fullname,
    required this.email,
    required this.role,
  });

  factory BookedUser.fromJson(Map<String, dynamic> json) {
    return BookedUser(
      id: json['id'],
      fullname: json['fullname'],
      email: json['email'],
      role: json['role'],
    );
  }
}

class Pageable {
  final int pageNumber;
  final int pageSize;
  final Sort sort;
  final int offset;
  final bool paged;
  final bool unpaged;

  Pageable({
    required this.pageNumber,
    required this.pageSize,
    required this.sort,
    required this.offset,
    required this.paged,
    required this.unpaged,
  });

  factory Pageable.fromJson(Map<String, dynamic> json) {
    return Pageable(
      pageNumber: json['pageNumber'],
      pageSize: json['pageSize'],
      sort: Sort.fromJson(json['sort']),
      offset: json['offset'],
      paged: json['paged'],
      unpaged: json['unpaged'],
    );
  }
}

class Sort {
  final bool sorted;
  final bool empty;
  final bool unsorted;

  Sort({
    required this.sorted,
    required this.empty,
    required this.unsorted,
  });

  factory Sort.fromJson(Map<String, dynamic> json) {
    return Sort(
      sorted: json['sorted'],
      empty: json['empty'],
      unsorted: json['unsorted'],
    );
  }
}