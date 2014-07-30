class TypeAhead < Dill::List
  root '.tt-dropdown-menu'
  item 'i'

  def has_item?(title)
    items.each do |item|
      return true if title == item.value[/^(.+?) \(\d+?\)$/, 1]
    end
    false
  end
end
