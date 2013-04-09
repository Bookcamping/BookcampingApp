//= require jquery
//= require jquery_ujs
//= require bootstrap-alert
//= require jquery.fitvids
//= require_tree .
//= require jquery.turbolinks
//= require turbolinks

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
#$(window).bind('page:change', init)

jQuery ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(".#{$(this).data('css')}").append($(this).data('fields').replace(regexp, time))
    event.preventDefault()

jQuery ->
  $(".editors a").on 'click', (event) ->
    user_id = $(this).data('userId')
    $('.user_filter .user_name').html($(this).html())
    $('.user_filter').show()
    $(".shelf_item").hide()
    $(".shelf_item[data-user_id='#{user_id}']").show()
    event.preventDefault()

  $(".show_all").on 'click', (event) ->
    $('.shelf_item').show()
    $('.user_filter').hide()
    event.preventDefault()
