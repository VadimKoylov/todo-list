enum CompletedStatus { all, activity, completed }

extension XCompletedStatus on CompletedStatus {
  bool get isAll => this == CompletedStatus.all;

  bool get isActivity => this == CompletedStatus.activity;

  bool get isCompleted => this == CompletedStatus.completed;
}
