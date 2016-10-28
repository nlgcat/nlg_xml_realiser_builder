# frozen_string_literal: true
module NlgXmlRealiserBuilder
  class DSL
    include NlgXmlRealiserBuilder::PrimitiveOperations
    include NlgXmlRealiserBuilder::PhraseSpecs
    include NlgXmlRealiserBuilder::Porcelain
  end
end
