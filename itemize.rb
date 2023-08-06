require 'freesound'
Freesound.api_key = ENV['FREESOUND_API_KEY'] || fail( "ERROR: Missing env var FREESOUND_API_KEY")
@freesound_client = Freesound::Client.new
@project_type = :M8_BUNDLE


def freesound_attribution(id)
  response = @freesound_client.sound(id)
  fail("ERROR: client failed (#{response.status})") unless response.status == 200
  ["Derived from '#{response.data['name']}' by #{response.data['username']}", "License: #{response.data['license']}",  "URL: #{response.data['url']}"]
end

def unknown_attribution(filename)
  ["FIXME: Unknown attribution"]
end

attributions = {}
ARGV.each do |filepath|
  filename = File.basename filepath
  next unless filename =~ /\.wav$/i

  filename.sub!(/^\d\d\d_/,'') if @project_type == 'M8'

  attribution_lines = []
  if filename =~ /(\d{4}\d*)/
    attribution_lines = freesound_attribution(Integer($1))
  else
    attribution_lines = unknown_attribution(filename)
  end
  attributions[filename] = attribution_lines
end

attributions_summary = attributions.map{ |k,v| "- #{k}\n#{v.map{|x| "  #{x}"}.join("\n")}\n" }.join("\n")
puts attributions_summary

out_file='_sample_attributions.md'
File.open(out_file,'w'){|f| f.puts attributions_summary }
STDERR.puts("\nWrote results to #{out_file}\n\nFINIS")
