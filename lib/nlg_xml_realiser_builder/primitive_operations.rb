# frozen_string_literal: true
module NlgXmlRealiserBuilder
  module PrimitiveOperations
    def builder(&block)
      Nokogiri::XML::Builder.new do |xml|
        @xml = xml
        xml.NLGSpec(Consts::XML_SCHEMA) {
          xml.Recording {
            instance_eval(&block) if block
          }
        }
      end
    end

    def record(name = nil, &block)
      attributes = {}
      attributes.merge(name: name) if name
      @xml.Record(attributes) {
        instance_eval(&block) if block
      }
    end

    def doc(tag = :Document, options = {}, &block)
      category = options.delete(:cat) || 'PARAGRAPH'
      unless Consts::DOCUMENT_CATEGORIES.include?(category)
        raise "Document category '#{category}' is not in [#{Consts::DOCUMENT_CATEGORIES.join(", ")}]"
      end
      attributes = {}
      attributes.merge!('xsi:type' => 'DocumentElement') unless tag == :Document
      attributes.merge!('cat' => category)
      @xml.send(tag, attributes) {
        previous_call, @last_call = @last_call, 'DocumentElement'
        instance_eval(&block) if block
        @last_call = previous_call
      }
    end

    def str(tag = :compl, val = nil)
      return unless val
      @xml.send(tag, 'xsi:type' => 'StringElement') {
        @xml.val val.to_s
      }
    end

    private def head(base, cat = 'NOUN')
      unless Consts::NLG_LEXICAL_CATEGORY.include?(cat)
        raise "Head category '#{cat}' is not in [#{Consts::NLG_LEXICAL_CATEGORY.join(", ")}]"
      end
      @xml.head('cat' => cat) {
        @xml.base base
      }
    end

    private def spec(base, cat = 'DETERMINER')
      unless Consts::NLG_LEXICAL_CATEGORY.include?(cat)
        raise "Specifier category must be in [#{Consts::NLG_LEXICAL_CATEGORY.join(", ")}]"
      end
      @xml.spec_('xsi:type' => 'WordElement', 'cat' => cat) {
        @xml.base base
      }
    end

    private def validate_element!(tag)
      elements = Consts.const_get("#{@last_call.upcase}_ELEMENTS".to_sym)
      unless elements.include?(tag)
        raise "Element #{tag} is now allowed within #{@last_call}. Must be in [#{elements.join(', ')}]"
      end
    end

    private def validate_spec_type!(spec_type)
      unless Consts::PHRASE_SPEC_TYPES.include?(spec_type)
        raise "There is no '#{spec_type}' in [#{Consts::PHRASE_SPEC_TYPES.join(", ")}]"
      end
    end

    private def validate_attributes!(options = {}, spec_type)
      valid_attributes   = Consts.const_get("#{spec_type.upcase}_ATTRIBUTES")
      invalid_attributes = options.keys - valid_attributes
      unless invalid_attributes.empty?
        raise "Attributes [#{invalid_attributes.join(", ")}] are invalid for #{spec_type} which only allows [#{valid_attributes.join(", ")}]"
      end

      results = []
      options.keys.each do |key|
        valid = if Consts::ATTRIBUTES[key].is_a? Array
                  Consts::ATTRIBUTES[key].include? options[key]
                else
                  options[key].is_a? Consts::ATTRIBUTES[key]
                end
        unless valid
          results << "Attribute #{key} with value '#{options[key]}' should be in [#{ATTRIBUTES[key].join(", ")}]"
        end
      end

      unless results.empty?
        raise results.join("\n")
      end
    end

    private def abstract_spec(spec_type, tag, options = {}, block)
      validate_element! tag
      validate_spec_type! spec_type
      validate_attributes! options, spec_type

      attributes = { 'xsi:type' => spec_type }
      attributes.merge!(options) if options && !options.empty?

      @xml.send(tag, attributes) {
        yield if block_given?

        previous_call, @last_call = @last_call, spec_type
        instance_eval(&block) if block
        @last_call = previous_call
      }
    end
  end
end
