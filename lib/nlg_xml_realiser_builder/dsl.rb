# frozen_string_literal: true
module NlgXmlRealiserBuilder
  class DSL
    DOCUMENT_CATEGORIES            = [ 'DOCUMENT', 'SECTION', 'PARAGRAPH', 'SENTENCE', 'LIST', 'ENUMERATED_LIST', 'LIST_ITEM'].freeze
    DOCUMENT_ELEMENTS              = %i(child)
    SPHRASESPEC_ELEMENTS           = %i(cuePhrase subj vp)
    PHRASE_ELEMENTS                = %i(frontMod preMod compl postMod head)
    VPPHRASESPEC_ELEMENTS          = PHRASE_ELEMENTS
    NPPHRASESPEC_ELEMENTS          = PHRASE_ELEMENTS + [ :spec ]
    ADJPHRASESPEC_ELEMENTS         = PHRASE_ELEMENTS
    ADVPHRASESPEC_ELEMENTS         = PHRASE_ELEMENTS
    PPPHRASESPEC_ELEMENTS          = PHRASE_ELEMENTS
    COORDINATEDPHRASEELEMENT_ELEMENTS = [ :coord ]

    PHRASE_SPEC_TYPES = %w(SPhraseSpec
      VPPhraseSpec
      NPPhraseSpec
      AdjPhraseSpec
      AdvPhraseSpec
      PPPhraseSpec
      CoordinatedPhraseElement
      PhraseElement
      StringElement
      WordElement)

    SPHRASESPEC_ATTRIBUTES = %i(AGGREGATE_AUXILIARY
                                CLAUSE_STATUS
                                COMPLEMENTISER
                                FORM
                                INTERROGATIVE_TYPE
                                MODAL
                                NEGATED
                                PASSIVE
                                PERFECT
                                PERSON
                                PROGRESSIVE
                                SUPPRESS_GENITIVE_IN_GERUND
                                SUPRESSED_COMPLEMENTISER
                                TENSE)

    VPPHRASESPEC_ATTRIBUTES = %i(AGGREGATE_AUXILIARY
                                FORM
                                MODAL
                                NEGATED
                                PASSIVE
                                PERFECT
                                PERSON
                                PROGRESSIVE
                                SUPPRESS_GENITIVE_IN_GERUND
                                SUPRESSED_COMPLEMENTISER
                                TENSE)

    NPPHRASESPEC_ATTRIBUTES = %i(ADJECTIVE_ORDERING
                                ELIDED
                                NUMBER
                                GENDER
                                PERSON
                                POSSESSIVE
                                PRONOMINAL)

    ADJPHRASESPEC_ATTRIBUTES = %i(IS_COMPARATIVE IS_SUPERLATIVE)

    ADVPHRASESPEC_ATTRIBUTES = []

    COORDINATEDPHRASESPEC_ATTRIBUTES = %i(conj
                                cat
                                APPOSITIVE
                                CONJUNCTION_TYPE
                                MODAL
                                NEGATED
                                NUMBER
                                PERSON
                                POSSESSIVE
                                PROGRESSIVE
                                RAISE_SPECIFIER
                                SUPRESSED_COMPLEMENTISER
                                TENSE)

    WORDELEMENT_ATTRIBUTES = %i(cat
                               id
                               EXPLETIVE_SUBJECT
                               PROPER
                               var
                               canned)


    NLG_PHRASE_CATEGORY = %w(CLAUSE
      ADJECTIVE_PHRASE
      ADVERB_PHRASE
      NOUN_PHRASE
      PREPOSITIONAL_PHRASE
      VERB_PHRASE
      CANNED_TEXT)

    NLG_LEXICAL_CATEGORY = %w(ANY
      SYMBOL
      NOUN
      ADJECTIVE
      ADVERB
      VERB
      DETERMINER
      PRONOUN
      CONJUNCTION
      PREPOSITION
      COMPLEMENTISER
      MODAL
      AUXILIARY)

    NLG_TENSE = %w(FUTURE PAST PRESENT)

    NLG_CLAUSE_STATUS = %w(MATRIX SUBORDINATE)

    NLG_DISCOURSE_FUNCTION = %w(AUXILIARY
      COMPLEMENT
      CONJUNCTION
      CUE_PHRASE
      FRONT_MODIFIER
      HEAD
      INDIRECT_OBJECT
      OBJECT
      PRE_MODIFIER
      POST_MODIFIER
      SPECIFIER
      SUBJECT
      VERB_PHRASE)

    NLG_FORM = %w(BARE_INFINITIVE
      GERUND
      IMPERATIVE
      INFINITIVE
      NORMAL
      PAST_PARTICIPLE
      PRESENT_PARTICIPLE)

    NLG_GENDER = %w(MASCULINE FEMININE NEUTER)

    NLG_NUMBER_AGREEMENT = %w(BOTH PLURAL SINGULAR)

    NLG_PERSON = %w(FIRST SECOND THIRD)

    NLG_INTERROGATIVE_TYPE = %w(HOW
      WHAT_OBJECT
      WHAT_SUBJECT
      WHERE
      WHO_INDIRECT_OBJECT
      WHO_OBJECT
      WHO_SUBJECT
      WHY
      YES_NO)

    NLG_INFLECTION = %w(GRECO_LATIN_REGULAR
      IRREGULAR
      REGULAR
      REGULAR_DOUBLE
      UNCOUNT
      INVARIANT)

    ATTRIBUTES = {
      AGGREGATE_AUXILIARY: [TrueClass, FalseClass],
      CLAUSE_STATUS: NLG_CLAUSE_STATUS,
      COMPLEMENTISER: String,
      FORM: NLG_FORM,
      INTERROGATIVE_TYPE: NLG_INTERROGATIVE_TYPE,
      MODAL: String,
      NEGATED: [TrueClass, FalseClass],
      PASSIVE: [TrueClass, FalseClass],
      PERFECT: [TrueClass, FalseClass],
      PERSON: NLG_PERSON,
      PROGRESSIVE: [TrueClass, FalseClass],
      SUPPRESS_GENITIVE_IN_GERUND: [TrueClass, FalseClass],
      SUPRESSED_COMPLEMENTISER: [TrueClass, FalseClass],
      TENSE: NLG_TENSE,
      ADJECTIVE_ORDERING: [TrueClass, FalseClass],
      ELIDED: [TrueClass, FalseClass],
      NUMBER: NLG_NUMBER_AGREEMENT,
      GENDER: NLG_GENDER,
      POSSESSIVE: [TrueClass, FalseClass],
      PRONOMINAL: [TrueClass, FalseClass],
      IS_COMPARATIVE: [TrueClass, FalseClass],
      IS_SUPERLATIVE: [TrueClass, FalseClass],
      conj: String,
      cat: [ NLG_PHRASE_CATEGORY, NLG_LEXICAL_CATEGORY ],
      APPOSITIVE: [TrueClass, FalseClass],
      CONJUNCTION_TYPE: String,
      RAISE_SPECIFIER: [TrueClass, FalseClass],
      val: String,
      base: String,
      id: String,
      EXPLETIVE_SUBJECT: [TrueClass, FalseClass],
      PROPER: [TrueClass, FalseClass],
      var: NLG_INFLECTION,
      canned: [TrueClass, FalseClass],
    }

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
      unless DOCUMENT_CATEGORIES.include?(category)
        raise "Document category '#{category}' is not in [#{DOCUMENT_CATEGORIES.join(", ")}]"
      end
      @xml.Document('cat' => category) {
        previous_call, @last_call = @last_call, 'Document'
        instance_eval(&block) if block
        @last_call = previous_call
      }
    end

    private def head(base, cat = 'NOUN')
      unless NLG_LEXICAL_CATEGORY.include?(cat)
        raise "Head category '#{cat}' is not in [#{NLG_LEXICAL_CATEGORY.join(", ")}]"
      end
      @xml.head('cat' => cat) {
        @xml.base base
      }
    end

    private def spec(base, cat = 'DETERMINER')
      unless NLG_LEXICAL_CATEGORY.include?(cat)
        raise "Specifier category must be in [#{NLG_LEXICAL_CATEGORY.join(", ")}]"
      end
      @xml.spec_('cat' => cat) {
        @xml.base base
      }
    end

    private def validate_element!(tag)
      elements = NlgXmlRealiserBuilder::DSL.const_get("#{@last_call.upcase}_ELEMENTS".to_sym)
      unless elements.include?(tag)
        raise "Element #{tag} is now allowed within #{@last_call}. Must be in [#{elements.join(', ')}]"
      end
    end

    private def validate_spec_type!(spec_type)
      unless PHRASE_SPEC_TYPES.include?(spec_type)
        raise "There is no '#{spec_type}' in [#{PHRASE_SPEC_TYPES.join(", ")}]"
      end
    end

    private def abstract_spec(spec_type, tag, options = {}, block)
      validate_element! tag
      validate_spec_type! spec_type

      attributes = { 'xsi:type' => spec_type }
      attributes.merge!(options) if options && !options.empty?

      @xml.send(tag, attributes) {
        yield if block_given?
        previous_call, @last_call = @last_call, spec_type
        instance_eval(&block) if block
        @last_call = previous_call
      }
    end

    def sp(tag = :child, verb = nil, options = {}, &block)
      abstract_spec('SPhraseSpec', tag, nil, block)
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
