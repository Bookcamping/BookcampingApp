//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require autocomplete-rails
//= require jquery.turbolinks
//= require turbolinks
//= require bootstrap-alert
//= require jquery.fitvids
//= require_tree .

init = ->
  $('article.reference .fitvideo').fitVids()

  $('select#shelf_color').each ->
    selector = $(this)
    colors = $('<div class="colors"></div>')
    $('#shelf_color option').each ->
      option = $(this)
      value = $(this).val()
      link = $("<a class='color' style='background-color: #{value}'>#{value}</a>").click ->
        option.attr('selected', 'selected')
        false
      colors.append(link)

    $(this).after(colors)

  $(".alert .close").click ->
    $(this).parent("div").alert('close')

$(document).ready(init)

forms = ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(".#{$(this).data('css')}").append($(this).data('fields').replace(regexp, time))
    event.preventDefault()

$(document).ready(forms)

$(document).ready ->
  $("a[data-action='add_shelf_item']").click ->
    $(".new_shelf_item_quick").show()
    false
