class ExporterController < ApplicationController

  def index
    @professionals = Professional.all
  end

  def export
    @fecha = params[:date]
    @fecha = DateTime.strptime(@fecha, '%Y-%m-%d').to_date
    @semanal = params[:weekly]
    @turnosOrdenados = []
    @turnosDeSemana = []
    fecha_inicio = Time.new(@fecha.year,@fecha.month, @fecha.day)
    fecha_fin = fecha_inicio + 60*60*24
    while(fecha_inicio < fecha_fin) do
      h = Hora.new(fecha_inicio)
      @turnosOrdenados << h
      fecha_inicio += 60*15
    end
    
    if (@semanal == "day")    
      if (params[:professional_id] != "")
        @turnos = Appointment.where(date: @fecha.all_day,professional_id:params[:professional_id] )
      else
        @turnos = Appointment.where(date: @fecha.all_day)
      end
      
    else

      @begginingOfWeek = @fecha.beginning_of_week
      (0..6).each do |i|
        @turnos = []
        diaCorriente = @begginingOfWeek + i
         sem = Semanal.new(diaCorriente)
         sem.addTurn(@turnosOrdenados)
         @turnosDeSemana << sem
        if (params[:professional_id] != "")
          @turnos << Appointment.where(date: diaCorriente.all_day, professional_id:params[:professional_id] )
        else
          @turnos << Appointment.where(date: diaCorriente.all_day)
        end

        @turnos.each do |t|
          begin
            @turnosDeSemana[i].get_turns.select{|tur| tur.getHora() == t.date}[0].addTurn(t)
          rescue
            # h = Hora.new(t.date)
            # h.addTurn(t)
            # @turnosDeSemana.addTurn(h)
          end
        end
      end
    end
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

class Semanal
  def initialize(dia)
    @dia = dia
    @turnos_en_dia = []
  end

  def getDay()
    return @dia
  end

  def get_turns()
    return @turnos_en_dia
  end

  def addTurn(arr_de_info_turn)
    @turnos_en_dia << arr_de_info_turn
  end

end