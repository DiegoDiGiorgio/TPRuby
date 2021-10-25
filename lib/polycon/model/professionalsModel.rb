module Polycon
	module Models      
		module ProfessionalsModel
			class ProModel
				def self.create(name)
					if(Dir.exists?(Dir.home() + "/.polycon"))
						Dir.mkdir(Dir.home() + "/.polycon/" + name)
					  else
						Dir.mkdir(Dir.home() + "/.polycon")
						Dir.mkdir(Dir.home() + "/.polycon/" + name)
					  end
				end

				def self.delete(name)
					if( Dir.exists?((Dir.home() +"/.polycon/" + name)) && Dir.empty?(Dir.home() +"/.polycon/" + name))
            Dir.rmdir(Dir.home() +"/.polycon/" + name)
            puts "el directorio fue eliminado"
          else
            puts "No se puede borrar!! \nEl profesional tiene turnos pendientes o no existe."
          end
				end

				def self.list()
					Dir.foreach(Dir.home() + "/.polycon") {|pro| puts "#{pro}\n"}
				end

				def self.rename(old_name, new_name)
					if (Dir.exists?(Dir.home() + '/.polycon/' + old_name))
						File.rename Dir.home() + '/.polycon/' + old_name, Dir.home() + '/.polycon/' + new_name
						puts "Renombre exitoso  #{old_name} ==> #{new_name}"
					else 
						puts "El profesional #{old_name} no existe !"
					end
				end
			end
		end
	end
end