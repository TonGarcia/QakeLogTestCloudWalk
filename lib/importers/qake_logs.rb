require 'singleton'

module Importers
  class QakeLogs < Facade
    include Singleton

    def import
      super
      self.model = 'Exam'
      self.file_name = 'qgames.log'
    end
  end
end
