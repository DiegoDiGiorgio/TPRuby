module Polycon
  module Models      
    module AppointmentsModel
      class AppModel

        def crear(date, professional, name, surname, phone, notes)
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

        def show(date, professional)
          date=date.gsub(" ","_")
          if((Dir.exists?(Dir.home() + "/.polycon/#{professional}")) && (File.exist?(Dir.home() + "/.polycon/#{professional}/#{date}.paf")))
            file = File.open(Dir.home() + "/.polycon/#{professional}/#{date}.paf", mode: "r")
            puts file.readlines
            file.close
          else
            p = Dir.home() + "/.polycon/#{professional}/#{date}.paf"
            puts "El profesional o el turno dado no existe !"
          end
        end

        def cancel(date, professional)
          date=date.gsub(" ","_")
          if((Dir.exists?(Dir.home() + "/.polycon/#{professional}")) && (File.exist?(Dir.home() + "/.polycon/#{professional}/#{date}.paf")))
            File.delete(Dir.home() + "/.polycon/#{professional}/#{date}.paf")
          else
            puts "El profesional o el turno dado no existe !"
          end
        end

        def cancelAll(professional)
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

        def list(professional, date)
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

        def reschedule(old_date, new_date, professional)
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
            puts "el profesional o el turno dado no existe !"
          end
        end

        def edit(date, professional, options)
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
