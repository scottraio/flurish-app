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
    date.nil? ? "N/A" : date.strftime("%m/%d/%Y") 
  end
  
  def pickable?(element,task)
    task.assigned_to.nil? ? (link_to "Pick up", pickup_topic_element_task_path(@topic,element,task), :class => "metal right remote", :rel => "#topic_tasks") : "<div class='grabbed_by'><small>grabbed by:</small>#{task.delegate.first_name + " " + task.delegate.last_name}</div>"
  end
  
end
