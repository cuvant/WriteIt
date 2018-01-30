# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# $(document).ready ->
#   $('.show_map').click (e) ->
#     e.preventDefault()
#     $(this).parent().parent().find('.map').toggle()
#     return
#   return
# 
# $(document).ready ->
#   $('.more-comments').click ->
#     $(this).on 'ajax:success', (event, data, status, xhr) ->
#       micropostId = $(this).data('micropost-id')
#       $('#comments_' + micropostId).html data
#       $('#comments-paginator-' + micropostId).html '<a id=\'more-comments\' data-micropost-id=' + micropostId + 'data-type=\'html\' data-remote=\'true\' href=\'/microposts/' + micropostId + '/comments>show more comments</a>'
#       return
#     return
#   return
window.writeit = window.writeit or {}
((microposts, $) ->
  microposts.show_map = ->
    $('.show_map').click (e) ->
      e.preventDefault()
      $(this).parent().parent().find('.map').toggle()
      return
    return
  
  microposts.use_mentioner = (user_id) ->
    $(".comment_content").on "input", ->
      # Get the comment text
      $text = $(@).val()
      # Get the micropost_id from the comment_content id
      micropost_id = $(@).attr('id').split('_').pop()
      App["micropost-#{micropost_id}"].someone_is_writing({micropost_id: micropost_id})
      # Do Ajax for getting names only if the last 2 characters when typing are '@' or ' @'
      if $text.substr($text.length - 2) == "@" || $text.substr($text.length - 2) == " @"
        $.ajax
          type: 'get'
          dataType: 'json'
          url: "users/#{user_id}/get_following"
          
          success: (data) ->
            # On success show names
            data = data
            $("#comment_content_#{micropost_id}").atwho({at:"@", 'data':data})
        console.log("users/#{user_id}/get_following")
    return


  
) window.writeit.microposts = window.writeit.microposts or {}, jQuery
