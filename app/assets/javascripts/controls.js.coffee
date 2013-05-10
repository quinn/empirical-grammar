class window.ChapterTabs extends Backbone.View
  events:
    'click .control a': 'showPanel'

  showPanel: (e) ->
    $el = $(e.target)
    if $el.data('default') then return true else e.preventDefault()
    $parent = $el.parent()
    @$('#main-whiteboard .panel').hide()
    @$(".panel.#{$parent.data('target')}").show()

    if $parent.data('target') then $('.panel.annotate').annotator()

    @activate $el

  activate: ($el) ->
    @$('.control a').removeClass('active')
    $el.addClass('active')

jQuery ($) ->
  if (el = $('article.chapter-tabs')).length > 0 then new ChapterTabs {el}
