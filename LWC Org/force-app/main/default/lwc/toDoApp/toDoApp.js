import { LightningElement,track } from 'lwc';

export default class ToDoApp extends LightningElement {
    taskName ;
    taskDate = null;
    @track actionItemTasks = [];
    completedTasks = [];

    handleChange(event){
        let {name,value} = event.target;
        if(name === 'taskName'){
            this.taskName = value;
        } else if (name === 'taskDate'){
            this.taskDate = value;
        }
    }

    handleClick(event){
        let {name} = event.target;
        if(this.validateTask ()){ // create task
            if(this.taskName){ //if task valid
                let taskObj = {};
                taskObj.taskName = this.taskName;
                if(!this.taskDate){ // if date is not set, assume today's date for the task
                    let today = new Date();
                    taskObj.Date = today.toISOString();
                }else{
                    taskObj.Date = this.taskDate;
                }
                taskObj.id = this.uuidGenerator();
                this.actionItemTasks.push(taskObj);
                this.taskName = ``;
                this.taskDate = null;
                console.log(this.taskDate);
            }
        }//end of create task loop
        else if (name === 'resetTask'){// reset task
            this.taskDate = null;
            this.taskName = ``;
        }// end of reset task loop
        let sortedTasks = this.sortTasksByDate(this.actionItemTasks);
        this.actionItemTasks = [...sortedTasks];
        // console.log('Sorted tasks: ',this.actionItemTasks);
    }

    handleDeleteTask(event){
        // remove the task from Action item list
        let {name:taskIndex} = event.target;
        this.actionItemTasks.splice(taskIndex,1);
    }

    handleCompleteTask(event){
        // remove the task from ActionItem list
        console.log('clicked the complete button');
        let {name:taskIndex} = event.target;
        let removedTask = this.actionItemTasks[taskIndex];
        this.actionItemTasks.splice(taskIndex,1);
        console.log(removedTask);
        // add the task to completed list
        this.completedTasks.push(removedTask);
        console.log(this.completedTasks);
    }

    validateTask (){
        let isValidTask = false;
        let inputTaskElement = this.template.querySelector('.inputTask');
        let duplicateTask = this.actionItemTasks.find(task => task.taskName === this.taskName && task.Date === this.taskDate);
        if(!this.taskName){
            inputTaskElement.setCustomValidity('Cannot create a task without task name!');
        }else if (this.taskName && !duplicateTask){
            isValidTask = true;
        }

        // console.log(this.actionItemTasks.find(task => task.taskName === this.taskName && task.taskDate === this.taskDate));
        if(isValidTask){
            // console.log('inside valid task');
            inputTaskElement.setCustomValidity('');
        }else if(duplicateTask){
            // console.log('inside duplicate task');
            inputTaskElement.setCustomValidity('Cannot add duplicate tasks');
        }
        inputTaskElement.reportValidity();
        return isValidTask;
    }

    sortTasksByDate(inpArray){
        inpArray.sort((task1,task2) =>{
            let task1date = new Date(task1.Date);
            let task2date = new Date(task2.Date);
            return task1date - task2date;
        });
        return inpArray;
    }

    uuidGenerator(){
        return `${Date.now()}-${Math.random()*2}`;
    }
    
}