require 'rest-client'

def get_url(formula)
  File.open(formula).grep(/url/).first.split(' ')[1].delete('",')
end

formulae_directory = ENV['FORMULAE_DIR']

puts "Running checks against formulae in #{formulae_directory}."

Dir.glob("#{formulae_directory}/*.rb").each do |formula|
  next if %w[. ..].include?(formula)

  url = get_url(formula)
  formula_name = File.basename(formula, File.extname(formula)).split('/').last

  begin
    RestClient.get(url) do |response|
      puts "#{formula_name}: #{response.code} for #{url}"
    end
  rescue RestClient::SSLCertificateNotVerified
    puts "#{formula_name}: SSL errors for #{url}"
    next
  rescue RestClient::Exceptions::OpenTimeout
    puts "#{formula_name}: timeout for #{url}"
    next
  rescue SocketError
    puts "#{formula_name}: socket error for #{url}"
    next
  rescue ArgumentError
    # TODO: This happens if the `url` stanza is commented out.
    puts "#{formula_name}: argument error for #{url}"
    next
  rescue Errno::ECONNREFUSED
    puts "#{formula_name}: connection refused for #{url}"
    next
  end
end
