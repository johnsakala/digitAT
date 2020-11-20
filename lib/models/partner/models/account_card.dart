class PatientCard{
  
  bool attended;
   String name;
   String id;
   String taskId;
   String date;
   String hour;
   String confirmed;
   String paid;

   PatientCard(this.date,this.name,this.attended,this.hour,this.id, this.confirmed, this.taskId);
   PatientCard.home(this.date,this.name,this.attended,this.hour,this.id, this.confirmed, this.taskId, this.paid);
}