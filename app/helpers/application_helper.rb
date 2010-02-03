# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	
	def avatar_url(user,size=nil)
		if user.avatar.file?
			user.avatar.url(size)
		else
			"/images/default_avatar.jpg"
		end
	end
	
	def display_standard_flashes(message = 'There were some problems with your submission:')
		errors 	= flash[:error] || @errors
		notice 	= (flash[:notice]) || @notice
		warning = flash[:warning] || @warning
    if notice
      flash_to_display, level = notice, 'notice'
    elsif warning
      flash_to_display, level = warning, 'warning'
    elsif errors
      level = 'error'
      if errors.instance_of? ActiveRecord::Errors
        flash_to_display = message
        flash_to_display << activerecord_error_list(errors)
      else
        flash_to_display = errors
      end
    else
      return
    end
    content_tag 'div', flash_to_display, :class => "flash #{level}"
  end

  def activerecord_error_list(errors)
    error_list = '<ul class="error_list">'
    error_list << errors.collect do |e, m|
      "<li>#{e.humanize unless e == "base"} #{m}</li>"
    end.to_s << '</ul>'
    error_list
  end
	
end
