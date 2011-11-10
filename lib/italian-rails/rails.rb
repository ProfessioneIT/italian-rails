module ItalianRails

  class Engine < ::Rails::Engine
    engine_name :italian_rails
  end

  def self.config(&block)
    @@config ||= Configuration.new
    yield @@config if block
    @@config
  end
end
