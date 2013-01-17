//= require jquery
//= require jquery_ujs
//= require bootstrap-alert
//= require jquery.fitvids
//= require_tree .
//= require turbolinks

init = ->
  $('article.reference .fitvideo').fitVids()
  console.log "FIT!"

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

  $(".alert .close").click ->
    $(this).parent("div").alert('close')

$(document).ready(init)
$(window).bind('page:change', init)
