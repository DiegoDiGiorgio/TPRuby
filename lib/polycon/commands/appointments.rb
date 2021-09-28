module Polycon
  module Commands
    module Appointments
      class Create < Dry::CLI::Command
        desc 'Create an appointment'

        argument :date, required: true, desc: 'Full date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'
        option :name, required: true, desc: "Patient's name"
        option :surname, required: true, desc: "Patient's surname"
        option :phone, required: true, desc: "Patient's phone number"
        option :notes, required: false, desc: "Additional notes for appointment"

        example [
          '"2021-09-16 13:00" --professional="Alma Estevez" --name=Carlos --surname=Carlosi --phone=2213334567'
        ]

        def call(date:, professional:, name:, surname:, phone:, notes: nil)
          #warn "TODO: Implementar creación de un turno con fecha '#{date}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          if(date<Time.now.strftime("%Y-%m-%d %H:%M"))
            puts "No se puede asignar un turno a una fecha posterior al dia de hoy !"
            return
          end
          if(!File.exists?(Dir.home() + "/.polycon/#{professional}"))
            puts "El Profesional #{professional} no existe !"
            return
          end
          turno=date.gsub("","")
          turno=turno.gsub(" ","_")
          if(File.exists?(Dir.home()+"/.polycon/#{professional}/#{turno}.paf"))
            puts "El profesional ya tiene un turno asignado para la fecha #{date}"
          else
            file = File.new(Dir.home()+"/.polycon/#{professional}/#{turno}.paf", 'w')
            file.write("#{surname}\n")
            file.write("#{name}\n")
            file.write("#{phone}\n")
            if (notes)
              file.write("#{notes}\n")
            end
            file.close()
            puts "La reserva para el dia #{date} se ha realizado con exito !"

          end
        end
      end

      class Show < Dry::CLI::Command
        desc 'Show details for an appointment'

        argument :date, required: true, desc: 'Full date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'

        example [
          '"2021-09-16 13:00" --professional="Alma Estevez" # Shows information for the appointment with Alma Estevez on the specified date and time'
        ]

        def call(date:, professional:)
          #warn "TODO: Implementar detalles de un turno con fecha '#{date}' y profesional '#{professional}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          date=date.gsub(" ","_")
          if((Dir.exists?(Dir.home() + "/.polycon/#{professional}")) && (File.exist?(Dir.home() + "/.polycon/#{professional}/#{date}.paf")))
            file = File.open(Dir.home() + "/.polycon/#{professional}/#{date}.paf", mode: "r")
            puts file.readlines
            file.close
          else
            p = Dir.home() + "/.polycon/#{professional}/#{date}.paf"
            puts "El profesional o el turno dado no existe ! #{p}"
          end
        end
      end

      class Cancel < Dry::CLI::Command
        desc 'Cancel an appointment'

        argument :date, required: true, desc: 'Full date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'

        example [
          '"2021-09-16 13:00" --professional="Alma Estevez" # Cancels the appointment with Alma Estevez on the specified date and time'
        ]

        def call(date:, professional:)
          #warn "TODO: Implementar borrado de un turno con fecha '#{date}' y profesional '#{professional}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          date=date.gsub(" ","_")
          if((Dir.exists?(Dir.home() + "/.polycon/#{professional}")) && (File.exist?(Dir.home() + "/.polycon/#{professional}/#{date}.paf")))
            File.delete(Dir.home() + "/.polycon/#{professional}/#{date}.paf")
          else
            puts "El profesional o el turno dado no existe !"
          end
        end
    end

      class CancelAll < Dry::CLI::Command
        desc 'Cancel all appointments for a professional'

        argument :professional, required: true, desc: 'Full name of the professional'

        example [
          '"Alma Estevez" # Cancels all appointments for professional Alma Estevez',
        ]

        def call(professional:)
          #warn "TODO: Implementar borrado de todos los turnos de la o el profesional '#{professional}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          if((Dir.exists?(Dir.home() + "/.polycon/#{professional}")))
            turnos = Dir.entries((Dir.home() + "/.polycon/#{professional}"))
            turnos.delete(".")
            turnos.delete("..")
            for turno in turnos do
              File.delete(Dir.home() + "/.polycon/#{professional}/" + turno)
            end
          else
            puts "el profesional dado no existe !"
          end
        end
      end

      class List < Dry::CLI::Command
        desc 'List appointments for a professional, optionally filtered by a date'

        argument :professional, required: true, desc: 'Full name of the professional'
        option :date, required: false, desc: 'Date to filter appointments by (should be the day)'

        example [
          '"Alma Estevez" # Lists all appointments for Alma Estevez',
          '"Alma Estevez" --date="2021-09-16" # Lists appointments for Alma Estevez on the specified date'
        ]

        def call(professional:, date: nil)
          #warn "TODO: Implementar listado de turnos de la o el profesional '#{professional}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          if((Dir.exists?(Dir.home() + "/.polycon/#{professional}")))
            turnos = Dir.entries((Dir.home() + "/.polycon/#{professional}"))
            turnos.delete(".")
            turnos.delete("..")
            if (!date)
              for turno in turnos do
                puts turno
              end
            else
              turnos.delete_if {|turno| !(turno.include?(date))}
              for turno in turnos do
                puts turno
              end
            end
          else
            puts "el profesional dado no existe !"
          end
        end
      end

      class Reschedule < Dry::CLI::Command
        desc 'Reschedule an appointment'

        argument :old_date, required: true, desc: 'Current date of the appointment'
        argument :new_date, required: true, desc: 'New date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'

        example [
          '"2021-09-16 13:00" "2021-09-16 14:00" --professional="Alma Estevez" # Reschedules appointment on the first date for professional Alma Estevez to be now on the second date provided'
        ]

        def call(old_date:, new_date:, professional:)
          #warn "TODO: Implementar cambio de fecha de turno con fecha '#{old_date}' para que pase a ser '#{new_date}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          old_date=old_date.gsub(" ","_")
          new_date=new_date.gsub(" ","_")
          if((Dir.exist?(Dir.home() + "/.polycon/#{professional}")) && (File.exist?(Dir.home() + "/.polycon/#{professional}/#{old_date}.paf")))
            if (!File.exist?(Dir.home() + "/.polycon/#{professional}/#{new_date}.paf"))
              File.rename((Dir.home() + "/.polycon/#{professional}/#{old_date}.paf"), (Dir.home() + "/.polycon/#{professional}/#{new_date}.paf"))
              puts "el turno se reprogramo exitosamente !"
            else
              puts "la fecha a la que se quiere realizar el cambio ya esta ocupada ! #{new_date}"
            end
          else
            p=Dir.home() + "/.polycon/#{professional}/#{new_date}.paf"
            puts "el profesional o el turno dado no existe ! #{p}"
          end
        end
      end

      class Edit < Dry::CLI::Command
        desc 'Edit information for an appointments'

        argument :date, required: true, desc: 'Full date for the appointment'
        option :professional, required: true, desc: 'Full name of the professional'
        option :name, required: false, desc: "Patient's name"
        option :surname, required: false, desc: "Patient's surname"
        option :phone, required: false, desc: "Patient's phone number"
        option :notes, required: false, desc: "Additional notes for appointment"

        example [
          '"2021-09-16 13:00" --professional="Alma Estevez" --name="New name" # Only changes the patient\'s name for the specified appointment. The rest of the information remains unchanged.',
          '"2021-09-16 13:00" --professional="Alma Estevez" --name="New name" --surname="New surname" # Changes the patient\'s name and surname for the specified appointment. The rest of the information remains unchanged.',
          '"2021-09-16 13:00" --professional="Alma Estevez" --notes="Some notes for the appointment" # Only changes the notes for the specified appointment. The rest of the information remains unchanged.',
        ]

        def call(date:, professional:, **options)
          warn "TODO: Implementar modificación de un turno de la o el profesional '#{professional}' con fecha '#{date}', para cambiarle la siguiente información: #{options}.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          date=date.gsub(" ", "_")
          if  (!File.exist?(Dir.home()+"/.polycon/#{professional}/#{date}.paf"))
            puts "No existe un turno para #{professional} el día #{date}"
            return
          end
          if (! Dir.exists?(Dir.home()+"/.polycon/#{professional}"))
            puts "#{professional} no existe en la base de datos"
            return
          end

          if options[:surname]
            lines = File.readlines(Dir.home()+"/.polycon/#{professional}/#{date}.paf")
            lines[0] = options[:surname] << $/
            File.delete(Dir.home()+"/.polycon/#{professional}/#{date}.paf")
            File.open(Dir.home()+"/.polycon/#{professional}/#{date}.paf", 'w') { |f| f.write(lines.join) }
            puts "Se ha cambiado el apellido a #{options[:surname]}"
          end
          if options[:name]
            lines = File.readlines(Dir.home()+"/.polycon/#{professional}/#{date}.paf")
            lines[1] = options[:name] << $/
            File.delete(Dir.home()+"/.polycon/#{professional}/#{date}.paf")
            File.open(Dir.home()+"/.polycon/#{professional}/#{date}.paf", 'w') { |f| f.write(lines.join) }
            puts "Se ha cambiado el nombre a #{options[:name]}"
          end
          if options[:phone]
            lines = File.readlines(Dir.home()+"/.polycon/#{professional}/#{date}.paf")
            lines[2] = options[:phone] << $/
            File.delete(Dir.home()+"/.polycon/#{professional}/#{date}.paf")
            File.open(Dir.home()+"/.polycon/#{professional}/#{date}.paf", 'w') { |f| f.write(lines.join) }
            puts "Se ha cambiado el telefono a #{options[:phone]}"
          end
          if options[:notes]
            lines = File.readlines(Dir.home()+"/.polycon/#{professional}/#{date}.paf")
            lines[3] = options[:notes] << $/
            File.delete(Dir.home()+"/.polycon/#{professional}/#{date}.paf")
            File.open(Dir.home()+"/.polycon/#{professional}/#{date}.paf", 'w') { |f| f.write(lines.join) }
            puts "Se han cambiado las notas adicionales a #{options[:notes]}"
          end
        end
      end
    end
  end
end
