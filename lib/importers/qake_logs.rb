require 'singleton'

module Importers
  class QakeLogs < Facade
    include Singleton

    def initialize
      super
      self.file_name = 'qgames.log'
    end
  end
end
