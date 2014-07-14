module ActiveRecord
  module ActsAsRelation
    class ActsAs
      attr_accessor :module_name, :scope, :options
      attr_reader :name, :class_name, :model, :association_name, :module_name, :module

      def initialize(model_name, scope=nil, options={})
        @model_name, @scope, @options = model_name, scope, options
        if scope.is_a?(Hash)
          @options = scope
          @scope   = nil
        end

        deprecation_warnings

        @name             = @model_name.to_s.underscore.singularize.to_sym
        @class_name       = @options[:class_name] || @name.to_s.camelcase
        @model            = @class_name.constantize
        @association_name = @options[:as] || @model.acts_as_association_name
        @module_name      = "ActsAs#{class_name}"
        @module = ActiveRecord::ActsAsRelation::ActsAsModules.module_for(self)
      end

      def attributes_to_delegate
        attributes = model.content_columns.map(&:name)
        associations = model.reflect_on_all_associations.map(&:name)
        ignored = ["created_at", "updated_at",
          "#{association_name}_id", "#{association_name}_type", "#{association_name}"]
        attributes + associations - ignored
      end

      def parent_relations
        @parent_relations ||= (model.reflect_on_all_associations.map(&:name) - [association_name]).map { |a| a.to_s + '_id' }
      end

      def deprecation_warnings
        if options[:conditions]
          ActiveSupport::Deprecation.warn(":conditions is no longer supported by acts_as. Please use `where()` instead. Example: `acts_as :person, -> { where(name: 'John') }`")
        end
        if options[:include]
          ActiveSupport::Deprecation.warn(":include is no longer supported by acts_as. Please use `includes()` instead. Example: `acts_as :person, -> { includes(:friends) }`")
        end
      end
    end
  end
end