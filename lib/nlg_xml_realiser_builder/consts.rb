# frozen_string_literal: true
module NlgXmlRealiserBuilder
  module Consts
    XML_SCHEMA = {
      'xmlns'     => 'http://simplenlg.googlecode.com/svn/trunk/res/xml',
      'xmlns:xsd' => 'http://www.w3.org/2001/XMLSchema',
      'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance'}.freeze

    DOCUMENT_CATEGORIES = %w(DOCUMENT
        SECTION
        PARAGRAPH
        SENTENCE
        LIST
        ENUMERATED_LIST
        LIST_ITEM).freeze

    PHRASE_SPEC_TYPES = %w(SPhraseSpec
      VPPhraseSpec
      NPPhraseSpec
      AdjPhraseSpec
      AdvPhraseSpec
      PPPhraseSpec
      CoordinatedPhraseElement
      PhraseElement
      StringElement
      WordElement).freeze

    # What elements does each phrase spec type accepts

    DOCUMENTELEMENT_ELEMENTS       = %i(child).freeze
    SPHRASESPEC_ELEMENTS           = %i(cuePhrase subj vp).freeze
    PHRASE_ELEMENTS                = %i(frontMod preMod compl postMod head).freeze

    VPPHRASESPEC_ELEMENTS          = PHRASE_ELEMENTS
    NPPHRASESPEC_ELEMENTS          = ( PHRASE_ELEMENTS + [ :spec ] ).freeze
    ADJPHRASESPEC_ELEMENTS         = PHRASE_ELEMENTS
    ADVPHRASESPEC_ELEMENTS         = PHRASE_ELEMENTS
    PPPHRASESPEC_ELEMENTS          = PHRASE_ELEMENTS
    COORDINATEDPHRASEELEMENT_ELEMENTS = [ :coord ].freeze

    # What attributes does each phrase spec type accepts

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
                                TENSE).freeze

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
                                TENSE).freeze

    NPPHRASESPEC_ATTRIBUTES = %i(ADJECTIVE_ORDERING
                                ELIDED
                                NUMBER
                                GENDER
                                PERSON
                                POSSESSIVE
                                PRONOMINAL
                                cat
                                discourseFunction
                                appositive).freeze

    ADJPHRASESPEC_ATTRIBUTES = %i(IS_COMPARATIVE IS_SUPERLATIVE).freeze

    ADVPHRASESPEC_ATTRIBUTES = [].freeze

    PPPHRASESPEC_ATTRIBUTES  = [].freeze

    COORDINATEDPHRASEELEMENT_ATTRIBUTES = %i(conj
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
                                TENSE).freeze

    WORDELEMENT_ATTRIBUTES = %i(cat
                               id
                               EXPLETIVE_SUBJECT
                               PROPER
                               var
                               canned).freeze

    # What primitive values does each kind of attribute accepts

    NLG_PHRASE_CATEGORY = %w(CLAUSE
      ADJECTIVE_PHRASE
      ADVERB_PHRASE
      NOUN_PHRASE
      PREPOSITIONAL_PHRASE
      VERB_PHRASE
      CANNED_TEXT).freeze

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
      AUXILIARY).freeze

    NLG_TENSE = %w(FUTURE PAST PRESENT).freeze

    NLG_CLAUSE_STATUS = %w(MATRIX SUBORDINATE).freeze

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
      VERB_PHRASE).freeze

    NLG_FORM = %w(BARE_INFINITIVE
      GERUND
      IMPERATIVE
      INFINITIVE
      NORMAL
      PAST_PARTICIPLE
      PRESENT_PARTICIPLE).freeze

    NLG_GENDER = %w(MASCULINE FEMININE NEUTER).freeze

    NLG_NUMBER_AGREEMENT = %w(BOTH PLURAL SINGULAR).freeze

    NLG_PERSON = %w(FIRST SECOND THIRD).freeze

    NLG_INTERROGATIVE_TYPE = %w(HOW
      WHAT_OBJECT
      WHAT_SUBJECT
      WHERE
      WHO_INDIRECT_OBJECT
      WHO_OBJECT
      WHO_SUBJECT
      WHY
      YES_NO).freeze

    NLG_INFLECTION = %w(GRECO_LATIN_REGULAR
      IRREGULAR
      REGULAR
      REGULAR_DOUBLE
      UNCOUNT
      INVARIANT).freeze

    NLG_BOOLEAN = [true, false].freeze

    ATTRIBUTES = {
      ADJECTIVE_ORDERING:            NLG_BOOLEAN,
      AGGREGATE_AUXILIARY:           NLG_BOOLEAN,
      APPOSITIVE:                    NLG_BOOLEAN,
      CLAUSE_STATUS:                 NLG_CLAUSE_STATUS,
      COMPLEMENTISER:                String,
      CONJUNCTION_TYPE:              String,
      ELIDED:                        NLG_BOOLEAN,
      EXPLETIVE_SUBJECT:             NLG_BOOLEAN,
      FORM:                          NLG_FORM,
      GENDER:                        NLG_GENDER,
      INTERROGATIVE_TYPE:            NLG_INTERROGATIVE_TYPE,
      IS_COMPARATIVE:                NLG_BOOLEAN,
      IS_SUPERLATIVE:                NLG_BOOLEAN,
      MODAL:                         String,
      NEGATED:                       NLG_BOOLEAN,
      NUMBER:                        NLG_NUMBER_AGREEMENT,
      PASSIVE:                       NLG_BOOLEAN,
      PERFECT:                       NLG_BOOLEAN,
      PERSON:                        NLG_PERSON,
      POSSESSIVE:                    NLG_BOOLEAN,
      PROGRESSIVE:                   NLG_BOOLEAN,
      PRONOMINAL:                    NLG_BOOLEAN,
      PROPER:                        NLG_BOOLEAN,
      RAISE_SPECIFIER:               NLG_BOOLEAN,
      SUPPRESS_GENITIVE_IN_GERUND:   NLG_BOOLEAN,
      SUPRESSED_COMPLEMENTISER:      NLG_BOOLEAN,
      TENSE:                         NLG_TENSE,
      appositive:                    NLG_BOOLEAN,
      base:                          String,
      canned:                        NLG_BOOLEAN,
      cat:                           ( NLG_PHRASE_CATEGORY + NLG_LEXICAL_CATEGORY ).freeze,
      conj:                          String,
      discourseFunction:             NLG_DISCOURSE_FUNCTION,
      id:                            String,
      val:                           String,
      var:                           NLG_INFLECTION,
    }.freeze

  end
end
