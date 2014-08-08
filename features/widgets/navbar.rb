class Navbar < Dill::Widget
  root '.nav-bar'

  widget :home, '.habits-link'
  widget :logout, '.logout'
end
