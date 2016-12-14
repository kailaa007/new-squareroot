
# Original version, use on future projects

#
# jQuery ($) ->
#   $(document).ready ->
#
#     #########################################################
#     # David's awesome easy preloader detector.
#     # Use this script to watch image & video loads and update a preloader progress bar as they load.
#     #
#     # Setup:
#     #   Update the jQuery selectors below for the progress bar and it's containing div.
#     #   The progress bar width will be updated automatically as the page loads.
#     #   When preloading is complete, a function onPreloadComplete() will be called.
#     #
#     # Images:
#     #   simply add a data-preloader=n attribute to the image.
#     #   n is the overall progress percentage to boost when this image uploads. For a large
#     #   image, you might set this to 10, for a small one to 1.
#     #
#     # Videos:
#     #   simply add a data-preloader=n attribute to the video.
#     #   n is the overall progress percentage to boost when this video finishes buffering.
#     #   you also need to add a data-duration value representing the overall video duration in seconds.
#     #   NOTE: each video MUST have a unique id.
#     #   NOTE: it's usually advised not to wait for the entire video to load before starting. For example
#     #   if you have a 15s video, you should probably set duration to 8s to only wait for the first 8s to load
#     #########################################################
#
#     if $('body.public.intro').length
#
#       # Setup
#       window.preloader = {
#         div: $('.slide.preload .body')
#         progress: 0
#         videos: []
#       }
#       preloader.bar = preloader.div.find('.progress')
#
#       # Position the loader. Change value from 70 to the height of the preload div.
#       preloader.div.css({ marginTop: ($(window).height() - 100) / 2 }).fadeIn()
#
#       # No need to edit anything below this point.
#
#       # Function to update the preloader
#       updatePreloader = (i) ->
#         return if i <= 0 # video will often submit 0 as buffering
#         preloader.progress += i
#         preloader.bar.animate { width: "#{preloader.progress}%" }
#         if preloader.progress >= 99
#           onPreloadComplete()
#
#       # Tracking video buffering
#       videoWatcher = 0
#       videoWatchI  = 0
#
#       checkVideoLoads = ->
#         videoWatchI++
#
#         stats = (values.percent for id, values of preloader.videos)
#         if _.every(stats, (i) -> (i == 100))
#           clearInterval(videoWatcher)
#
#         $('video[data-preloader]').each ->
#           _this = $(this)
#           id    = _this.attr('id')
#           vals  = preloader.videos[id]
#
#           if _this.prop('readyState')
#
#             try
#              _this.prop('buffered').end(0)
#             catch err
#               if videoWatchI > 2 # iOS device, autovideo not supported
#                 clearInterval(videoWatcher)
#                 $('body').addClass('no-autoplay')
#                 updatePreloader vals['maxPreloadValue']
#
#             vals['buffered']     = _this.prop('buffered').end(0)
#             percent              = 100 * vals['buffered'] / vals['duration']
#             vals['percent']      = if percent < 100 then percent else 100
#             newPreloadValue      = (vals['maxPreloadValue'] / 100) * vals['percent']
#             updatePreloader(newPreloadValue - vals['preloadValue'])
#             vals['preloadValue'] = newPreloadValue
#           else
#             if videoWatchI > 2 # iOS device, autovideo not supported
#               clearInterval(videoWatcher)
#               $('body').addClass('no-autoplay')
#               updatePreloader vals['maxPreloadValue']
#
#       # Watch assets and update the preloader
#       $('img[data-preloader]').imagesLoaded().progress (instance, image) ->
#         int = parseInt($(image.img).attr('data-preloader'), 10)
#         updatePreloader(int)
#
#       $('video[data-preloader]').each ->
#         _this    = $(this)
#         id       = _this.attr('id')
#         preloader.videos[id] = {}
#         vals     = preloader.videos[id]
#
#         vals['duration']        = parseInt(_this.attr('data-duration'), 10)
#         vals['percent']         = 0
#         vals['preloadValue']    = 0
#         vals['maxPreloadValue'] = parseInt(_this.attr('data-preloader'), 10)
#
#       if $('video[data-preloader]').length
#         videoWatcher = setInterval(checkVideoLoads, 500)
