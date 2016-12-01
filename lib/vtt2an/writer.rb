require 'active_support/inflector'

module Vtt2An

  class Writer
    
    attr_accessor :webvtt
    
    def initialize(webvtt)
      @webvtt = webvtt
    end
    
    def write

      puts %Q{
      <akomaNtoso>
        <debate>
          <meta>
            <references>
      }
      webvtt.speakers.each do |speaker|
        puts "        <TLCPerson href=\"\" id=\"#{speaker.parameterize}\" showAs=\"#{speaker}\"/>"
      end
      puts %Q{
            </references>
          </meta>
          <debateBody>
            <debateSection>        
              <heading>Title</heading>
      }
      last_speaker = nil
      webvtt.cues.each do |cue|
        if cue.speaker != last_speaker
          puts "          </p>"
          puts "        </speech>" unless last_speaker.nil?
          puts "        <speech by=\"##{cue.speaker.parameterize}\">"
          print "          <p>"
          last_speaker = cue.speaker
        end
        print cue.text + " "
      end
      puts %Q{
                </p>
              </speech>
            </debateSection>
          </debateBody>
        </debate>
      </akomaNtoso>
      }   
    end
    
  end
  
end