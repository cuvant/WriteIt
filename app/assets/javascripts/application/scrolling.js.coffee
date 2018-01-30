window.writeit = window.writeit or {}
((scrolling, $) ->

  scrolling.inf = ->
    # if $('#infinite-scrolling').length > 0
    #   $(window).on 'scroll', ->
    #     more_posts_url = $('.pagination .next_page a').attr('href')
    #     if more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
    #         $('.pagination').html('<img src="/assets/ajax-loader-aebc793d0064383ee6b1625bf3bb32532ec30a5c12bf9117066107d412119123.gif" alt="Loading..." title="Loading..." />')
    #         # $('.pagination').html("#{image_tag("ajax-loader.gif")}")
    #         # $('.pagination').html("<img src=#{asset-url("assets/ajax-loader.gif", image)}")
    #         # $('.pagination').html('<img src="#{asset-url("assets/ajax-loader.gif", image)}" alt="Loading..." title="Loading..." />')
    #         $.getScript more_posts_url
    #     return
    #   return
      
    if $('#infinite-scrolling').length > 0
      $(window).on 'scroll', ->
        more_posts_url = $('#infinite-scrolling .next_page a').attr('href')
        if more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
          $('.pagination').html('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..."/>')
          console.log(more_posts_url)
          $.getScript more_posts_url, ->
        return
      return
  
) window.writeit.scrolling = window.writeit.scrolling or {}, jQuery
