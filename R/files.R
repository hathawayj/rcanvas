# Files API - https://canvas.instructure.com/doc/api/files.htmlf
#


#' @title get file information
#' @description This function pull enrollment information. Depending on the `id_type` given, return a paginated list of either (1) all of the enrollments in a course, (2) all of the enrollments in a section or (3) all of a user's enrollments. This includes student, teacher, TA, and observer enrollments. note: Currently, only a root level admin user can return other users' enrollments. A user can, however, return his/her own enrollments.
#' @param id can be one of course, section, or user id.  Can be input as numbers or characters. If a user has multiple enrollments in a context (e.g. as a teacher and a student or in multiple course sections), each enrollment will be listed separately.
#' @param id_type the type id being used.  Can be 'courses', 'sections', or 'users'. Defaults to 'courses'.
#'
#' @param content_types a	string. Filter results by content-type. You can specify type/subtype pairs (e.g., 'image/jpeg'), or simply types (e.g., 'image', which will match 'image/gif', 'image/jpeg', etc.).
#' @param search_term a string. The partial name of the files to match and return.
#' @param include a string. Array of additional information to include. “user” the user who uploaded the file or last edited its content. “usage_rights” copyright and license information for the file (see UsageRights). Allowed values: user
#' @param only an Array. Array of information to restrict to. Overrides include. “names” only returns file name information.
#' @param sort a string. Sort results by this field. Defaults to 'name'. Note that `sort=user` implies `include[]=user`. Allowed values:   name, size, created_at, updated_at, content_type, user
#' @param order a	string. The sorting order. Defaults to 'asc'. Allowed values: asc, desc.
#'
get_files_list <- function(id, id_type, ){
  # GET /api/v1/courses/:course_id/files
  # GET /api/v1/users/:user_id/files
  # GET /api/v1/groups/:group_id/files
  # GET /api/v1/folders/:id/files
  content_types[]
  search_term
  include[]
  only[]


}
