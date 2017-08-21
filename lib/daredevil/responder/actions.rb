module Daredevil
  class Responder
    module Actions
      ACTIONS = %w(index show create edit update destroy).freeze

      %w(index show edit).each do |method|
        define_method("respond_to_#{method}_action") do
          self.status ||= :ok
          render_resource
        end
      end

      def respond_to_create_action
        if resource.persisted? && resource.valid?
          self.status ||= :created
          render_resource
        else
          self.status ||= :conflict
          render_error
        end
      end

      def respond_to_update_action
        if resource.valid?
          self.status ||= :ok
          render_resource
        else
          self.status ||= :conflict
          render_error
        end
      end

      def respond_to_destroy_action
        self.status ||= :no_content
        controller.head(status, render_options)
      end

      def render_resource
        controller.render(resource_render_options)
      end

      def resource_render_options
        self.send(:"#{Daredevil.config.responder_type.to_s}_resource_render_options")
      end

      def jbuilder_resource_render_options
        render_options
      end

      def serializers_resource_render_options
        serializer_key = relation? ? :each_serializer : :serializer

        render_options.merge(
          json: resource,
          serializer_key => serializer_class
        )
      end

      def serializer_class
        options[:serializer] ||=
          [
            namespace,
            "#{resource_class}Serializer"
          ].compact.join('::').safe_constantize
        options[:serializer] ||= "#{resource_class}Serializer".safe_constantize
      end

      def resource_class
        return resource.model if relation?
        resource.class
      end

      def relation?
        resource.is_a?(ActiveRecord::Relation)
      end

      def responder_type
        supported_responders.each do |type, klass|
          return type.to_sym if defined?(klass.safe_constantize).eql?('constant')
        end
      end

      def supported_responders
        {
          jbuilder: 'Jbuilder',
          serializers: 'ActiveModel::Serializers',
          rabl: 'RABL'
        }
      end
    end
  end
end
