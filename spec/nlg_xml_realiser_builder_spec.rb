require "spec_helper"

describe NlgXmlRealiserBuilder do
  let(:dsl) { NlgXmlRealiserBuilder::DSL.new }
  it "has a version number" do
    expect(NlgXmlRealiserBuilder::VERSION).not_to be nil
  end

  it "renders the root level structure" do
    expect(dsl.builder(true).to_xml).to eq(<<-EOF)
<?xml version="1.0"?>
<NLGSpec xmlns="http://simplenlg.googlecode.com/svn/trunk/res/xml" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <Recording>
    <Record>
      <Document cat="PARAGRAPH"/>
    </Record>
  </Recording>
</NLGSpec>
    EOF
  end

  it "both normal and inverted syntax should render the same XML" do
    xml_1 = dsl.builder(true) do
      sp :child do
        subj :np, 'there', cat: 'ADVERB'
        verb 'be' do
          compl [ 'a', 'restenosis' ] do
            preMod :cp, conj: ',' do
              coord :adj, 'eccentric'
              coord :adj, 'tubular'
            end
            postMod :str, '(18 mm x 1 mm)'
          end
          postMod :pp, 'from' do
            preMod :vp, 'extend', FORM: 'GERUND'
            compl ['the'] do
              preMod :adj, 'proximal'
            end
            postMod :pp, 'to' do
              compl [ 'a', 'right coronary artery' ] do
                preMod :adj, 'mid'
              end
            end
          end
          postMod :pp, 'with' do
            compl :np, 'TIMI 1 flow'
          end
        end
      end
    end.to_xml

    dsl_2 = NlgXmlRealiserBuilder::DSL.new
    xml_2 = dsl_2.builder(true) do
      sp :child do
        np :subj, 'there', cat: 'ADVERB'
        vp :vp, 'be' do
          np :compl, [ 'a', 'restenosis' ] do
            cp :preMod, conj: ',' do
              adj :coord, 'eccentric'
              adj :coord, 'tubular'
            end
            str :postMod, '(18 mm x 1 mm)'
          end
          pp :postMod, 'from' do
            vp :preMod, 'extend', FORM: 'GERUND'
            np :compl, ['the'] do
              adj :preMod, 'proximal'
            end
            pp :postMod, 'to' do
              np :compl, [ 'a', 'right coronary artery' ] do
                adj :preMod, 'mid'
              end
            end
          end
          pp :postMod, 'with' do
            np :compl, 'TIMI 1 flow'
          end
        end
      end
    end.to_xml

    expect(xml_1).to eq(xml_2)
  end

  it "renders a complete example of a NLGSpec" do
    expect(dsl.builder(true) do
      sp :child do
        subj :np, 'there', cat: 'ADVERB'
        verb 'be' do
          compl [ 'a', 'restenosis' ] do
            preMod :cp, conj: ',' do
              coord :adj, 'eccentric'
              coord :adj, 'tubular'
            end
            postMod :str, '(18 mm x 1 mm)'
          end
          postMod :pp, 'from' do
            preMod :vp, 'extend', FORM: 'GERUND'
            compl ['the'] do
              preMod :adj, 'proximal'
            end
            postMod :pp, 'to' do
              compl [ 'a', 'right coronary artery' ] do
                preMod :adj, 'mid'
              end
            end
          end
          postMod :pp, 'with' do
            compl :np, 'TIMI 1 flow'
          end
        end
      end
    end.to_xml).to eq(<<-EOF)
<?xml version="1.0"?>
<NLGSpec xmlns="http://simplenlg.googlecode.com/svn/trunk/res/xml" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <Recording>
    <Record>
      <Document cat="PARAGRAPH">
        <child xsi:type="SPhraseSpec">
          <subj xsi:type="NPPhraseSpec">
            <head cat="ADVERB">
              <base>there</base>
            </head>
          </subj>
          <vp xsi:type="VPPhraseSpec">
            <head cat="VERB">
              <base>be</base>
            </head>
            <compl xsi:type="NPPhraseSpec">
              <head cat="NOUN">
                <base>restenosis</base>
              </head>
              <spec xsi:type="WordElement" cat="DETERMINER">
                <base>a</base>
              </spec>
              <preMod xsi:type="CoordinatedPhraseElement" conj=",">
                <coord xsi:type="AdjPhraseSpec">
                  <head cat="ADJECTIVE">
                    <base>eccentric</base>
                  </head>
                </coord>
                <coord xsi:type="AdjPhraseSpec">
                  <head cat="ADJECTIVE">
                    <base>tubular</base>
                  </head>
                </coord>
              </preMod>
              <postMod xsi:type="StringElement">
                <val>(18 mm x 1 mm)</val>
              </postMod>
            </compl>
            <postMod xsi:type="PPPhraseSpec">
              <head cat="PREPOSITION">
                <base>from</base>
              </head>
              <preMod xsi:type="VPPhraseSpec" FORM="GERUND">
                <head cat="VERB">
                  <base>extend</base>
                </head>
              </preMod>
              <compl xsi:type="NPPhraseSpec">
                <spec xsi:type="WordElement" cat="DETERMINER">
                  <base>the</base>
                </spec>
                <preMod xsi:type="AdjPhraseSpec">
                  <head cat="ADJECTIVE">
                    <base>proximal</base>
                  </head>
                </preMod>
              </compl>
              <postMod xsi:type="PPPhraseSpec">
                <head cat="PREPOSITION">
                  <base>to</base>
                </head>
                <compl xsi:type="NPPhraseSpec">
                  <head cat="NOUN">
                    <base>right coronary artery</base>
                  </head>
                  <spec xsi:type="WordElement" cat="DETERMINER">
                    <base>a</base>
                  </spec>
                  <preMod xsi:type="AdjPhraseSpec">
                    <head cat="ADJECTIVE">
                      <base>mid</base>
                    </head>
                  </preMod>
                </compl>
              </postMod>
            </postMod>
            <postMod xsi:type="PPPhraseSpec">
              <head cat="PREPOSITION">
                <base>with</base>
              </head>
              <compl xsi:type="NPPhraseSpec">
                <head cat="NOUN">
                  <base>TIMI 1 flow</base>
                </head>
              </compl>
            </postMod>
          </vp>
        </child>
      </Document>
    </Record>
  </Recording>
</NLGSpec>
    EOF
  end

  it "renders the XMLRealiserParameterizedTests appositive test" do
    xml_payload = dsl.builder(true) do
      child :sp, PASSIVE: true do
        verb 'deploy', TENSE: 'PAST' do
          compl ['a', 'angioplasty balloon catheter'] do
            postMod ['the', 'D701000000992'], appositive: true
          end
        end
      end
    end.to_xml

    expect(xml_payload).to eq(<<-EOF)
<?xml version="1.0"?>
<NLGSpec xmlns="http://simplenlg.googlecode.com/svn/trunk/res/xml" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <Recording>
    <Record>
      <Document cat="PARAGRAPH">
        <child xsi:type="SPhraseSpec" PASSIVE="true">
          <vp xsi:type="VPPhraseSpec" TENSE="PAST">
            <head cat="VERB">
              <base>deploy</base>
            </head>
            <compl xsi:type="NPPhraseSpec">
              <head cat="NOUN">
                <base>angioplasty balloon catheter</base>
              </head>
              <spec xsi:type="WordElement" cat="DETERMINER">
                <base>a</base>
              </spec>
              <postMod xsi:type="NPPhraseSpec" appositive="true">
                <head cat="NOUN">
                  <base>D701000000992</base>
                </head>
                <spec xsi:type="WordElement" cat="DETERMINER">
                  <base>the</base>
                </spec>
              </postMod>
            </compl>
          </vp>
        </child>
      </Document>
    </Record>
  </Recording>
</NLGSpec>
    EOF

    # integration test with the real service
    phrase = NlgXmlRealiserBuilder.test_post(xml_payload)
    expect(phrase).to eq("An angioplasty balloon catheter, the D701000000992, was deployed.")
  end

  it "renders XMLRealiserParameterizedTests more complex 'someTest'" do
    xml_payload = dsl.builder {
      record("Hello World") {
        doc {
          str(:child, 'Hello World')
        }
      }
      record("Lexical and spelling variants") {
        doc {
          sp(:child) {
            subj(['the', 'patient'])
            verb('lie', TENSE: 'PAST') {
              postMod(:vp, 'etherise', TENSE: 'PAST') {
                postMod(:pp, 'upon') {
                  compl(:np, ['a', 'table'])
                }
              }
            }
          }
          sp(:child) {
            np(:subj, ['the', 'patient'])
            vp(:vp, 'lie', TENSE: 'PAST') {
              vp(:postMod, 'etherise', TENSE: 'PAST') {
                pp(:postMod, 'upon') {
                  np(:compl, ['a', 'table'])
                }
              }
            }
          }
        }
      }
      record("aAn8Test") {
        list {
          item {
            child(:cp, conj: 'but') {
              coord(:np, ['a', 'thing']) {
                str(:preMod, '18')
              }
              coord(:np, ['a', 'thing']) {
                str(:preMod, '180')
              }
            }
          }
          item {
            cp(:child, conj: 'but') {
              np(:coord, ['a', 'thing']) {
                str(:preMod, '18x')
              }
              np(:coord, ['a', 'thing']) {
                str(:preMod, '08')
              }
            }
          }
          item {
            cp(:child, conj: 'but') {
              np(:coord, ['a', 'thing']) {
                str(:preMod, '11g')
              }
              np(:coord, ['a', 'thing']) {
                str(:preMod, '91x')
              }
            }
          }
          item {
            cp(:child, conj: 'but') {
              np(:coord, ['a', 'thing']) {
                str(:preMod, '8th')
              }
              np(:coord, ['a', 'thing']) {
                str(:preMod, '9th')
              }
            }
          }
          item {
            cp(:child, conj: 'but') {
              np(:coord, ['a', 'thing']) {
                str(:preMod, '11th')
              }
              np(:coord, ['a', 'thing']) {
                str(:preMod, '1100')
              }
            }
          }
          item {
            cp(:child, conj: 'but') {
              np(:coord, ['a', 'thing']) {
                str(:preMod, '11.000')
              }
              np(:coord, ['a', 'thing']) {
                str(:preMod, '11000')
              }
            }
          }
          item {
            cp(:child, conj: 'but') {
              np(:coord, ['a', 'thing']) {
                str(:preMod, '81000')
              }
              np(:coord, ['a', 'thing']) {
                str(:preMod, '180,000')
              }
            }
          }
          item {
            cp(:child, conj: 'but') {
              np(:coord, ['a', 'thing']) {
                str(:preMod, '81,000')
              }
              np(:coord, ['a', 'thing']) {
                str(:preMod, '01834')
              }
            }
          }
          item {
            cp(:child, conj: 'but') {
              np(:coord, ['a', 'thing']) {
                str(:preMod, '8%')
              }
              np(:coord, ['a', 'thing']) {
                str(:preMod, '9%')
              }
            }
          }
          item {
            cp(:child, conj: 'but') {
              np(:coord, ['a', 'thing']) {
                str(:preMod, '8432425')
              }
              np(:coord, ['a', 'thing']) {
                str(:preMod, '42nd')
              }
            }
          }
        }
      }
      record("punctuation problem 1") {
        doc {
          sp(:child) {
            subj(:np, 'there', cat: 'ADVERB')
            verb('be') {
              compl(:np, ['an', 'in-stent restenosis']) {
                preMod(:str, '80 %')
              }
              postMod(:pp, 'in') {
                compl(:np, ['the', 'right coronary artery']) {
                  preMod(:adj, 'proximal')
                }
              }
            }
          }
        }
      }
      record("punctuation problem 2") {
        doc {
          sp(:child) {
            np(:subj, 'there', cat: 'ADVERB')
            vp(:vp, 'be') {
              np(:compl, ['a', 'in-stent restenosis']) {
                str(:preMod, '95 %')
                adj(:preMod, 'eccentric')
              }
              pp(:postMod, 'in') {
                np(:compl, ['the', 'right coronary artery']) {
                  adj(:preMod, 'proximal')
                }
              }
            }
          }
        }
      }
      record("whitespace problem") {
        doc {
          sp(:child) {
            np(:subj, ['the', 'right coronary artery'])
            vp(:vp, 'be') {
              np(:compl, ['a', 'vessel']) {
                pp(:postMod, 'with') {
                  np(:compl, 'luminal irregularities')
                }
              }
            }
          }
        }
      }
      record("whitespace at end of list item") {
        doc(:Document, cat: 'LIST') {
          doc(:child, cat: 'LIST_ITEM') {
            doc(:child, cat: 'SENTENCE') {
              np(:child, 'normal coronary arteries')
            }
          }
          doc(:child, cat: 'LIST_ITEM') {
            doc(:child, cat: 'SENTENCE') {
              np(:child, 'normal left heart hemodynamics')
            }
          }
          doc(:child, cat: 'LIST_ITEM') {
            doc(:child, cat: 'SENTENCE') {
              np(:child, 'normal right heart hemodynamics')
            }
          }
        }
      }
    }.to_xml

    expect(xml_payload).to eq(<<-EOF)
<?xml version="1.0"?>
<NLGSpec xmlns="http://simplenlg.googlecode.com/svn/trunk/res/xml" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <Recording>
    <Record name="Hello World">
      <Document cat="PARAGRAPH">
        <child xsi:type="StringElement">
          <val>Hello World</val>
        </child>
      </Document>
    </Record>
    <Record name="Lexical and spelling variants">
      <Document cat="PARAGRAPH">
        <child xsi:type="SPhraseSpec">
          <subj xsi:type="NPPhraseSpec">
            <head cat="NOUN">
              <base>patient</base>
            </head>
            <spec xsi:type="WordElement" cat="DETERMINER">
              <base>the</base>
            </spec>
          </subj>
          <vp xsi:type="VPPhraseSpec" TENSE="PAST">
            <head cat="VERB">
              <base>lie</base>
            </head>
            <postMod xsi:type="VPPhraseSpec" TENSE="PAST">
              <head cat="VERB">
                <base>etherise</base>
              </head>
              <postMod xsi:type="PPPhraseSpec">
                <head cat="PREPOSITION">
                  <base>upon</base>
                </head>
                <compl xsi:type="NPPhraseSpec">
                  <head cat="NOUN">
                    <base>table</base>
                  </head>
                  <spec xsi:type="WordElement" cat="DETERMINER">
                    <base>a</base>
                  </spec>
                </compl>
              </postMod>
            </postMod>
          </vp>
        </child>
        <child xsi:type="SPhraseSpec">
          <subj xsi:type="NPPhraseSpec">
            <head cat="NOUN">
              <base>patient</base>
            </head>
            <spec xsi:type="WordElement" cat="DETERMINER">
              <base>the</base>
            </spec>
          </subj>
          <vp xsi:type="VPPhraseSpec" TENSE="PAST">
            <head cat="VERB">
              <base>lie</base>
            </head>
            <postMod xsi:type="VPPhraseSpec" TENSE="PAST">
              <head cat="VERB">
                <base>etherise</base>
              </head>
              <postMod xsi:type="PPPhraseSpec">
                <head cat="PREPOSITION">
                  <base>upon</base>
                </head>
                <compl xsi:type="NPPhraseSpec">
                  <head cat="NOUN">
                    <base>table</base>
                  </head>
                  <spec xsi:type="WordElement" cat="DETERMINER">
                    <base>a</base>
                  </spec>
                </compl>
              </postMod>
            </postMod>
          </vp>
        </child>
      </Document>
    </Record>
    <Record name="aAn8Test">
      <Document cat="LIST">
        <child xsi:type="DocumentElement" cat="LIST_ITEM">
          <child xsi:type="CoordinatedPhraseElement" conj="but">
            <coord xsi:type="NPPhraseSpec">
              <head cat="NOUN">
                <base>thing</base>
              </head>
              <spec xsi:type="WordElement" cat="DETERMINER">
                <base>a</base>
              </spec>
              <preMod xsi:type="StringElement">
                <val>18</val>
              </preMod>
            </coord>
            <coord xsi:type="NPPhraseSpec">
              <head cat="NOUN">
                <base>thing</base>
              </head>
              <spec xsi:type="WordElement" cat="DETERMINER">
                <base>a</base>
              </spec>
              <preMod xsi:type="StringElement">
                <val>180</val>
              </preMod>
            </coord>
          </child>
        </child>
        <child xsi:type="DocumentElement" cat="LIST_ITEM">
          <child xsi:type="CoordinatedPhraseElement" conj="but">
            <coord xsi:type="NPPhraseSpec">
              <head cat="NOUN">
                <base>thing</base>
              </head>
              <spec xsi:type="WordElement" cat="DETERMINER">
                <base>a</base>
              </spec>
              <preMod xsi:type="StringElement">
                <val>18x</val>
              </preMod>
            </coord>
            <coord xsi:type="NPPhraseSpec">
              <head cat="NOUN">
                <base>thing</base>
              </head>
              <spec xsi:type="WordElement" cat="DETERMINER">
                <base>a</base>
              </spec>
              <preMod xsi:type="StringElement">
                <val>08</val>
              </preMod>
            </coord>
          </child>
        </child>
        <child xsi:type="DocumentElement" cat="LIST_ITEM">
          <child xsi:type="CoordinatedPhraseElement" conj="but">
            <coord xsi:type="NPPhraseSpec">
              <head cat="NOUN">
                <base>thing</base>
              </head>
              <spec xsi:type="WordElement" cat="DETERMINER">
                <base>a</base>
              </spec>
              <preMod xsi:type="StringElement">
                <val>11g</val>
              </preMod>
            </coord>
            <coord xsi:type="NPPhraseSpec">
              <head cat="NOUN">
                <base>thing</base>
              </head>
              <spec xsi:type="WordElement" cat="DETERMINER">
                <base>a</base>
              </spec>
              <preMod xsi:type="StringElement">
                <val>91x</val>
              </preMod>
            </coord>
          </child>
        </child>
        <child xsi:type="DocumentElement" cat="LIST_ITEM">
          <child xsi:type="CoordinatedPhraseElement" conj="but">
            <coord xsi:type="NPPhraseSpec">
              <head cat="NOUN">
                <base>thing</base>
              </head>
              <spec xsi:type="WordElement" cat="DETERMINER">
                <base>a</base>
              </spec>
              <preMod xsi:type="StringElement">
                <val>8th</val>
              </preMod>
            </coord>
            <coord xsi:type="NPPhraseSpec">
              <head cat="NOUN">
                <base>thing</base>
              </head>
              <spec xsi:type="WordElement" cat="DETERMINER">
                <base>a</base>
              </spec>
              <preMod xsi:type="StringElement">
                <val>9th</val>
              </preMod>
            </coord>
          </child>
        </child>
        <child xsi:type="DocumentElement" cat="LIST_ITEM">
          <child xsi:type="CoordinatedPhraseElement" conj="but">
            <coord xsi:type="NPPhraseSpec">
              <head cat="NOUN">
                <base>thing</base>
              </head>
              <spec xsi:type="WordElement" cat="DETERMINER">
                <base>a</base>
              </spec>
              <preMod xsi:type="StringElement">
                <val>11th</val>
              </preMod>
            </coord>
            <coord xsi:type="NPPhraseSpec">
              <head cat="NOUN">
                <base>thing</base>
              </head>
              <spec xsi:type="WordElement" cat="DETERMINER">
                <base>a</base>
              </spec>
              <preMod xsi:type="StringElement">
                <val>1100</val>
              </preMod>
            </coord>
          </child>
        </child>
        <child xsi:type="DocumentElement" cat="LIST_ITEM">
          <child xsi:type="CoordinatedPhraseElement" conj="but">
            <coord xsi:type="NPPhraseSpec">
              <head cat="NOUN">
                <base>thing</base>
              </head>
              <spec xsi:type="WordElement" cat="DETERMINER">
                <base>a</base>
              </spec>
              <preMod xsi:type="StringElement">
                <val>11.000</val>
              </preMod>
            </coord>
            <coord xsi:type="NPPhraseSpec">
              <head cat="NOUN">
                <base>thing</base>
              </head>
              <spec xsi:type="WordElement" cat="DETERMINER">
                <base>a</base>
              </spec>
              <preMod xsi:type="StringElement">
                <val>11000</val>
              </preMod>
            </coord>
          </child>
        </child>
        <child xsi:type="DocumentElement" cat="LIST_ITEM">
          <child xsi:type="CoordinatedPhraseElement" conj="but">
            <coord xsi:type="NPPhraseSpec">
              <head cat="NOUN">
                <base>thing</base>
              </head>
              <spec xsi:type="WordElement" cat="DETERMINER">
                <base>a</base>
              </spec>
              <preMod xsi:type="StringElement">
                <val>81000</val>
              </preMod>
            </coord>
            <coord xsi:type="NPPhraseSpec">
              <head cat="NOUN">
                <base>thing</base>
              </head>
              <spec xsi:type="WordElement" cat="DETERMINER">
                <base>a</base>
              </spec>
              <preMod xsi:type="StringElement">
                <val>180,000</val>
              </preMod>
            </coord>
          </child>
        </child>
        <child xsi:type="DocumentElement" cat="LIST_ITEM">
          <child xsi:type="CoordinatedPhraseElement" conj="but">
            <coord xsi:type="NPPhraseSpec">
              <head cat="NOUN">
                <base>thing</base>
              </head>
              <spec xsi:type="WordElement" cat="DETERMINER">
                <base>a</base>
              </spec>
              <preMod xsi:type="StringElement">
                <val>81,000</val>
              </preMod>
            </coord>
            <coord xsi:type="NPPhraseSpec">
              <head cat="NOUN">
                <base>thing</base>
              </head>
              <spec xsi:type="WordElement" cat="DETERMINER">
                <base>a</base>
              </spec>
              <preMod xsi:type="StringElement">
                <val>01834</val>
              </preMod>
            </coord>
          </child>
        </child>
        <child xsi:type="DocumentElement" cat="LIST_ITEM">
          <child xsi:type="CoordinatedPhraseElement" conj="but">
            <coord xsi:type="NPPhraseSpec">
              <head cat="NOUN">
                <base>thing</base>
              </head>
              <spec xsi:type="WordElement" cat="DETERMINER">
                <base>a</base>
              </spec>
              <preMod xsi:type="StringElement">
                <val>8%</val>
              </preMod>
            </coord>
            <coord xsi:type="NPPhraseSpec">
              <head cat="NOUN">
                <base>thing</base>
              </head>
              <spec xsi:type="WordElement" cat="DETERMINER">
                <base>a</base>
              </spec>
              <preMod xsi:type="StringElement">
                <val>9%</val>
              </preMod>
            </coord>
          </child>
        </child>
        <child xsi:type="DocumentElement" cat="LIST_ITEM">
          <child xsi:type="CoordinatedPhraseElement" conj="but">
            <coord xsi:type="NPPhraseSpec">
              <head cat="NOUN">
                <base>thing</base>
              </head>
              <spec xsi:type="WordElement" cat="DETERMINER">
                <base>a</base>
              </spec>
              <preMod xsi:type="StringElement">
                <val>8432425</val>
              </preMod>
            </coord>
            <coord xsi:type="NPPhraseSpec">
              <head cat="NOUN">
                <base>thing</base>
              </head>
              <spec xsi:type="WordElement" cat="DETERMINER">
                <base>a</base>
              </spec>
              <preMod xsi:type="StringElement">
                <val>42nd</val>
              </preMod>
            </coord>
          </child>
        </child>
      </Document>
    </Record>
    <Record name="punctuation problem 1">
      <Document cat="PARAGRAPH">
        <child xsi:type="SPhraseSpec">
          <subj xsi:type="NPPhraseSpec">
            <head cat="ADVERB">
              <base>there</base>
            </head>
          </subj>
          <vp xsi:type="VPPhraseSpec">
            <head cat="VERB">
              <base>be</base>
            </head>
            <compl xsi:type="NPPhraseSpec">
              <head cat="NOUN">
                <base>in-stent restenosis</base>
              </head>
              <spec xsi:type="WordElement" cat="DETERMINER">
                <base>an</base>
              </spec>
              <preMod xsi:type="StringElement">
                <val>80 %</val>
              </preMod>
            </compl>
            <postMod xsi:type="PPPhraseSpec">
              <head cat="PREPOSITION">
                <base>in</base>
              </head>
              <compl xsi:type="NPPhraseSpec">
                <head cat="NOUN">
                  <base>right coronary artery</base>
                </head>
                <spec xsi:type="WordElement" cat="DETERMINER">
                  <base>the</base>
                </spec>
                <preMod xsi:type="AdjPhraseSpec">
                  <head cat="ADJECTIVE">
                    <base>proximal</base>
                  </head>
                </preMod>
              </compl>
            </postMod>
          </vp>
        </child>
      </Document>
    </Record>
    <Record name="punctuation problem 2">
      <Document cat="PARAGRAPH">
        <child xsi:type="SPhraseSpec">
          <subj xsi:type="NPPhraseSpec">
            <head cat="ADVERB">
              <base>there</base>
            </head>
          </subj>
          <vp xsi:type="VPPhraseSpec">
            <head cat="VERB">
              <base>be</base>
            </head>
            <compl xsi:type="NPPhraseSpec">
              <head cat="NOUN">
                <base>in-stent restenosis</base>
              </head>
              <spec xsi:type="WordElement" cat="DETERMINER">
                <base>a</base>
              </spec>
              <preMod xsi:type="StringElement">
                <val>95 %</val>
              </preMod>
              <preMod xsi:type="AdjPhraseSpec">
                <head cat="ADJECTIVE">
                  <base>eccentric</base>
                </head>
              </preMod>
            </compl>
            <postMod xsi:type="PPPhraseSpec">
              <head cat="PREPOSITION">
                <base>in</base>
              </head>
              <compl xsi:type="NPPhraseSpec">
                <head cat="NOUN">
                  <base>right coronary artery</base>
                </head>
                <spec xsi:type="WordElement" cat="DETERMINER">
                  <base>the</base>
                </spec>
                <preMod xsi:type="AdjPhraseSpec">
                  <head cat="ADJECTIVE">
                    <base>proximal</base>
                  </head>
                </preMod>
              </compl>
            </postMod>
          </vp>
        </child>
      </Document>
    </Record>
    <Record name="whitespace problem">
      <Document cat="PARAGRAPH">
        <child xsi:type="SPhraseSpec">
          <subj xsi:type="NPPhraseSpec">
            <head cat="NOUN">
              <base>right coronary artery</base>
            </head>
            <spec xsi:type="WordElement" cat="DETERMINER">
              <base>the</base>
            </spec>
          </subj>
          <vp xsi:type="VPPhraseSpec">
            <head cat="VERB">
              <base>be</base>
            </head>
            <compl xsi:type="NPPhraseSpec">
              <head cat="NOUN">
                <base>vessel</base>
              </head>
              <spec xsi:type="WordElement" cat="DETERMINER">
                <base>a</base>
              </spec>
              <postMod xsi:type="PPPhraseSpec">
                <head cat="PREPOSITION">
                  <base>with</base>
                </head>
                <compl xsi:type="NPPhraseSpec">
                  <head cat="NOUN">
                    <base>luminal irregularities</base>
                  </head>
                </compl>
              </postMod>
            </compl>
          </vp>
        </child>
      </Document>
    </Record>
    <Record name="whitespace at end of list item">
      <Document cat="LIST">
        <child xsi:type="DocumentElement" cat="LIST_ITEM">
          <child xsi:type="DocumentElement" cat="SENTENCE">
            <child xsi:type="NPPhraseSpec">
              <head cat="NOUN">
                <base>normal coronary arteries</base>
              </head>
            </child>
          </child>
        </child>
        <child xsi:type="DocumentElement" cat="LIST_ITEM">
          <child xsi:type="DocumentElement" cat="SENTENCE">
            <child xsi:type="NPPhraseSpec">
              <head cat="NOUN">
                <base>normal left heart hemodynamics</base>
              </head>
            </child>
          </child>
        </child>
        <child xsi:type="DocumentElement" cat="LIST_ITEM">
          <child xsi:type="DocumentElement" cat="SENTENCE">
            <child xsi:type="NPPhraseSpec">
              <head cat="NOUN">
                <base>normal right heart hemodynamics</base>
              </head>
            </child>
          </child>
        </child>
      </Document>
    </Record>
  </Recording>
</NLGSpec>
    EOF

    # integration test with the real service
    phrase = NlgXmlRealiserBuilder.test_post(xml_payload)
    expect(phrase).to eq(<<-EOF.strip)
Hello World.


The patient lied etherised upon a table. The patient lied etherised upon a table.


* an 18 thing but a 180 thing
* an 18x thing but a 08 thing
* an 11g thing but a 91x thing
* an 8th thing but a 9th thing
* an 11th thing but a 1100 thing
* an 11.000 thing but an 11000 thing
* an 81000 thing but a 180,000 thing
* an 81,000 thing but a 01834 thing
* an 8% thing but a 9% thing
* an 8432425 thing but a 42nd thing

There is an 80 % in-stent restenosis in the proximal right coronary artery.


There is a 95 %, eccentric in-stent restenosis in the proximal right coronary artery.


The right coronary artery is a vessel with luminal irregularities.


* Normal coronary arteries.
* Normal left heart hemodynamics.
* Normal right heart hemodynamics.
    EOF
  end
end
