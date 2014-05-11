ActiveAdmin.register User do
  # Hide filters, because they are annoying
  config.filters = false


  index do
    column :id

    column :img do |u|
      image_tag(u.image_url, width: 50)
    end

    column :name, sortable: :name do |u|
      div link_to(u.name, admin_user_path(u.id))
      div u.email
    end

    column :gender, sortable: :gender do |u|
      if u.gender.present?
        image_tag(u.male? ? "male.png" : "female.png", width: 20)
      end
    end

    column :Favorites do |u|
      div "Favorited #{u.favorites.count} shows"
    end

    column "Created", sortable: :created_at do |u|
      "#{time_ago_in_words u.created_at} ago"
    end

    default_actions
  end


end
