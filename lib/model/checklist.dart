class Checklist {
  final String id, name, items;
  final bool checkListStatus;

  Checklist({
    required this.checkListStatus,
    required this.id,
    required this.items,
    required this.name,
  });

  factory Checklist.getChecklist(Map<String, dynamic> singleData) {
    return Checklist(
        checkListStatus: singleData['checklistCompletionStatus'],
        id: singleData['id'].toString(),
        items: singleData['items'],
        name: singleData['name']);
  }

  static List<Checklist> getAllCheckList(List<dynamic> data) {
    final listOfChecklist = <Checklist>[];

    for (var item in data) {
      listOfChecklist.add(Checklist.getChecklist(item));
    }

    return listOfChecklist;
  }
}
