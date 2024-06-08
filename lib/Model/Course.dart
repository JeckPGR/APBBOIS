class Course {
  final String courseId;
  final String courseType;
  final String courseDescription;
  final String courseEmail;
  final double courseLatitude;
  final double courseLongitude;
  final String courseName;
  final String coursePhoneNumber;
  final String coursePricing;
  final String courseSubdistrict;
  final double courseRating;
  final String ownerId;
  final List<String> courseOpenDays;
  final String courseImageUrl;
  final List<String> syllabi;

  Course({
    required this.courseId,
    required this.courseType,
    required this.courseDescription,
    required this.courseEmail,
    required this.courseLatitude,
    required this.courseLongitude,
    required this.courseName,
    required this.coursePhoneNumber,
    required this.coursePricing,
    required this.courseSubdistrict,
    required this.courseRating,
    required this.ownerId,
    required this.courseOpenDays,
    required this.courseImageUrl,
    required this.syllabi,
  });

  factory Course.fromMap(Map<String, dynamic> data) {
    return Course(
      courseId: data['courseId'] as String? ?? '',
      courseType: data['course_Type'] as String? ?? '',
      courseDescription: data['course_description'] as String? ?? '',
      courseEmail: data['course_email'] as String? ?? '',
      courseLatitude: (data['course_latitude'] as num?)?.toDouble() ?? 0.0,
      courseLongitude: (data['course_longitude'] as num?)?.toDouble() ?? 0.0,
      courseName: data['course_name'] as String? ?? '',
      coursePhoneNumber: data['course_phone_number'] as String? ?? '',
      coursePricing: data['course_pricing'] as String? ?? '',
      courseSubdistrict: data['course_subdistrict'] as String? ?? '',
      courseRating: (data['course_rating'] as num?)?.toDouble() ?? 0.0,
      ownerId: data['ownerId'] as String? ?? '',
      courseOpenDays: List<String>.from(data['course_open_days'] ?? []),
      courseImageUrl: data['course_image_url'] as String? ?? '',
      syllabi: List<String>.from(data['syllabi'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'courseId': courseId,
      'course_Type': courseType,
      'course_description': courseDescription,
      'course_email': courseEmail,
      'course_latitude': courseLatitude,
      'course_longitude': courseLongitude,
      'course_name': courseName,
      'course_phone_number': coursePhoneNumber,
      'course_pricing': coursePricing,
      'course_subdistrict': courseSubdistrict,
      'course_rating': courseRating,
      'ownerId': ownerId,
      'course_open_days': courseOpenDays,
      'course_image_url': courseImageUrl,
      'syllabi': syllabi,
    };
  }
}
