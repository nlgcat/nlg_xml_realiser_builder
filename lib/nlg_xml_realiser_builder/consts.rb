module NlgXmlRealiserBuilder
  module Consts
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

    PPPHRASESPEC_ATTRIBUTES = []

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

    NLG_BOOLEAN = [true, false]

    ATTRIBUTES = {
      AGGREGATE_AUXILIARY: NLG_BOOLEAN,
      CLAUSE_STATUS: NLG_CLAUSE_STATUS,
      COMPLEMENTISER: String,
      FORM: NLG_FORM,
      INTERROGATIVE_TYPE: NLG_INTERROGATIVE_TYPE,
      MODAL: String,
      NEGATED: NLG_BOOLEAN,
      PASSIVE: NLG_BOOLEAN,
      PERFECT: NLG_BOOLEAN,
      PERSON: NLG_PERSON,
      PROGRESSIVE: NLG_BOOLEAN,
      SUPPRESS_GENITIVE_IN_GERUND: NLG_BOOLEAN,
      SUPRESSED_COMPLEMENTISER: NLG_BOOLEAN,
      TENSE: NLG_TENSE,
      ADJECTIVE_ORDERING: NLG_BOOLEAN,
      ELIDED: NLG_BOOLEAN,
      NUMBER: NLG_NUMBER_AGREEMENT,
      GENDER: NLG_GENDER,
      POSSESSIVE: NLG_BOOLEAN,
      PRONOMINAL: NLG_BOOLEAN,
      IS_COMPARATIVE: NLG_BOOLEAN,
      IS_SUPERLATIVE: NLG_BOOLEAN,
      conj: String,
      cat: NLG_PHRASE_CATEGORY + NLG_LEXICAL_CATEGORY,
      APPOSITIVE: NLG_BOOLEAN,
      CONJUNCTION_TYPE: String,
      RAISE_SPECIFIER: NLG_BOOLEAN,
      val: String,
      base: String,
      id: String,
      EXPLETIVE_SUBJECT: NLG_BOOLEAN,
      PROPER: NLG_BOOLEAN,
      var: NLG_INFLECTION,
      canned: NLG_BOOLEAN,
    }

  end
end
