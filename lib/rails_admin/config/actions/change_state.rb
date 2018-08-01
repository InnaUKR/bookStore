require 'rails_admin/config/actions'
require 'rails_admin/config/actions/edit'

module RailsAdmin
  module Config
    module Actions
      class ChangeState < Edit
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :link_icon do
          'icon-pencil'
        end
      end
    end
  end
end