module ButtonsHelper

  def right_arrow_link_to(*args, &block)
    arrow_link_to(:right, *args, block)
  end

  def left_arrow_link_to(*args, &block)
    arrow_link_to(:left, *args, block)
  end

  def arrow_link_to(direction, *args, &block)
    content = link_to(*args, block)
    raw %Q(<div class="arrow-button #{direction}">
    <div class="img left"></div>
    <div class="img right"></div>
    <div class="content">#{content}</div>
    </div>)
  end

end
