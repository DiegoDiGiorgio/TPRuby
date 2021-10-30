module Polycon
  module Commands
     module Writer
      class Write < Dry::CLI::Command

        argument :date, required: true, desc: 'date of the day to export'

        def call(date:, **)
           Polycon::Models::WriterModel::Writer.prueba(date)
        end

      end
    end
  end
end