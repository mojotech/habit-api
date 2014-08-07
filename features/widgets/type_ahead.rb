class TypeAhead < Dill::List
  root '.dropdown-menu'
  item '.dropdown-item'

  def has_item?(title)
    items.each do |item|
      return true if title == title(item)
    end
    false
  end

  def click_suggestion(title)
    if has_item?(title)
      items.each do |item|
        item.click if title == title(item)
      end
    end
  end

  def title(item)
    item.value[/^(.+?) \(\d+?\)$/, 1]
  end
end
