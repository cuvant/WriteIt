window.writeit = window.writeit or {}
((notifications, $) ->
  
  notifications.remove_after_close = ->
    $('#notifications-dropdown').on 'hide.bs.dropdown', ->
      $(".dropdown-menu.notifications .li-notification").remove();
  
  notifications.set_counter_color = ->
    if parseInt($("#notifications-counter").html()) > 0
      $("#notifications-counter").css('color','#FFA5A5')
    else
      $("#notifications-counter").css('color','white')
    
  
) window.writeit.notifications = window.writeit.notifications or {}, jQuery
