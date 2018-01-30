App.newest_micropost = App.cable.subscriptions.create "NewestMicropostChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    if data.step == "first"
      $("#my-microposts").prepend(data.micropost)
      
      # if data["user_id"] != "" && data["user_id"] != currentUser
        # @perform("set_image", {micropost_id: data.micropost_id})
    
    # else if data.step == "second"
      # $('set_image')
    # Called when there's incoming data on the websocket for this channel
