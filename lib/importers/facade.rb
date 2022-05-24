# frozen_string_literal: true

require 'singleton'

module Importers
  class Facade
    include Singleton
    attr_accessor :file_name, :model, :specific_attrs, :additional_column, :additional_val

    def load_and_persist(show_progress = false, pagination = 0, limit = nil)
      start_time = Time.now
      puts "Opening log at #{start_time}".colorize(:yellow)
      dataset_path = File.join(Rails.root, 'datasource', file_name)

      count = 0
      item_id = 0
      players = []
      File.open(dataset_path) do |f|
        game = nil
        while line = f.gets
          line = line.strip
          
          # check if it is a skip line (log breaker)
          next unless (line =~ /[0-9]+:[0-9]+ -{3,}/).nil?

          # check if it is starting a new game
          unless (line =~ /[0-9]+:[0-9]+ InitGame:/).nil?
            game = Game.create
            next
          end

          # check if it is kill
          unless (line =~ /[0-9]+:[0-9]+ Kill:/).nil?
            matcher = line.match(/[0-9]+ [0-9]+ [0-9]+: (.*) killed (.*) by (.*)/)
            next if matcher.nil?
            kill_data = matcher.captures
            killer = kill_data[0]
            killed = kill_data[1]
            cause = kill_data[2]
            
            if killer != '<world>'
              unless players.include? killer
                players << killer
                player = Player.find_or_create_by(name: killer)
                GamePlayer.create(game_id: game.id, player_id: player.id)
              end
            end
          end

          # check if it is end of a game
          unless (line.strip =~ /[0-9]+:[0-9]+ ShutdownGame:/).nil?
            game.save
            game = nil
          end

          count += 1

          # TODO create UI loading on the terminal
          if show_progress && (pagination.zero? || (count % pagination).zero?)
            # p "#{count} iterated registers at #{Time.now}"
            # start_time = Time.now
            # puts 'Insertion started'.colorize(:yellow)
            # import_headers = specific_attrs.nil? ? headers - excluded_attrs : specific_attrs
            # import_headers += additional_column if !additional_column.nil? && additional_column.length.positive?
            #
            # import_headers[0] = 'NU_PRODUTO' unless import_headers[0].index('NU_PRODUTO').nil?
            # import_headers[0] = 'CO_SEQ_PRODUTO' unless import_headers[0].index('CO_SEQ_PRODUTO').nil?
            #
            # model.classify.safe_constantize.import import_headers, registers, validate: false
            # end_time = Time.now
            # p "Spent Time (insertion): #{end_time - start_time}"
            #
            # # count == 1000000 ? break : count=count+1 # TODO Comment if not a test
            # registers = [] # free memory
            #
            # break if limit && count == limit
          end

        end

        unless show_progress || registers.length.positive?
          import_headers = specific_attrs.nil? ? headers - excluded_attrs : specific_attrs
          model.classify.safe_constantize.import import_headers, registers, validate: false
        end
      end

      end_time = Time.now
      puts "Log #{file_name} finished at #{end_time}, elapsed time: #{end_time - start_time}".colorize(:green)
    end
  end
end
