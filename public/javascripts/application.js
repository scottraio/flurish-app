// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function init() {
	$('[rel*=facebox]').unbind('click').facebox();
	$("div.item div.details").ellipsis();
	$("div.notice").fadeOut(3000);

	$("a.remote").unbind('click').bind('click', function() { 
	  if(this.rel) $(this.rel).load(this.href); 
	  else $.get(this.href); 
	  return false; 
	});
}
	
