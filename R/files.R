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
#' @export
get_files_list <- function(id, id_type, content_types = NULL, search_term = NULL, include = "user", only = NULL, sort = "name", order = "asc" ){
  # GET /api/v1/courses/:course_id/files
  # GET /api/v1/users/:user_id/files
  # GET /api/v1/groups/:group_id/files
  # GET /api/v1/folders/:id/files
  url <- paste0(canvas_url(), file.path(id_type, id, "files"))
  args <- list(`content_types[]` = content_types,
               search_term = search_term,
               `include[]` = include,
               `only[]` = only,
               sort = sort,
               order = order)
  args <- sc(args)
  resp <- process_response(url, args = args)
  return(resp)

}


#' @title get folder information
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
#' @export
get_folder_list <- function(id, id_type, content_types = NULL, search_term = NULL, include = "user", only = NULL, sort = "name", order = "asc" ){
  # GET /api/v1/courses/:course_id/folders
  # GET /api/v1/users/:user_id/folders
  # GET /api/v1/groups/:group_id/folders
  # GET /api/v1/folders/:id/folders
  url <- paste0(canvas_url(), file.path(id_type, id, "folders"))
  resp <- process_response(url, args = "args")
  return(resp)

}


#' @title upload a file to a folder
#' @param folder_id a valid folder id.  Can be input as numbers or characters. If a user has multiple enrollments in a context (e.g. as a teacher and a student or in multiple course sections), each enrollment will be listed separately.
#' @param file_name file name in your current directory.
#' Any UTF-8 name is allowed. Path components such as `/` and `\` will be treated as part of the filename,
#' not a path to a sub-folder.
#' @param parent_folder_id The id of the folder to store the file in.
#' If this and parent_folder_path are sent an error will be returned. If neither is given,
#' a default folder will be used.
#' @param on_duplicate How to handle duplicate filenames. If "overwrite", then this file upload will
#' overwrite any other file in the folder with the same name. If "rename", then this file will be
#' renamed if another file in the folder exists with the given name. If no parameter is given,
#' This doesn't apply to file uploads in a context that doesn't have folders.
#' @export
upload_file <- function(folder_id, file_name, parent_folder_id = NULL, on_duplicate = "overwrite"){
  #POST /api/v1/folders/:folder_id/files
  url <- paste0(canvas_url(), file.path("folders", folder_id, "files"))
  file_size <- file.info(file_name)$size
  url <- paste0(canvas_url(),
                paste("folders", folder_id, "files", sep = "/"))
  args <- sc(list(name = file_name,
                  size = file_size,
                  parent_folder_id = parent_folder_id,
                  on_duplicate = on_duplicate))
  upload_resp <- canvas_query(url, args, "POST")
  upload_content <- httr::content(upload_resp)
  upload_url <- upload_content$upload_url
  upload_params <- upload_content$upload_params
  upload_params[[length(upload_params) + 1]] <- httr::upload_file(file_name)
  names(upload_params)[[length(upload_params)]] <- "file"
  invisible(httr::POST(url = upload_url,
                       body = upload_params))
  message(sprintf("File %s uploaded", file_name))
}




