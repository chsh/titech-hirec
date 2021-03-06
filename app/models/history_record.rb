class HistoryRecord < ApplicationRecord

  concerning :FieldDefinitionFeature do
    included do
      FIELDS = [
          :classification_l, :classification_m,
          :filename, :year, :accept_method, :creator,
          :source_1, :source_2, :source_3,
          :accept_date,
          :store_location_shelf_name, :store_location_shelf_id1,
          :store_location_shelf_id2,
          :media_type, :duplicatable, :use_limit,
          :size, :old_maintainer, :misc
      ]
      FIELDS_MAP_SOURCE = FIELDS.map.with_index { |value, index|
        [index+1, value]
      }
      FIELDS_MAP = Hash[FIELDS_MAP_SOURCE]
      store_accessor :data, *FIELDS
    end
  end

  concerning :ImportFeature do
    class_methods do
      def import(file)
        lines = File.open(file).readlines.map { |line| line.strip.split(/\t/) }
        lines.each do |words|
          attrs = map_fields(words)
          HistoryRecord.where(uid: attrs[:uid]).first_or_create(attrs)
        end
      end
      private
      def map_fields(words)
        hash = {}
        words.each_with_index do |value, index|
          key = FIELDS_MAP[index]
          if key.present?
            hash[FIELDS_MAP[index]] = value
          end
        end
        hash[:uid] = words[0] # unique identifier
        hash
      end
    end
  end
  concerning :ImportXlsxFeature do
    class_methods do
      def import_xlsx(file, start_row)
        xlsx = Roo::Excelx.new(file)
        sheet = xlsx.sheet(0)
        sheet.each_row_streaming(offset: start_row) do |row|
          row_s = row.to_a.map { |w| w.blank? ? nil : w.to_s }
          pp row_s
          attrs = map_fields(row_s)
          HistoryRecord.where(uid: attrs[:uid]).first_or_create(attrs)
        end
      end
    end
  end
  concerning :SortFeature do
    included do
      scope :uid_order, -> { order(:uid) }
    end
  end
  concerning :SchemaFeature do
    def num_year
      return nil unless self.year.present?
      self.year.gsub(/年度$/, '').gsub(/\[(.+?)\]/, '\1')
    end

    def schema
      @schema ||= begin
        "tta:#{self.uid} schema:dateCreated:\"#{self.num_year}\""
      end
    end
  end
end
