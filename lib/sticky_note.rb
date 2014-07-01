require 'active_support/concern'
require "sticky_note/version"

module StickyNote
  extend ActiveSupport::Concern

  included do
    @memoized_options = {}
    @memoized_methods = []
  end

  module ClassMethods
    def memoize_inner(method, options={})
      original_method = "#{method}_original".to_sym

      alias_method original_method, method

      define_method method do |*args|
        cache_key = memoize_key(method, args)
        ap cache_key
        Rails.cache.fetch(cache_key, options) do
          send(original_method, *args)
        end
      end
    end

    def memoize(method, options={})
      methods = Array(method)

      methods.each do |method|
        if respond_to? method
          memoize_inner method, options
        else
          @memoized_methods << method
          @memoized_options = options
        end
      end
    end

    def method_added(method)
      if @memoized_methods.include? method
        @memoized_methods.delete(method)
        memoize_inner method, @memoized_options
      end
    end

  end

  def memoize_key(method, *args)
    sub_key = respond_to?(:cache_key) ? cache_key : self.class.name

    "memoize-#{sub_key}-#{method}-#{args.join}"
  end
end

