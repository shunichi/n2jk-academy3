$ ->
  $(document).on 'click.collapse', '.js-toggle-collapse-link', ->
    $this = $(this)
    href = null
    selector = $this.attr('data-target') or (href = $this.attr('href')) and href.replace(/.*(?=#[^\s]+$)/, '')
    $targets = $(selector)
    $targets.toggleClass('is-collapsed')
    $targets.each (_, t) ->
      $t = $(t)
      if $t.hasClass('is-collapsed')
        $t.trigger('hidden.collapse')
      else
        $t.trigger('shown.collapse')
    false
