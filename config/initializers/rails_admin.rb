# frozen_string_literal: true

RailsAdmin.config do |config|
  config.parent_controller = '::ApplicationController'
  config.authenticate_with { warden.authenticate! scope: :user }
  config.current_user_method(&:current_user)
  config.authorize_with { redirect_to main_app.root_path unless current_user.admin == true }

  config.actions do
    dashboard
    index
    new do
      except [Order, Review]
    end
    export
    bulk_delete
    edit
    delete do
      except [Order, Review]
    end
    show_in_app do
      except [Order]
    end
  end

  config.included_models = %w[Order Book Author Category Review Coupon Image LineItem Delivery]

  config.model Image do
    visible false
  end

  config.model LineItem do
    visible false
  end

  config.model Delivery do
    list do
      fields :method_name, :price, :days
    end
    create do
      configure :orders do
        visible false
      end
    end
    edit do
      configure :orders do
        visible false
      end
    end
  end

  config.model Order do
    list do
      scopes ['all_for_admin', 'in_queue', 'delivered', 'canceled']
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
      field :line_item_id do
        render do
          bindings[:view].render :partial => "line_items", :locals => {:field => self, :line_items => bindings[:object].line_items}
        end
      end
    end
  end

  config.model Image do
    edit do
      field :image, :carrierwave
    end
  end

  config.model Book do
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

    create do
      configure :reviews do
        visible false
      end
      configure :line_items do
        visible false
      end
    end

    edit do
      configure :reviews do
        visible false
      end
      configure :line_items do
        visible false
      end
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



  config.model Review do
    list do
      scopes [nil, 'new_reviews', 'processed']
      field :book
      field :title
      field :created_at do
        label 'Date'
      end
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
