require 'ruby-jmeter'
require 'trollop'

opts = Trollop::options do
  opt :mode, "Mode to run in, dev (will load local jmeter) or prod (generate flood from ec2)", :default => 'dev', :type => :string
  opt :num_threads, "The number of threads, ie virtual users, per load generator", :type => :integer
  opt :loops, "How many times to loop each thread <only applicable to dev mode>", :type => :integer
  opt :rampup, "Time in seconds to ramp your load up", :type => :integer
  opt :api_key, "flood.io api key <only applicable to prod mode>", :type => :string
  opt :flood_name, "Unique name of the flood to be ran <only applicable to prod mode>", :type => :string, default: "Squarefoot PDP Test #{Time.now}"
  opt :region, "Region to generate the flood from <only applicable to prod mode>", :type => :string, default: 'ap-southeast-1'
  opt :free_flood, "Do a light run against the free flood node", :default => false
  opt :duration, "How long time you want to run", :type => :integer
  opt :api_grid, "flood.io api grid <only applicable to prod mode>", :type => :string

end
$end

if opts[:mode].eql? 'prod'
  opts[:num_threads] ||= 75
  opts[:rampup] ||= 25
  opts[:duration] ||= 600
  opts[:loops] = nil
  opts[:continue_forever] = false
  opts[:region] = nil if opts[:free_flood]
  Trollop::die :api_key, "You must provide an API key to run a flood" unless opts[:api_key]
  warn("\n***** You are about to run a real load test with details: threads per load generator: #{opts[:num_threads]} and ramp #{opts[:rampup]} seconds")
  warn("Press enter to continue. Control-c to cancel")
  STDIN.gets
else
  opts[:num_threads] ||= 1
  opts[:loops] ||= 5
  opts[:rampup] ||= 0
  opts[:continue_forever] = false
end

# Let' do it!
host = 'legacy.prelaunch.squarefoot.com.hk'
test do

  cache clear: true
  cookies clear: true

  defaults image_parser: true,
           embedded_url_re: '.*legacy.prelaunch.squarefoot.com.hk.*',
           domain: host

  header [
             {name: 'Host', value: host},
             {name: 'User-Agent', value: 'Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; Trident/6.0)'},
             {name: 'Accept', value: 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'},
             {name: 'Connection', value: 'keep-alive'},
             {name: 'Accept-Encoding', value: 'gzip, deflate'},
         ]

  threads count: opts[:num_threads], rampup: opts[:rampup], duration: opts[:duration] do
    csv_data_set_config filename: "listing_ids.csv", variableNames: 'listing_id'

    think_time 1000, 5000
    visit "/property/${listing_id}", name: 'Squarefoot PDP Specific Performance Test'
  end
  view_results if opts[:mode] == 'dev'

#end.run(gui: true)
end.flood(opts[:api_key], {privacy: 'public', files: ["#{Dir.pwd}/listing_ids.csv"], region: opts[:region], name: opts[:flood_name], grid: opts[:api_grid]})