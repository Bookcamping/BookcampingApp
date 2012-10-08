//= require jquery
//= require jquery_ujs
//= require bootstrap-alert
//= require jquery.fitvids
//= require_tree .
//= require turbolinks

init = ->
  $('article.reference .media').fitVids()

  $('select#shelf_color').each ->
    selector = $(this)
    colors = $('<div class="colors"></div>')
    $('#shelf_color option').each ->
      option = $(this)
      value = $(this).val()
      link = $("<a class='color' style='background-color: #{value}'>#{value}</a>").click ->
        option.attr('selected', true)
        false
      colors.append(link)

    $(this).after(colors)

$(document).ready(init)
$(window).bind('page:change', init)
