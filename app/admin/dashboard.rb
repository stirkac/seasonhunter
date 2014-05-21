ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Users" do
          table_for User.order("created_at DESC").each do |user|
            column :id

            column :img do |u|
              image_tag(u.image_url, width: 50)
            end

            column :name do |u|
              div link_to(u.name, admin_user_path(u.id))
              div u.email
            end

            column :gender do |u|
              if u.gender.present?
                image_tag(u.male? ? "male.png" : "female.png", width: 20)
              end
            end

            column :activity do |u|
              div "Favorited #{u.favorites.count} #{"show".pluralize(u.favorites.count)}"
              div "Added #{u.comments.count} #{"comment".pluralize(u.comments.count)}"
              div "Rated #{u.ratings.count} #{"show".pluralize(u.ratings.count)}"
            end

            column "Created" do |u|
              "#{time_ago_in_words u.created_at} ago"
            end
          end # Table
        end # Panel
      end # Column

      column do
        panel "Favorites" do
          table_for Favorite.order(created_at: :desc).each do
            column :img do |r|
              image_tag(r.user.image_url, width: 50)
            end
            column :name do |r|
              div link_to(r.user.name, admin_user_path(r.user))
              div r.user.email
            end

            column :img do |r|
              show = Tmdb::TV.detail(r.show_id)
              image_tag("#{tmdb_base_url}w300#{show.poster_path}", height: 50) if show.poster_path
            end
            column :show do |r|
              show = Tmdb::TV.detail(r.show_id)
              div show.name
            end
            column :favorite do |r|
              "Added to favorites."
            end

            column(:rated) do |r|
              "#{time_ago_in_words(r.created_at)} ago"
            end
          end # Table
        end # Panel
      end # Column

    end # Columns

    columns do
      column do
        panel "Ratings" do
          table_for Rating.order(created_at: :desc).each do
            column :img do |r|
              image_tag(r.user.image_url, width: 50)
            end
            column :name do |r|
              div link_to(r.user.name, admin_user_path(r.user))
              div r.user.email
            end

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
          end # Table
        end # Panel
      end # Column

      column do
        panel "Comments" do
          table_for Comment.order(created_at: :desc).each do
            column :img do |r|
              image_tag(r.user.image_url, width: 50)
            end
            column :name do |r|
              div link_to(r.user.name, admin_user_path(r.user))
              div r.user.email
            end

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
            column :comment do |r|
              r.message
            end

            column(:rated) do |r|
              "#{time_ago_in_words(r.created_at)} ago"
            end
          end # Table
        end # Panel
      end # Column
    end # Columns
  end # Content
end
