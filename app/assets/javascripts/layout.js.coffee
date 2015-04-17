$ ->
  layout()

layout = ->
  fitToWindowHeight($('.app__sidebar'))
  fitToWindowHeight($('.app__main'))
  fitToWindowHeight($('.app__posts-list'))

fitToWindowHeight = ($elem) ->
  if $elem.length > 0
    h = $(window).height() - $elem.offset().top
    $elem.height(h)

$(window).resize ->
  layout()
