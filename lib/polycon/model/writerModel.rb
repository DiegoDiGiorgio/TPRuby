module Polycon
	module Models      
		module WriterModel
      require "erb"

			class Writer

        def self.prueba(date)
         fecha = self.getData(date)

         @dia = date
         @horas = ["15:30", "16:00"]
         @turnos = fecha.getTurno()


          #logica de la impresion a html
          template = File.read(Dir.home()+'/Escritorio' +'/template.html')
          result = ERB.new(template).result(binding)
          File.open((Dir.home()+'/Escritorio' +'/filename.html'), 'w+') do |f|
            f.write result
          end
          
        end

        def self.getData(date)
          profesionales = []
          Dir.foreach((Dir.home() + "/.polycon")){ |dir|
            profesionales << dir
          }
          profesionales.delete(".")
          profesionales.delete("..")

          turnos=[]
          profesionales.each{ |pro|
            Dir.foreach((Dir.home() + "/.polycon/#{pro}")){ |turno|
              if turno != "." && turno != ".."
                nombre_paciente =""
                line_num=0 
                File.open(Dir.home() + "/.polycon/#{pro}/#{turno}").each do |line| 
                  if line_num <= 1
                    nombre_paciente += line
                  end
                  line_num +=1
                end
                  
                begin
                  turnos.select{|tur| (tur.getHora() )== turno}[0].addTurn([pro, nombre_paciente])
                rescue
                  t = Turno.new(turno)
                  t.addTurn([pro, nombre_paciente])
                  turnos << t
                end
              end
            } 
          }

          return turnos.select{|tur| (tur.getHora() == date)}[0]

          
        end

      end

      class Turno
        def initialize(hora)
          @hora = hora
          @turnos_en_hora = []
        end

        def addTurn(turn)
          @turnos_en_hora << turn
        end

        def getHora()
          return @hora
        end
        
        def getTurno()
          return @turnos_en_hora
        end

      end

    end
  end
end