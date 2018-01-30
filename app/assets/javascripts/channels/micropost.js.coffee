window.writeit = window.writeit or {}
((micropost_channel, $) ->
  
  micropost_channel.create_micropost_subscription = (micropost_id) ->
    if !App["micropost-#{micropost_id}"]
      App["micropost-#{micropost_id}"] = App.cable.subscriptions.create {channel: "MicropostChannel", micropost_id: micropost_id},
        
        connected: ->
          this.micropost_id = micropost_id
          # Called when the subscription is ready for use on the server

        disconnected: ->
          # Called when the subscription has been terminated by the server

        received: (data) ->
          if data["user_id"] != "" && data["user_id"] != currentUser
            @add_content(data)

        add_content: (data) ->
          switch data.notice_type
            when "like" then @notify_like(data.like)
            when "comment" then @notify_comment(data.comment, data.remove)
            when "commenting" then @notify_commenting(data.commenting)
          return
        
        someone_is_writing: (micropost_id) ->
          @perform("someone_is_writing", {micropost_id: micropost_id})
        
        notify_like: (content) ->
          if likes = $("#likes_#{content.micropost_id}")
            likes.html(content.partial)
        
        notify_comment: (content, should_remove) ->
          if comments = $("#comments_#{content.micropost_id}")
            # should_remove == false, means the user that commented removed the comment
            # so we remove it from the DOM
            if should_remove == "false"
              $("#micropost_#{content.micropost_id}_comment_#{content.partial}").remove()
            else
              comments.append(content.partial)
              $("#writing_comment_#{content.micropost_id}").html("")
        
        notify_commenting: (micropost_id) ->
          $("#writing_comment_#{micropost_id}").html("Someone is commenting...")
          
          if myTimeout == null
            myTimeout = setTimeout (->
              $("#writing_comment_#{micropost_id}").html("")
              ), 10000
    

) window.writeit.micropost_channel = window.writeit.micropost_channel or {}, jQuery
