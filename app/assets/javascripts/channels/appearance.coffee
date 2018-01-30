App.appearance = App.cable.subscriptions.create "AppearanceChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    switch data.status
      when "online" then @set_online(data.user)
      when "offline" then @set_offline(data.user)
  
  set_online: (user) ->
    if user != null && $("#online_user_#{user.user_id}").length == 0
      online_ul = $(".online-users")
      
      if online_ul.children('li').length == 0
        $("#online-title").html("Online followings")
        $("#online-title").removeClass("title-offline").addClass("title-online");
        
      online_ul.append(user.content)
      
    
      
  
  set_offline: (user) ->
    if user != null && $("#online_user_#{user.user_id}").length > 0
      online_ul = $(".online-users")
      $("#online_user_#{user.user_id}").remove()
      
      if online_ul.children('li').length == 0
        $("#online-title").html("All following offline")
        $("#online-title").removeClass("title-online").addClass("title-offline");
