# https://canvas.instructure.com/doc/api/quizzes.html


#' Get data frame of quizes in course
#'
#' @param course_id a valid course id
#' @param search a string. The partial title of the pages to match and return. Defaults to `""` or a blank search
#'
#' @return a data.frame with all pages from course.
#' @export
#'
get_quiz_list <- function(course_id, search = ""){
  # GET /api/v1/courses/:course_id/quizzes
  url <- paste0(canvas_url(), file.path("courses", course_id, "quizzes"))
    args <- list(search_term = search)
    args <- sc(args)
    resp <- process_response(url, args = args)
    return(resp)
}


#' Get data frame of a quiz in course
#'
#' @param course_id a valid course id
#' @param quiz_id a valid quiz id.
#'
#' @return a tibble with variables specified for the quiz
#' @export
get_quiz <- function(course_id, quiz_id){
  # GET /api/v1/courses/:course_id/quizzes/:id
  url <- paste0(canvas_url(), file.path("courses", course_id, "quizzes", quiz_id))
  resp <- process_response(url, args = "")
  return(resp)
}


#' Get data frame of a quiz reports for a quiz in course
#'
#' @param course_id a valid course id
#' @param quiz_id a valid quiz id.
#' @param include_all (boolean) Whether to retrieve reports that consider all the submissions or only the most recent. Defaults to false, ignored for item_analysis reports.
#'
#' @return a tibble with variables specified for the quiz
#' @export
get_quiz_reports <- function(course_id, quiz_id, include_all = TRUE){
  # GET /api/v1/courses/:course_id/quizzes/:id
  url <- paste0(canvas_url(), file.path("courses", course_id, "quizzes", quiz_id, "reports"))
  args <- list(includes_all_versions = include_all)
  args <- sc(args)
  resp <- process_response(url, args = args)
  return(resp)
}


#' Get data frame of a quiz reports for a quiz in course
#'
#' @param course_id a valid course id
#' @param quiz_id a valid quiz id.
#' @param report_id a valid report id.
#' @param include Type is string. Whether the output should include documents for the file and/or progress objects associated with this report. (Note: JSON-API only). Allowed values are `file` and `progress`.
#'
#' @return a tibble with variables specified for the quiz
#' @export
get_quiz_report <- function(course_id, quiz_id, report_id, include = "file"){
  # GET /api/v1/courses/:course_id/quizzes/:quiz_id/reports/:id
  url <- paste0(canvas_url(), file.path("courses", course_id, "quizzes", quiz_id, "reports", report_id))
  args <- list(include = include)
  args <- sc(args)
  resp <- canvas_query(url, args, "GET")
  df <- paginate(resp) %>%
    purrr::map(httr::content, "text") %>%
    purrr::map(jsonlite::fromJSON, flatten = TRUE) %>%
    .[[1]]
  dat <- read_csv(df$file$url)
  return(dat)

}

create_quiz_report <- function(course_id, quiz_id, report_type = c("student_analysis", "item_analysis")[1],
                               include_all = FALSE, include_file = "file"){
  # POST /api/v1/courses/:course_id/quizzes/:quiz_id/reports
  url <- paste0(canvas_url(), file.path("courses", course_id, "quizzes", quiz_id, "reports"))
  args <- list(`quiz_report[report_type]` = report_type,
               `quiz_report[includes_all_versions]` = include_all,
               include = include_file)
  args <- sc(args)
  resp <- canvas_query(url, args, "POST")
  resp
}

get_quiz_reports <- function(course_id, quiz_id, include_all = TRUE){
  # GET /api/v1/courses/:course_id/quizzes/:id
  url <- paste0(canvas_url(), file.path("courses", course_id, "quizzes", quiz_id, "reports"))
  args <- list(includes_all_versions = include_all)
  args <- sc(args)
  resp <- process_response(url, args = args)
  return(resp)
}
