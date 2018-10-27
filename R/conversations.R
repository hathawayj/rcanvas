# https://canvas.instructure.com/doc/api/conversations.html
#

#' @param recipients Required	string. An array of recipient ids. These may be user ids or course/group ids prefixed with “course_” or “group_” respectively, e.g. recipients[]=1&recipients=2&recipients[]=course_3.
#' @param message_title a string. The subject of the conversation. This is ignored when reusing a conversation. Maximum length is 255 characters.
#' @param message a Required	string. The message to be sent
#' @param group_conversation a boolean. Defaults to false. If true, this will be a group conversation (i.e. all recipients may see all messages and replies). If false, individual private conversations will be started with each recipient. Must be set false if the number of recipients is over the set maximum (default is 100).
#' @param attachment_ids a string. An array of attachments ids. These must be files that have been previously uploaded to the sender's “conversation attachments” folder.
# #' @param media_comment_id a string. Media comment id of an audio of video file to be associated with this message.
# #' @param media_comment_type a string. Type of the associated media file. Allowed values: 'audio', 'video'.
# #' @param user_note a boolean. Will add a faculty journal entry for each recipient as long as the user making the api call has permission, the recipient is a student and faculty journals are enabled in the account.
# #' @param mode a string. Determines whether the messages will be created/sent synchronously or asynchronously. Defaults to sync, and this option is ignored if this is a group conversation or there is just one recipient (i.e. it must be a bulk private message). When sent async, the response will be an empty array (batch status can be queried via the batches API). Allowed values: 'sync', 'async'.
# #' @param scope a string. Used when generating “visible” in the API response. See the explanation under the index API action. Allowed values: unread, starred, archived
# #' @param filter a string. Used when generating “visible” in the API response. See the explanation under the index API action
# #' @param filter_mode a string. Used when generating “visible” in the API response. See the explanation under the index API action. Allowed values: and, or, default or
# #' @param context_code a string. The course or group that is the context for this conversation. Same format as courses or groups in the recipients argument.

create_conversation <- function(course_id, recipient, message_title, message, attachment_id, group_conversation = TRUE, bulk_message = TRUE){
  # POST /api/v1/conversations
  url <- paste0(canvas_url(), file.path("conversations"))
  args <- sc(list(`recipients[]` = recipient,
                   subject = message_title,
                   body = message,
                  group_conversation = group_conversation,
                  bulk_message = bulk_message,
                  `attachment_ids[]` = attachment_id
  ))
  resp <- canvas_query(url, args, "POST")
  httr::stop_for_status(resp)
  return("finished")
}



