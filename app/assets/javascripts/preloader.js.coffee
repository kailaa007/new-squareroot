jQuery ($) ->
  $(document).ready ->

    if $('body.public.intro').length

      # Setup
      window.preloader = {
        div: $('.slide.preload .body')
        progress: 0
        videos: []
        released: false
      }
      preloader.bar = preloader.div.find('.progress')

      # Position the loader. Change value from 70 to the height of the preload div.
      preloader.div.css({ marginTop: ($(window).height() - 100) / 2 }).fadeIn()

      updatePreloader = (i) ->
        return if i <= 0 # video will often submit 0 as buffering
        preloader.progress += i

        if preloader.released
          releasePreloader()

      videoWatcher = 0
      videoWatchI  = 0

      checkVideoLoads = ->
        videoWatchI++

        stats = (values.percent for id, values of preloader.videos)
        if _.every(stats, (i) -> (i == 100))
          clearInterval(videoWatcher)

        $('video[data-preloader]').each ->
          _this = $(this)
          id    = _this.attr('id')
          vals  = preloader.videos[id]

          if _this.prop('readyState')

            try
             _this.prop('buffered').end(0)
            catch err
              if videoWatchI > 2 # iOS device, autovideo not supported
                clearInterval(videoWatcher)
                $('body').addClass('no-autoplay')
                updatePreloader vals['maxPreloadValue']

            vals['buffered']     = _this.prop('buffered').end(0)
            percent              = 100 * vals['buffered'] / vals['duration']
            vals['percent']      = if percent < 100 then percent else 100
            newPreloadValue      = (vals['maxPreloadValue'] / 100) * vals['percent']
            updatePreloader(newPreloadValue - vals['preloadValue'])
            vals['preloadValue'] = newPreloadValue
          else
            if videoWatchI > 2 # iOS device, autovideo not supported
              clearInterval(videoWatcher)
              $('body').addClass('no-autoplay')
              updatePreloader vals['maxPreloadValue']

      # Watch assets and update the preloader
      $('img[data-preloader]').imagesLoaded().progress (instance, image) ->
        int = parseInt($(image.img).attr('data-preloader'), 10)
        updatePreloader(int)

      $('video[data-preloader]').each ->
        _this    = $(this)
        id       = _this.attr('id')
        preloader.videos[id] = {}
        vals     = preloader.videos[id]

        vals['duration']        = parseInt(_this.attr('data-duration'), 10)
        vals['percent']         = 0
        vals['preloadValue']    = 0
        vals['maxPreloadValue'] = parseInt(_this.attr('data-preloader'), 10)

      if $('video[data-preloader]').length
        videoWatcher = setInterval(checkVideoLoads, 500)
