jQuery ($) ->
  $(document).ready ->

    unless $('body').hasClass('facts')
      $('[data-imgliquid]').imgLiquid
        horizontalAlign: 'center'
        verticalAlign: 'center'

    $('[data-vertical]').each ->
      $(this).css({ marginTop: ($(window).height() - $(this).height()) / 2 })

    # Framework maps
    highlight = (key) ->
      TweenLite.to(".wheel span.#{key} a", 0.5, { color: '#e8a20b' })

    delight = (key) ->
      TweenLite.to(".wheel span.#{key} a", 0.5, { color: '#000' })

    $('area').hover(
      -> ( highlight $(this).attr('data-key') ),
      -> ( delight   $(this).attr('data-key') )
    )

    positionWheel = ->
      offset = $('.wheel img').offset().left
      if offset > 0
        $('.wheel').css({ marginRight: offset })
      $('.wheel').animate({ opacity: 1 })

    if $('.wheel').length
      $(window).load -> positionWheel()

    # Datepickers
    $('[data-date]').each ->
      $(this).datepicker
        dateFormat: 'yy-mm-dd'

    # Splash headers
    sizeSplash = ->
      height = $(window).height() - $('header:visible').outerHeight()
      height = (height / 10) * 7
      (height = 450) if height > 450
      $('.splash').css({ height: "#{height}px" })

    if $('.splash').length && !$('body').hasClass('facts')
      $(window).load -> sizeSplash()
      $(window).resize -> sizeSplash()

    # Team Members Modals
    showTeamMember = (elem) ->
      id      = elem.attr('data-id')
      picture = $(".team-member[data-id=#{id}]")
      $(".team-member-overlay.#{id}").foundation('reveal', 'open')

    hideTeamMember = (elem) ->
      id = elem.attr('data-id')
      $(".team-member-overlay.#{id}").fadeOut()

    $('.team-member').click (e) ->
      showTeamMember $(this)

    # Video player modal
    $('.play-video').click (e) ->
      e.preventDefault()
      $('.video-popup').foundation('reveal', 'open')
      $('.slide.visuals').css({"z-index": '0'})
      $('.video-popup').find('video').get(0).play()

    $('.play-video-direct').click (e) ->
      e.preventDefault()
      $('.video-popup').find('video').show().get(0).play()

    # All modals
    $('.close-modal').click (e) ->
      $(this).closest('.reveal-modal').foundation('reveal', 'close')