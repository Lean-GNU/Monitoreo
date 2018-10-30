# En el caso de que no se hayan generado las PS de cambio de estado en el BMU

Buscamos en BMU los contratos con los ids que sacamos esa vez
Por cada contracto revisamos si tiene o no contract_notification
Nos guardamos aquellos que no tienen contract_notifications y están deshabilitados
En el cloud ahora vamos a usar esos contratos sin notification para sacudirle con NotificationWeb.notify_contract_disabled(c) como hicimos

# En la consola de produccion

#Buscamos el isp:
a = Isp.find_by_name('FJC TELECOMUNICACIONES SAS')
#Contamos cuantos contratos hay deshabilitados:
a.contracts.disabled.count
#Guardamos todos los ids de los contratos deshabilitados: 
id_contr_disabled = a.contracts.disabled.collect(&:id)
#Comparar con lo anterior:
id_contr_disabled.count
#Crear PS: 
Contract.where(id: id_contr_disabled).each {|c| c.creation_sync(:create)}
#Crear notificaciones:
Contract.where(id: id_contr_disabled).each{|c|  NotificationWeb.notify_contract_disabled(c)}


#Para crear una notificacion de deshabilitado a un contract en especifico:
NotificationWeb.notify_contract_disabled(Contract.find('0c507f4d-22ec-4667-932d-4cbea3ce2a35'))


