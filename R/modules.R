# https://canvas.instructure.com/doc/api/modules.html

# "items": Return module items inline if possible. This parameter suggests that Canvas return module items directly in the Module object JSON, to avoid having to make separate API requests for each module when enumerating modules and items. Canvas is free to omit 'items' for any particular module if it deems them too numerous to return inline. Callers must be prepared to use the List Module Items API if items are not returned.
# 
# "content_details": Requires include. Returns additional details with module items specific to their associated content items. Includes standard lock information for each item.
# 
# Allowed values:
#   items, content_details


get_module_list <- function(){
  #GET /api/v1/courses/:course_id/modules
  #parameters
    # include[]		  string	
    #search_term		string	The partial name of the modules (and module items, if include is specified) to match and return.
    #student_id		  string	Returns module completion information for the student with this id.
} 

get_module_one <- function(){
  #GET /api/v1/courses/:course_id/modules/:id
  # include[]		  string	
  # student_id		  string	Returns module completion information for the student with this id
}

create_module <- function(){
  #POST /api/v1/courses/:course_id/modules
  # module[name]        string	  The name of the module
  # module[unlock_at]		DateTime	The date the module will unlock
  # module[position]		integer	  The position of this module in the course (1-based)
  # module[require_sequential_progress]		boolean	  Whether module items must be unlocked in order
  # module[prerequisite_module_ids][]		  string	  IDs of Modules that must be completed before this one is unlocked. Prerequisite modules must precede this module (i.e. have a lower position value), otherwise they will be ignored
  # module[publish_final_grade]		        boolean	  Whether to publish the student's final grade for the course upon completion of this module.
}

update_module <- function(){
  # PUT /api/v1/courses/:course_id/modules/:id
  # module[name]        string	  The name of the module
  # module[unlock_at]		DateTime	The date the module will unlock
  # module[position]		integer	  The position of this module in the course (1-based)
  # module[require_sequential_progress]		boolean	  Whether module items must be unlocked in order
  # module[prerequisite_module_ids][]		  string	  IDs of Modules that must be completed before this one is unlocked. Prerequisite modules must precede this module (i.e. have a lower position value), otherwise they will be ignored
  # module[publish_final_grade]		        boolean	  Whether to publish the student's final grade for the course upon completion of this module.
  # module[published]		boolean	  Whether the module is published and visible to students
  
}


delete_module <- function(){
 # DELETE /api/v1/courses/:course_id/modules/:id
  
}

#########
# Re-lock module progressions PUT /api/v1/courses/:course_id/modules/:id/relock
# Resets module progressions to their default locked state and recalculates them based on the current requirements.
# Adding progression requirements to an active course will not lock students out of modules they have already unlocked unless this action is called.
###########

 


