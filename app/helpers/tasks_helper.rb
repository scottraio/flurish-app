module TasksHelper
  
  def priority_in_words(priority)
    case
      when priority == 0; "low"
      when priority == 1; "medium"
      when priority == 2; "high"
    end
  end
  
  def task_icon(priority)
    case
      when priority == 1; "task_medium.png"
      when priority == 2; "task_high.png"
      else "task.png"
    end
  end
  
  def due_date(date)
    date.nil? ? "None" : date.strftime("%m/%d/%Y") 

  end
  
end
