# https://canvas.instructure.com/doc/api/conversations.html
#

create_conversation <- function(course_id, recipient, message_title, message, attachment_id, group_conversation = FALSE){
  # POST /api/v1/conversations



  url <- paste0(canvas_url(), file.path("courses", course_id, "pages"))
  args <- sc(list(`recipients[]` = recipient,
                  `wiki_page[body]` = body,
                   subject = message_title,
                   body = message,
                  group_conversation = group_conversation,
                  `attachment_ids[]` = attachment_id,
  ))
  # resp <- httr::POST(url = url,
  #                    httr::user_agent("rcanvas - https://github.com/daranzolin/rcanvas"),
  #                    httr::add_headers(Authorization = paste("Bearer", rcanvas:::check_token())),
  #                    body = args)
  resp <- canvas_query(url, args, "POST")

  httr::stop_for_status(resp)
  message(sprintf("Page '%s' created", title))
  return(resp)

}
