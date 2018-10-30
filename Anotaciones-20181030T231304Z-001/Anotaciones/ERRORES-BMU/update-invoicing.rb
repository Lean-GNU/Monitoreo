isp = Isp.find_by_name("AVIDTEL")
plans_avidtel = isp.plans;nil
nombres_de_planes = ["R-2", "R-4", "C-2", "C-4", "R-4_Temp"]

nombres_de_planes.each do |nombre_plan|
plan = plans_avidtel.find_by_name(nombre_plan)
invoicing_plan = plan.invoicing_plan
iclients = invoicing_plan.contracts&.collect(&:client);nil

iclients.each do |iclient|
iclient.automatic_state = true
iclient.save
end;nil
end;nil
