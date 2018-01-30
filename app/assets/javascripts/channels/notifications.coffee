App.notifications = App.cable.subscriptions.create "NotificationsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    @update_counter(data.counter)
    
    if data.notice_type == "follow"
      @notify_follow(data.follow)
    
    if data.use_sound == "true"
      $("#sound-play").get(0).play()
  
  update_counter: (counter) ->
    if notifications = $("#notifications-counter")
      notifications.html("#{counter}")
      
      if counter > 0
        notifications.css('color','#FFA5A5')
      else
        notifications.css('color','white')
  
  notify_follow: (content) ->
    if $("#timeline_followers_count_#{content.user_id}").length != 0
      $("#timeline_followers_count_#{content.user_id}").html("#{content.followers_count} people following")
    
    if $("#current_user_followers_count_#{content.user_id}").length != 0
      $("#current_user_followers_count_#{content.user_id}").html(@text_displayed(content.followers_count))
      
  text_displayed: (count) ->
    return "#{count} followers" unless count == 1
    return "1 follower"
