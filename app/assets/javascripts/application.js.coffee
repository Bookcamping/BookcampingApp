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


moveTop = (e) -> 
  e.preventDefault()
  $("html, body").animate({ scrollTop: 0 }, 100)


jQuery ->
  $(".editors a").on 'click', (event) ->
    user_id = $(this).data('userId')
    $('.user.filter .user_name').html($(this).html())
    $('.user.filter').show()
    $(".shelf_item").hide()
    $(".shelf_item[data-user_id='#{user_id}']").show()
    moveTop(event)

  $('.filter.tags a').on 'click', (e) ->
    tag = $(this).text()
    $(".shelf_item").hide()
    $(".tag.filter.alert .tag_name").html(tag)
    $(".tag.filter.alert").show()
    $(".shelf_item[data-tags*='#{tag}']").show()
    moveTop(e)

  $(".show_all").on 'click', (event) ->
    $('.shelf_item').show()
    $('.filter.alert').hide()
    $("html, body").animate({ scrollTop: 0 }, 300)
    moveTop(event)

  $(".shelf_view #as_icons").on 'click', (e) ->
    $(".references").addClass('icons-only')
    $("html, body").animate({ scrollTop: 0 }, 300)
    moveTop(event)

  $(".shelf_view #as_list").on 'click', (e) ->
    $(".references").removeClass('icons-only')
    $("html, body").animate({ scrollTop: 0 }, 300)
    moveTop(event)

