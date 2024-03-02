class TodoList{
  String? title;
  String? text;
  String? time;
  String? date;
  bool? isCheck;

  TodoList();

  Map<String,dynamic> toJson() => {'Title':title,'Description':text,'Time':time,'Date':date,'isChecked':isCheck};

  TodoList.fromSnapshot(snapshot):
        title = snapshot.data()['Title'],
        text = snapshot.data()['Description'],
        time = snapshot.data()['Time'],
        date = snapshot.data()['Date'],
        isCheck = snapshot.data()['isChecked'];
}
