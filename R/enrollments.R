# https://canvas.instructure.com/doc/api/enrollments.html#method.enrollments_api.show

#' @title get enrollments
#' @description This function pull enrollment information. Depending on the `id_type` given, return a paginated list of either (1) all of the enrollments in a course, (2) all of the enrollments in a section or (3) all of a user's enrollments. This includes student, teacher, TA, and observer enrollments. note: Currently, only a root level admin user can return other users' enrollments. A user can, however, return his/her own enrollments.
#' @param id can be one of course, section, or user id.  Can be input as numbers or characters. If a user has multiple enrollments in a context (e.g. as a teacher and a student or in multiple course sections), each enrollment will be listed separately.
#' @param id_type the type id being used.  Can be 'courses', 'sections', or 'users'. Defaults to 'courses'.
#' @param enrollment_type a string or list of strings the defines the enrollment types to return. Accepted values are 'StudentEnrollment', 'TeacherEnrollment', 'TaEnrollment', 'DesignerEnrollment', and 'ObserverEnrollment.' If omitted, all enrollment types are returned. This argument is ignored if `role` is given.
#' @param role a string or list of strings that specifies enrollment roles to return. Accepted values include course-level roles created by the Add Role API as well as the base enrollment types accepted by the `type` argument above.
#' @param state a string.  Filter by enrollment state. If omitted, 'active' and 'invited' enrollments are returned. When querying a user's enrollments (either via user_id argument or via user enrollments endpoint), the following additional synthetic states are supported: “current_and_invited”|“current_and_future”|“current_and_concluded” Allowed values include; 'active', 'invited', 'creation_pending', 'deleted', 'rejected', 'completed', 'inactive'.
#' @param include a string or array of strings. Array of additional information to include on the enrollment or user records. “avatar_url” and “group_ids” will be returned on the user record. Allowed values include: 'avatar_url', 'group_ids', 'locked', 'observed_users', 'can_be_removed'.
#' @param user_id a string. Filter by user_id (only valid for course or section enrollment queries). If set to the current user's id, this is a way to determine if the user has any enrollments in the course or section, independent of whether the user has permission to view other people on the roster.
#' @param grading_period_id an	integer. Return grades for the given grading_period. If this parameter is not specified, the returned grades will be for the whole course.
#' @param enrollment_term_id an integer. Returns only enrollments for the specified enrollment term. This parameter only applies to the user enrollments path. May pass the ID from the enrollment terms api or the SIS id prepended with 'sis_term_id:'.
#' @param sis_account_id a string. Returns only enrollments for the specified SIS account ID(s). Does not look into sub_accounts. May pass in array or string.
#' @param sis_course_id a string. Returns only enrollments matching the specified SIS course ID(s). May pass in array or string.
#' @param sis_section_id a string. Returns only section enrollments matching the specified SIS section ID(s). May pass in array or string.
#' @param sis_user_id a string. Returns only enrollments for the specified SIS user ID(s). May pass in array or string.
#' @export
get_enrollments_list <- function(id, id_type = "courses", enrollment_type = 'StudentEnrollment', state = 'active', role = NULL, include = NULL,
                                 user_id = NULL, grading_period_id = NULL, enrollment_term_id = NULL, sis_account_id = NULL,
                                 sis_course_id = NULL, sis_section_id = NULL, sis_user_id = NULL){
  #GET /api/v1/courses/:course_id/enrollments
  #GET /api/v1/sections/:section_id/enrollments
  #GET /api/v1/users/:user_id/enrollments
  url <- paste0(canvas_url(), file.path(id_type, id, "enrollments"))
  args <- list(`type[]` = enrollment_type,
                  `role[]` = role,
                  `state[]` = state,
                  `include[]` = include,
                   user_id = user_id,
                   grading_period_id = grading_period_id,
                  enrollment_term_id = enrollment_term_id,
                  `sis_account_id[]` = sis_account_id,
                  `sis_course_id[]` = sis_course_id,
                  `sis_section_id[]` = sis_section_id,
                  `sis_user_id[]` = sis_user_id)
  args <- sc(args)
  resp <- process_response(url, args = args)
  return(resp)




user_id
grading_period_id
enrollment_term_id
sis_account_id[]
sis_course_id[]
sis_section_id[]
sis_user_id[]
}

