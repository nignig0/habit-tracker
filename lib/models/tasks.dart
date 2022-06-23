//for now just handling normal tasks 

class Task {

  late String id;
  late String name;
  late String description;
  late DateTime endTime;
  late bool done;

  Task(this.id, this.name, this.description, this.endTime);

   Task.fromFirebaseDoc(var firebaseDoc){
     
    id = firebaseDoc.id;
    name = firebaseDoc['name'];
    description = firebaseDoc['description'];
    endTime = firebaseDoc['endTime'].toDate();
    done = firebaseDoc['done'];

  }

}

