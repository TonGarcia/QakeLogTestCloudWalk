# frozen_string_literal: true

require 'progress_bar'
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
      obj_players = []

      line_count = `wc -l "#{dataset_path}"`.strip.split(' ')[0].to_i
      bar = ProgressBar.new(line_count)
      
      File.open(dataset_path) do |f|
        game = nil
        while line = f.gets
          bar.increment!
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
            
            unless players.include? killer
              players << killer
              player = Player.find_or_create_by(name: killer)
              obj_players << player
              GamePlayer.create(game_id: game&.id, player_id: player.id)
            end

            unless players.include? killed
              players << killed
              player = Player.find_or_create_by(name: killed)
              obj_players << player
              GamePlayer.create(game_id: game&.id, player_id: player.id)
            end
            
            Kill.create(
              killed_id: obj_players[players.index(killed)].id, 
              killer_id: obj_players[players.index(killer)].id,
              cause: Cause.name_arr(cause, idx=true),
              game_id: game
            )
          end

          # check if it is end of a game
          unless (line.strip =~ /[0-9]+:[0-9]+ ShutdownGame:/).nil?
            game.save
            game = nil
          end

          count += 1
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
