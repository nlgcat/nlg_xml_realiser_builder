# frozen_string_literal: true
module NlgXmlRealiserBuilder
  module Porcelain
    def list(enumerated: false, &block)
      document_category = enumerated ? 'ENUMERATED_LIST' : 'LIST'
      doc(:Document, cat: document_category, &block)
    end

    def item(&block)
      doc(:child, cat: 'LIST_ITEM', &block)
    end

    def verb(verb = nil, options = {}, &block)
      vp(:vp, verb, options, &block)
    end

    # Invert the tag for the phrase spec
    private def abstract_tag(spec_method, tag = nil, main_value = nil, options = {}, &block)
      unless Consts::SPEC_METHODS.include?(spec_method)
        raise "spec method #{spec_method} not included in [#{Consts::SPEC_METHODS.join(", ")}]"
      end
      if main_value.is_a?(Hash)
        send(spec_method, tag, main_value, &block) # case of 'cp' which has no main value parameter
      else
        send(spec_method, tag, main_value, options, &block)
      end
    end

    # Create inverted methods so instead of doing:
    #
    #   np(:compl, ['an', 'apple'])
    #
    # we can do:
    #
    #   compl(:np, ['an', 'apple'])
    #
    (Consts::DOCUMENTELEMENT_ELEMENTS + Consts::SPHRASESPEC_ELEMENTS + Consts::PHRASE_ELEMENTS + Consts::COORDINATEDPHRASEELEMENT_ELEMENTS).each do |main_tag|
      next if %i(head vp).include? main_tag
      module_eval <<-EOF
      def #{main_tag}(spec_method, main_value = nil, options = {}, &block)
        if spec_method.is_a?(Array)
          abstract_tag(:np, :#{main_tag}, spec_method, main_value || {}, &block)
        else
          abstract_tag(spec_method, :#{main_tag}, main_value, options, &block)
        end
      end
      EOF
    end
  end
end
