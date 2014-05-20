ActiveAdmin.register Comment do
  # Hide filters, because they are annoying
  config.filters = false
  menu parent: "Users"

end
