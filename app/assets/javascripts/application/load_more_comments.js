var Append = {};
Append.open = false;
function ClickableCommentsLink(){
  $('.more-comments').click( function() {
    $(this).on('ajax:success', function(event, data, status,xhr) {
      event.preventDefault();
      var micropostId = $(this).data("micropost-id");
      $("#comments_" + micropostId).html(data);
      $("#comments-paginator-" + micropostId).html("<a id='more-comments' data-micropost-id=" + micropostId + "data-type='html' data-remote='true' href='/microposts/" + micropostId + "/comments>show morecomments</a>");
      // Append.open = true;
      // Append.comment = true; 
      // Append.link = false;  
    }); 
  });
}
// 
function DestroyComments(){
  $('.delete-comment').click( function() {
    Append.id = this;
    Append.micropost_id = $(this).data("micropost-id");
    Append.comment_count = $(this).data("value");
  }); 
}
// 
$( document ).on('turbolinks:load', function(){
  ClickableCommentsLink();
  DestroyComments();
  $('.comment_content').click (function(){
  	Append.id = this;
  	Append.micropost_id = $(this).data("micropost-id");
  	if (Append.comment_count == undefined){ Append.comment_count = $(this).data("value"); }
  	if(Append.comment_count < 4){ Append.comment = true; Append.link = false; } 
  	else if(Append.comment_count == 4){ Append.comment = false; Append.link = true; } 
  	else if(Append.comment_count > 4){ Append.comment = false; Append.link = false;  } 
  })
});
