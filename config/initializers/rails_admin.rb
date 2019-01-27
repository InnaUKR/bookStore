RailsAdmin.config do |config|
  config.parent_controller = '::ApplicationController'
  config.authenticate_with { warden.authenticate! scope: :user }
  config.current_user_method(&:current_user)
  config.authorize_with { redirect_to main_app.root_path unless current_user.admin == true }

  config.actions do
    dashboard
    index
    new
    export
    bulk_delete
    edit
    delete do
      except [Order]
    end
    show_in_app do
      except [Order]
    end
  end

  config.included_models = %w[Order Book Author Category Review Coupon]

  config.model Order do
    list do
      scopes [nil, 'in_progress', 'delivered', 'canceled']
      field :id do
        label 'Number'
        formatted_value do
          OrderDecorator.decorate(bindings[:object]).number
        end
      end
      field :created_at do
        label 'Date of Creation'
      end
      field :state
    end

    edit do
      field :state, :enum do
        enum do
          bindings[:object].aasm.states(permitted: true).map(&:name)
        end
      end
    end
  end

  config.model Book do
    weight -1
    list do
      field :image do
        formatted_value do
          if bindings[:object].images != []
            bindings[:view].tag(:img,
                                src: bindings[:object].images.first.image_url,
                                style: 'max-width: 100%')
          end
        end
      end
      field :category
      field :authors do
        pretty_value do
          value.join(', ')
        end
      end
      fields :title, :description, :price
    end
  end

  config.model Author do
    fields :first_name, :last_name
    field :biography do
      label 'Description'
    end
  end

  config.model 'Category' do
    field :name
  end

  config.model Image do
    edit do
      field :image, :carrierwave
    end
  end

  config.model Review do
    list do
      scopes [nil, 'new_reviews', 'processed']
      field :book
      field :title
      field :created_at do
        label 'Date'
      end
      field :user
      field :state
    end

    edit do
      field :title do
        read_only true
        help false
      end
      field :text do
        read_only true
        help false
      end
      field :state, :enum do
        enum do
          bindings[:object].aasm.states(permitted: true).map(&:name)
        end
      end
    end
  end

  config.model Coupon do
    field :name
    field :amount
  end
end



