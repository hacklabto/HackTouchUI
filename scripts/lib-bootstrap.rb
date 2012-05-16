# My Bootstrapping Library
# ----------------------------

module TakeANap
  def homebrew?
   system("brew -v")
  end

  def yum?
    # TODO
  end

  def aptitude?
    # TODO
  end

  def redis?
   system("redis-server -v")
  end

  def installed_gem?(gem_name)
    begin
      require gem_name
      return true
    rescue LoadError
      return false
    end
  end

  def install_gem(gem_name)
    puts "#{gem_name} not installed. Installing #{gem_name}.."
    system("gem install #{gem_name}")
  end


  class SystemDependanciesBuilder
    attr_accessor :list

    def initialize
      @list = []
    end

    def unix_package(name, options = {}, &block)
      if options[:check].is_a? String
        options[:check_unix_cmd] = options[:check]
        options[:check] = lambda {|g| system(g[:check_unix_cmd])}
      end
      options[:install] = block unless options.has_key? :install
      @list.push options.merge name: name, type: :gem
    end

    def gem(name)
      @list.push name: name, type: :gem, check: lambda {|g| installed_gem? g[:name]}, install: lambda {|g| install_gem g[:name]}
    end
  end

  def system_dependancies(&block)
    # Gather dependancies using the block
    builder = SystemDependanciesBuilder.new
    builder.instance_eval(&block)

    # Figure out which dependancies are missing or return if everything is installed
    missing = builder.list.reject {|d| d[:check].call(d)}
    return if missing.length == 0

    # Ask the user if it's ok to install the dependancies
    puts "It looks like you are missing the following system requirements: #{missing.collect{|d|d[:name]}.join(", ")}"
    print "Would you mind if we installed them for you? (y/n) "
    exit unless ["y", "yes"].include? gets.chomp.downcase

    # install anything that is missing
    missing.each { |d| d[:install].call(d) }
  end

end