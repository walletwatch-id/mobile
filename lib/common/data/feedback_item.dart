
class FeedbackItem {
  final String userName;
  final String userImage;
  final String feedback;
  final int rating;

  FeedbackItem({
    required this.userName,
    required this.userImage,
    required this.feedback,
    required this.rating,
  });
}

  final List<FeedbackItem> feedbackItems = [
    FeedbackItem(
      userName: 'HappyUser123',
      userImage: 'https://via.placeholder.com/150', // Replace with actual image URL
      feedback: 'The chatbot provided excellent suggestions and...',
      rating: 5,
    ),
    FeedbackItem(
      userName: 'HappyUser345',
      userImage: 'https://via.placeholder.com/150', // Replace with actual image URL
      feedback: 'Saya jadi paham tentang bagaimana selama ini...',
      rating: 5,
    ),
  ];
