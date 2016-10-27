require "nlg_xml_realiser_builder/version"
require "nlg_xml_realiser_builder/dsl"
require "nokogiri"
require "net/http"
require "uri"

module NlgXmlRealiserBuilder

  def self.test2
    builder do
      document_element {
        child {
          np(adverb: 'there')
          vp(verb: 'be') {
            np(tag: :compl, determiner: 'a', noun: 'stenosis') {
              cp(tag: :preMod) {
                adj('eccentric')
                adj('tubular')
              }
            }
          }

          verb('be') {
            compl("restenosis") {
              pre(:coordinated, ['eccentric', 'tubular'])
              post(:string, "(xxxx)")
            }
          }
          post("from", :prepositional) {
            pre(:verb, "extend", form: "GERUND")
            compl(:noun, 'the') {
              pre(:adjective, 'proximal')
            }
            post(:prepositional, "to") {
              compl(:noun, 'right coronary artery', determiner: 'the') {
                pre(:adjective, 'mid')
              }
            }
          }
          post(:prepositional, 'with') {
            compl(:noun, 'TIMI 1 flow')
          }
        }
      }

    end
  end

  def self.test
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.NLGSpec('xmlns' => 'http://simplenlg.googlecode.com/svn/trunk/res/xml', 'xmlns:xsd' => 'http://www.w3.org/2001/XMLSchema', 'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance') {
        xml.Recording {
          xml.Record {
            xml.Document('cat' => 'PARAGRAPH') {
              xml.child('xsi:type' => 'SPhraseSpec') {
                xml.subj('xsi:type' => 'NPPhraseSpec') {
                  xml.head('cat' => 'NOUN') {
                    xml.base 'right coronary artery'
                  }
                  xml.spec_('xsi:type' => 'WordElement', 'cat' => 'DETERMINER') {
                    xml.base 'the'
                  }
                }
                xml.vp_('xsi:type' => 'VPPhraseSpec') {
                  xml.head('cat' => 'VERB') {
                    xml.base 'have'
                  }
                  xml.compl('xsi:type' => 'NPPhraseSpec', 'NUMBER' => 'PLURAL') {
                    xml.preMod('xsi:type' => 'AdjPhraseSpec') {
                      xml.head('cat' => 'ADJECTIVE') {
                        xml.base 'mild'
                      }
                    }
                    xml.head('cat' => 'NOUN', 'var' => 'UNCOUNT') {
                      xml.base 'calcification'
                    }
                  }
                }
              }
              xml.child('xsi:type' => 'SPhraseSpec') {
                xml.subj('xsi:type' => 'NPPhraseSpec') {
                  xml.head('cat' => 'NOUN') {
                    xml.base 'right coronary artery'
                  }
                  xml.spec('xsi:type' => 'WordElement', 'cat' => 'DETERMINER') {
                    xml.base 'the'
                  }
                }
                xml.vp_('xsi:type' => 'VPPhraseSpec') {
                  xml.compl('xsi:type' => 'NPPhraseSpec', 'NUMBER' => 'PLURAL') {
                    xml.preMod('xsi:type' => 'AdjPhraseSpec') {
                      xml.base 'mild'
                    }
                    xml.head {
                      xml.base 'calcification'
                    }
                  }
                  xml.head('cat' => 'VERB') {
                    xml.base 'have'
                  }
                }
              }
            }
          }
          xml.Record('name' => 'Spell variant1') {
            xml.Document('cat' => 'PARAGRAPH') {
              xml.child('xsi:type' => 'SPhraseSpec') {
                xml.subj('xsi:type' => 'NPPhraseSpec') {
                  xml.head('cat' => 'NOUN') {
                    xml.base 'patient'
                  }
                  xml.spec('xsi:type' => 'WordElement', 'cat' => 'DETERMINER') {
                    xml.base 'the'
                  }
                }
                xml.vp_('xsi:type' => 'VPPhraseSpec', 'TENSE' => 'PAST') {
                  xml.head('cat' => 'VERB', 'var' => 'IRREGULAR') {
                    xml.base 'lie'
                  }
                  xml.postMod('xsi:type' => 'VPPhraseSpec', 'TENSE' => 'PAST') {
                    xml.head('cat' => 'VERB') {
                      xml.base 'etherise'
                    }
                    xml.postMod('xsi:type' => 'PPPhraseSpec') {
                      xml.head('cat' => 'PREPOSITION') {
                        xml.base 'upon'
                      }
                      xml.compl('xsi:type' => 'NPPhraseSpec') {
                        xml.head('cat' => 'NOUN') {
                          xml.base 'table'
                        }
                        xml.spec('xsi:type' => 'WordElement', 'cat' => 'DETERMINER') {
                          xml.base 'a'
                        }
                      }
                    }
                  }
                }
              }
            }
          }
          xml.Record('name' => 'Spell variant2') {
            xml.Document('cat' => 'PARAGRAPH') {
              xml.child('xsi:type' => 'SPhraseSpec') {
                xml.subj('xsi:type' => 'NPPhraseSpec') {
                  xml.head('cat' => 'NOUN') {
                    xml.base 'patient'
                  }
                  xml.spec('xsi:type' => 'WordElement', 'cat' => 'DETERMINER') {
                    xml.base 'the'
                  }
                }
                xml.vp_('xsi:type' => 'VPPhraseSpec', 'TENSE' => 'PAST') {
                  xml.compl('xsi:type' => 'NPPhraseSpec') {
                    xml.head('cat' => 'NOUN') {
                      xml.base 'Adam-Stokes disease'
                    }
                  }
                  xml.head('cat' => 'VERB', 'var' => 'IRREGULAR') {
                    xml.base 'has'
                  }
                }
              }
              xml.child('xsi:type' => 'SPhraseSpec') {
                xml.subj('xsi:type' => 'NPPhraseSpec') {
                  xml.head('cat' => 'NOUN') {
                    xml.base 'patient'
                  }
                  xml.spec('xsi:type' => 'WordElement', 'cat' => 'DETERMINER') {
                    xml.base 'the'
                  }
                }
                xml.vp_('xsi:type' => 'VPPhraseSpec', 'TENSE' => 'PAST') {
                  xml.compl('xsi:type' => 'NPPhraseSpec') {
                    xml.head('cat' => 'NOUN') {
                      xml.base 'Adam-Stokes disease'
                    }
                  }
                  xml.head('cat' => 'VERB', 'var' => 'IRREGULAR') {
                    xml.base 'has'
                  }
                }
              }
            }
          }
        }
      }
    end
    post builder.to_xml
  end

  def self.post(text)
    uri = URI.parse("http://nlg-service.herokuapp.com/api/realiser")
    response = Net::HTTP.post_form(uri, {"xml" => text})
    puts response.body
  end
end
