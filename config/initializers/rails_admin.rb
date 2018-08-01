require "rails_admin/config/actions/change_state"

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
    edit do
      except [Order]
    end
    delete do
      except [Order]
    end
    show_in_app do
      except [Order]
    end
    change_state do
      only [Order]
    end
  end

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

  config.model Image do
    edit do
      field :image, :carrierwave
    end
  end

  config.model Review do
    edit do
      field :body do
        read_only true
        help false
      end
      field :approve
    end
  end
end
