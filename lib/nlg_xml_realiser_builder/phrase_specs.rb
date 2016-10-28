# frozen_string_literal: true
module NlgXmlRealiserBuilder
  module PhraseSpecs
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
  end
end
