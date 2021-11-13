module Polycon
	module Models      
		module WriterModel
      require "erb"

			class Writer

        def self.prueba(date)
         fecha = self.getData(date)

         @dia = date
         @turnos = fecha.get_turns()


          #logica de la impresion a html
          template = File.read(Dir.home()+'/Escritorio' +'/template.html')
          result = ERB.new(template).result(binding)
          File.open((Dir.home()+"/Escritorio/turnos del dia #{date}.html "), 'w+') do |f|
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

          turno = Turno.new(date) 
          profesionales.each{ |pro|
            Dir.foreach((Dir.home() + "/.polycon/#{pro}")){ |turnoPro|
              if turnoPro.include?(date)
                if turnoPro != "." && turnoPro != ".."
                  nombre_paciente =""
                  line_num=0 
                  File.open(Dir.home() + "/.polycon/#{pro}/#{turnoPro}").each do |line| 
                    if line_num <= 1
                      nombre_paciente += line
                    end
                    line_num +=1
                  end
                    turno.addTurn([pro, nombre_paciente], turnoPro[/_(.*?).paf/, 1])
                end
              end
            } 
          }
          return turno

          
        end

      end

      class Turno
        def initialize(date)
          @turnos_del_dia = [] 
          @fecha = date
        end
        def addTurn(info_turno, hora_del_turno)
          begin
            @turnos_del_dia.select{|tur| tur.getHora() == hora_del_turno}[0].addTurn(info_turno)
          rescue
            h = Hora.new(hora_del_turno)
            h.addTurn(info_turno)
            @turnos_del_dia << h
          end
        end

        def get_turns()
          return @turnos_del_dia
        end

      end

      class Hora
        def initialize(hora)
          @hora = hora
          @turnos_en_hora = []
        end

        def getHora()
          return @hora
        end

        def get_turns()
          return @turnos_en_hora
        end

        def addTurn(arr_de_info_turn)
          @turnos_en_hora << arr_de_info_turn
        end

      end

    end
  end
end