require_relative 'controllers/menu_controller'

# creates a `MenuController` when `AddressBloc` starts
menu = MenuController.new

# use `system "clear"` to clear the command line
system 'clear'
puts 'Welcome to AddressBloc!'

#`main_menu` to display the menu
menu.main_menu
