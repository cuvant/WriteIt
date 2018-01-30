window.writeit = window.writeit or {}
((shared, $) ->

  shared.init = (scrollTo) ->
    shared.initFlashNotice(5)

  shared.initFlashNotice = (display_for_seconds) ->
      if $('.flash-container').length != 0

        setTimeout ->
          $('.flash-container').slideUp()


      $(document).on 'click', '.close', ->
        $('.flash-container').hide()

  $(document).ready ->
    $('.flash-container').fadeOut(7000)

) window.writeit.shared = window.writeit.shared or {}, jQuery
