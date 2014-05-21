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


  show do |user|
    columns do
      column do
        attributes_table do
          row :image do
            image_tag(user.image_url, width: 200)
          end
          row :id
          row :name
          row :email
          row :gender
          row :created_at
          row :updated_at
        end
      end

      column do
        panel "Favorite shows" do
          table_for user.favorites.each do
            column :img do |r|
              show = Tmdb::TV.detail(r.show_id)
              image_tag("#{tmdb_base_url}w300#{show.poster_path}", height: 50) if show.poster_path
            end
            column :show do |r|
              show = Tmdb::TV.detail(r.show_id)
              div show.name
            end

            column(:favorited) do |r|
              "#{time_ago_in_words(r.created_at)} ago"
            end
          end
        end
      end # column
    end # columns
    columns do
      column do
        panel "Top rated shows" do
          table_for user.ratings.each do
            column :img do |r|
              show = Tmdb::TV.detail(r.show_id)
              image_tag("#{tmdb_base_url}w300#{show.poster_path}", height: 50) if show.poster_path
            end
            column :show do |r|
              show = Tmdb::TV.detail(r.show_id)
              div show.name
              div "Season #{r.season}" if r.season
              div "Episode #{r.episode}" if r.episode
            end
            column :rating do |r|
              r.score.times.map{ "&#9733;" }.join.html_safe
            end

            column(:rated) do |r|
              "#{time_ago_in_words(r.created_at)} ago"
            end
          end
        end

      end # column
      column do
        panel "Comments" do
          table_for user.comments.each do |p|
            column :img do |r|
              show = Tmdb::TV.detail(r.show_id)
              image_tag("#{tmdb_base_url}w300#{show.poster_path}", height: 50) if show.poster_path
            end
            column :show do |r|
              show = Tmdb::TV.detail(r.show_id)
              div show.name
              div "Season #{r.season}" if r.season
              div "Episode #{r.episode}" if r.episode
            end
            column :message

            column :commented do |r|
              "#{time_ago_in_words(r.created_at)} ago"
            end
          end # table
        end # panel
      end # column
    end # Columns
  end # show


end
