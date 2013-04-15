moveTop = (e) -> 
  e.preventDefault()
  $("html, body").animate({ scrollTop: 0 }, 100)

showFilterAlert = (name) ->
  $(".filter.alert").hide()
  $(".filter.alert.#{name}").show()

init = ->
  $(".editors a").on 'click', (event) ->
    user_id = $(this).data('userId')
    $('.user.filter .user_name').html($(this).html())
    showFilterAlert('user')
    $(".shelf_item").hide()
    $(".shelf_item[data-user_id='#{user_id}']").show()
    moveTop(event)

  $('.filter.tags a').on 'click', (e) ->
    tag = $(this).text()
    $(".shelf_item").hide()
    $(".tag.filter.alert .tag_name").html(tag)
    showFilterAlert('tag')
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

$(document).ready(init)
$(window).bind('page:change', init)
