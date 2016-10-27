require "spec_helper"

describe NlgXmlRealiserBuilder do
  let(:dsl) { NlgXmlRealiserBuilder::DSL.new }
  it "has a version number" do
    expect(NlgXmlRealiserBuilder::VERSION).not_to be nil
  end

  it "renders the root level structure" do
    expect(dsl.builder.to_xml).to eq(<<-EOF)
<?xml version="1.0"?>
<NLGSpec xmlns="http://simplenlg.googlecode.com/svn/trunk/res/xml" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <Recording>
    <Record/>
  </Recording>
</NLGSpec>
    EOF
  end

  it "renders a complete example of a NLGSpec" do
    expect(dsl.builder {
      doc {
        sp( :child ) {
          np( :subj, 'there', cat: 'ADVERB' )
          vp( :vp, 'be' ) {
            np( :compl, [ 'a', 'restenosis' ] ) {
              cp( :preMod ) {
                adj( :coord, 'eccentric' )
                adj( :coord, 'tubular' )
              }
              str( :postMod, '(18 mm x 1 mm)' )
            }
            pp( :postMod, 'from') {
              vp( :preMod, 'extend', FORM: 'GERUND')
              np( :compl, ['the'] ) {
                adj( :preMod, 'proximal' )
              }
              pp( :postMod, 'to' ) {
                np( :compl, [ 'a', 'right coronary artery' ] ) {
                  adj( :preMod, 'mid' )
                }
              }
            }
            pp( :postMod, 'with' ) {
              np( :compl, 'TIMI 1 flow' )
            }
          }
        }
      }
    }.to_xml).to eq(<<-EOF)
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
              <spec cat="DETERMINER">
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
                <spec cat="DETERMINER">
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
                  <spec cat="DETERMINER">
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
end
