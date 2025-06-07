import { LightningElement, track } from 'lwc';

export default class ToDoManager extends LightningElement {
  taskName = '';
  taskDate = '';
  @track tasks = [];
  missingMessage = 'this field cannot be empty'

  handleChange(event) {
    let {name, value} = event.target;
    if(name === 'taskName'){
      this.taskName = value; 
    } else if (name === 'taskDate') {
      this.taskDate = value;
    }
  }
  addTask(){
    if (this.taskName){ // taskname is not empty
      this.tasks.push({
        taskName : this.taskName,
        taskDate : this.taskDate
      });
      console.log(this.tasks);
    } else {
      let nameElement = this.template.querySelector('lightining-input[name="taskName"]');
      this.setValidityWhenFieldsEmpty(nameElement);
    }
  }
  resetTask(){
    this.taskName = '';
    this.taskDate = '';
  }
  setValidityWhenFieldsEmpty(element){
    element.setCustomValidity(this.missingMessage);
    element.reportValidity();
    element.setCustomValidity('');
  }
}