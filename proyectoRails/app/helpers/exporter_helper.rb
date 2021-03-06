module ExporterHelper
  def addTemplate
    template = <<-HTML 
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title><%= @dia %></title>
    </head>
    <body>
      <%if @semanal == "day"%>
        <table border="1">
          <tr>
            <th>hora/dia</th>
            <th><%= @fecha %></th>
          </tr>
          <tr>
          <% @turnosOrdenados.each do |horas| %>
              <tr>
                <td><%= horas.getHora().strftime("%I:%M%p") %></td> 
                <% horas.get_turns().each do |turno_en_hora| %>
                    <td><%=Patiente.find(turno_en_hora.patiente_id).name + " " + Patiente.find(turno_en_hora.patiente_id).surname+ " (" + Professional.find(turno_en_hora.professional_id).name + " "  + Professional.find(turno_en_hora.professional_id).surname + ")" %></td>
                <%end%>
              </tr>         
          <%end%>
        </table>
      <%else%> <!-- SEMANAL -->
         <table border="1"> 
         <tr>
            <td>Hora/Días</td>
            <td>Lunes</td>
            <td>Martes</td>
            <td>Miercoles</td>
            <td>Jueves</td>
            <td>Viernes</td>
            <td>Sabado</td>
            <td>Domingo</td>
         </tr>
          <%@turnosOrdenados.each_with_index do |tur, index|%>
            <tr>
              <td><%=tur.getHora().strftime("%I:%M%p")%></td>
              <%@turnosDeSemana.each do |ts|%>
              
                <td> 
                <%ts.get_turns[index].get_turns.each do |cadaTurno|%>      
                  - <%=Patiente.find(cadaTurno.patiente_id).name + " " + Patiente.find(cadaTurno.patiente_id).surname+ " (" + Professional.find(cadaTurno.professional_id).name + " "  + Professional.find(cadaTurno.professional_id).surname + ")" %>
                <%end%>
                </td>
              <%end%>
            </tr>
          <%end%>
        </table>
      <%end%>
    </body>
    HTML

    renderer = ERB.new(template)

    return renderer

  end
end
