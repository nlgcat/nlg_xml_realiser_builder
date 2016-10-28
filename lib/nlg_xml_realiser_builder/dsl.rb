# frozen_string_literal: true
module NlgXmlRealiserBuilder
  class DSL

    def builder(&block)
      Nokogiri::XML::Builder.new do |xml|
        @xml = xml
        xml.NLGSpec('xmlns' => 'http://simplenlg.googlecode.com/svn/trunk/res/xml', 'xmlns:xsd' => 'http://www.w3.org/2001/XMLSchema', 'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance') {
          xml.Recording {
            xml.Record {
              instance_eval(&block) if block
            }
          }
        }
      end
    end

    def doc(category = 'PARAGRAPH', &block)
      unless Consts::DOCUMENT_CATEGORIES.include?(category)
        raise "Document category '#{category}' is not in [#{Consts::DOCUMENT_CATEGORIES.join(", ")}]"
      end
      @xml.Document('cat' => category) {
        previous_call, @last_call = @last_call, 'Document'
        instance_eval(&block) if block
        @last_call = previous_call
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
      @xml.spec_('cat' => cat) {
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
      valid_attributes = Consts.const_get("#{spec_type.upcase}_ATTRIBUTES")
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

    def sp(tag = :child, options = {}, &block)
      abstract_spec('SPhraseSpec', tag, options, block)
    end

    def np(tag = :subj, noun = nil, options = {}, &block)
      determiner = options.delete(:determiner)
      cat        = options.delete(:cat) || 'NOUN'
      determiner, noun = noun if noun.is_a?(Array)

      abstract_spec('NPPhraseSpec', tag, options, block) do
        head(noun, cat)  if noun
        spec(determiner) if determiner
      end
    end

    def vp(tag = :vp, verb = nil, options = {}, &block)
      abstract_spec('VPPhraseSpec', tag, options, block) do
        head(verb, 'VERB') if verb
      end
    end

    def adj(tag = :coord, adjective = nil, options = {}, &block)
      abstract_spec('AdjPhraseSpec', tag, options, block) do
        head(adjective, 'ADJECTIVE') if adjective
      end
    end

    def adv(tag = :coord, adverb = nil, options = {}, &block)
      abstract_spec('AdvPhraseSpec', tag, options, block) do
        head(adjective, 'ADVERB') if adjective
      end
    end

    def cp(tag = :vp, options = { conj: ',' }, &block)
      abstract_spec('CoordinatedPhraseElement', tag, options, block)
    end

    def pp(tag = :compl, preposition = nil, options = {}, &block)
      abstract_spec('PPPhraseSpec', tag, options, block) do
        head(preposition, 'PREPOSITION') if preposition
      end
    end

    def str(tag = :compl, val = nil)
      if val
        @xml.send(tag, 'xsi:type' => 'StringElement') {
          @xml.val val
        }
      end
    end

  end
end
