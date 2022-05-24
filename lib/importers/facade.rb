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
      headers = []
      registers = []
      excluded_attrs = %w[CO_MUNICIPIO_IBGE_PAC NU_REGISTRO_ANVISA QT_CNS_PACIENTE QT_CNES QT_CNPJ_FABRICANTE QT_PRESCRITOR QT_CID10_PRESCRICAO VL_MOVIMENTACAO]

      item_id = 0
      File.open(dataset_path) do |f|
        while line = f.gets
          register = []
          line = line.strip
          line.gsub!('"', '') unless line.index('"').nil?
          columns = line.split(';')
          columns = line.split(',') if columns.length == 1
          skip_register = false

          if count.zero?
            headers = columns
            count += 1
            next
          end

          columns.each_with_index do |val, i|
            attr = headers[i]
            next if excluded_attrs.include?(attr) || (!specific_attrs.nil? && !specific_attrs.include?(attr)) || attr.nil?

            # next if (attr == 'NU_CATMAT' && val.index('BR').nil?) || val.nil? || (attr == 'DS_PRODUTO' && val.length < 10)

            case val
            when 'false'
              val = false
            when 'true'
              val = true
            end

            unless attr.index('_id').nil?
              val = nil if val == ''
              val = val.to_i if val.is_a?(String)
            end

            if !attr.nil? && (!attr.index('vl').nil? || !attr.index('VL').nil?)
              if val.is_a?(String) && !val.index(',').nil?
                val.gsub! '.', ''
                val.gsub! ',', '.'
                val = "0#{val}" if val[0] == '.'
              end

              val = 0 if val == ''
              val_new = BigDecimal(val)
              val = val_new
            end

            print(attr) if attr.nil?

            if !attr.index('NU').nil? || !attr.index('CO').nil?
              val = val.strip
              if val.length.zero?
                val = 0
              else
                skip_attrs = %w[NU_VOLUME_MEDICAMENTO NU_TELEFONE NU_FAX CO_REGIAO_SAUDE CO_MICRO_REGIAO NU_ALVARA NU_LONGITUDE NU_LATITUDE NU_CNPJ NU_CPF]
                if !skip_attrs.include?(attr) && val.match(/[a-zA-Z]/).nil? && val.match(%r{[+%/]}).nil? && (val.index('0') != 0) && val.index('.').nil?
                  val = Integer(val)
                end
              end
            end

            register << val
          end

          if (!additional_column.nil? && additional_column.length.positive?) && (!additional_val.nil? && additional_val.length.positive?)
            additional_column.each_with_index do |_, i|
              register << additional_val[i]
            end
          end

          import_headers = specific_attrs.nil? ? headers - excluded_attrs : specific_attrs
          import_headers += additional_column if !additional_column.nil? && additional_column.length.positive?

          if headers.length != register.length
            count_missing_elements = headers.length - register.length
            count_missing_elements.times do |_|
              register << ''
            end
          end

          next if skip_register
          registers << register if register.length == import_headers.length
          count += 1

          if show_progress && (pagination.zero? || (count % pagination).zero?)
            p "#{count} iterated registers at #{Time.now}"
            start_time = Time.now
            puts 'Insertion started'.colorize(:yellow)
            import_headers = specific_attrs.nil? ? headers - excluded_attrs : specific_attrs
            import_headers += additional_column if !additional_column.nil? && additional_column.length.positive?

            import_headers[0] = 'NU_PRODUTO' unless import_headers[0].index('NU_PRODUTO').nil?
            import_headers[0] = 'CO_SEQ_PRODUTO' unless import_headers[0].index('CO_SEQ_PRODUTO').nil?

            model.classify.safe_constantize.import import_headers, registers, validate: false
            end_time = Time.now
            p "Spent Time (insertion): #{end_time - start_time}"

            # count == 1000000 ? break : count=count+1 # TODO Comment if not a test
            registers = [] # free memory

            break if limit && count == limit
          end

          item_id += 1
          # puts "Item ID: ##{item_id}"
          # if item_id == 248
          #   puts "bugged at: ##{item_id}"
          # end
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
