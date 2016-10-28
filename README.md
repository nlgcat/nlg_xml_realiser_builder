# Simple NLG compatible XML Realiser Builder

This is still not a full featured builder for Simple NLG but the goal is to make it easier to compose the XML Realiser recordings.

There is an online service at https://nlg-service.herokuapp.com which embeds SimpleNLG in a web service.

Check out [nlg-service](https://github.com/Codeminer42/nlg_service) to see the Rails-API running under JRuby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nlg_xml_realiser_builder'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nlg_xml_realiser_builder

## Usage

The XML Realiser format can be checked through it's [XML Schema](https://github.com/simplenlg/simplenlg/blob/master/src/main/resources/xml/RealizerSchema.xsd) which is roughly implemented in this DSL, with most of the relevant attributes validations as well.

The usage is mainly nesting the main builder elements:

* Sentence-like Phrase - SPhraseSpec - `sp(tag, options, &block)`
* Noun Phrase - NPPhraseSpec - `np(tag, noun, options, &block)`
* Verb Phrase - VPPhraseSpec - `vp(tag, verb, options, &block)`
* Adjective Phrase - AdjPhraseSpec - `adj(tag, adjective, options, &block)`
* Adverbial Phrase - AdvPhraseSpec - `adv(tag, adverb, options, &block)`
* Propositional Phrase - PPPhraseSpec - `pp(tag, preposition, options, &block)`
* Coordination between 2 or more phrases - CoordinatedPhraseElement - `cp(tag, options, &block)`

Example:

```
dsl = NlgXmlRealiserBuilder::DSL.new
dsl.builder {
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
}.to_xml

```

Resulting XML:

```
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
```

From here you can use the [NLG Service Web Service](https://github.com/Codeminer42/nlg_service) to transform this XML into a grammatically and ortographically correct natural English phrase.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Codeminer42/nlg_xml_realiser_builder.


## License

The gem is available as open source under the terms of the [LGPL-3.0 License](https://opensource.org/licenses/LGPL-3.0).

