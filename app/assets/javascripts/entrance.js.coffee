jQuery ($) ->
  $(document).ready ->
        
    window.releasePreloader = ->
      preloader.bar.animate { width: "#{preloader.progress}%" }
      if preloader.progress >= 99
        $("#preloader").fadeOut('slow')
        $('#video-embed').fadeIn('slow')
        $('#intro-video').on 'ended', ->
          onPreloadComplete()

    if $('body.public.intro').length
      # Start the show
      visualsVideo = $('#visuals').get(0)
      tl = new TimelineMax(onComplete: releasePreloader)
      tl.set('span.sep', { scale: 0.5, transformPerspective: 10, perspective: 10, transformStyle: "preserve-3d", opacity: 1, rotationX: 180, rotationY: 80, z: 20 })
      tl.to('span.icon img', 0.75, { clip: "rect(0px, 60px, 20px, 0px)", ease: Power2.easeInOut })
      tl.to('span.sep', 3, { rotationX: 0, rotationY: 0, z: 0, ease: Power0.easeNone })
      tl.staggerTo('span.stagger1', 1, { opacity: 1, ease: Circ.easeInOut }, 0.2, "-=5")
      tl.staggerTo('span.stagger2', 1, { opacity: 1, ease: Back.easeOut }, 0.2, "-=3")

      window.onPreloadComplete = ->
        tl = new TimelineMax(onComplete: visualsA)
        tl.to(preloader.bar, 0.5, { backgroundColor: '#71d053' })
        tl.to('.slide.preload', 0.2, { borderWidth: '0px' })
        tl.to(preloader.div, 1, { opacity: 0, marginTop: "100" }, "preloadEnd")
        tl.to('.slide.preload', 1, { width: '0%', ease: Expo.easeIn }, "preloadEnd")
        tl.to('.quote', 0.5, { opacity: 1, ease: Power0.easeNone }, "+=0.5")

      visualsA = ->
        unless $('body').hasClass('no-autoplay')
          visualsVideo.pause()
          visualsVideo.currentTime = 0

        tl = new TimelineMax(delay: 1, onComplete: visualsB)
        tl.to('.slide.mother .backdrop', 0.5, { opacity: 0 })
        tl.to('.slide.mother .quote', 0.5, { opacity: 0 }, '+=0.8')

      visualsB = ->
        if $('body').hasClass('no-autoplay')
          window.location.href = '/what'
        else
          visualsVideo.play()
          $('#visuals').css({ height: $(window).height() })
          tl = new TimelineMax(onComplete: clearSlideshow)
          tl.to('.slide.mother, .skip', 1, { opacity: 0 })

      clearSlideshow = ->
        $('.slide.mother, .slide.preload, a.skip').remove()
