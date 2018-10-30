isp = Isp.find_by_name("AVIDTEL")
invoicing_isp = isp.invoicing_isp

iclients = invoicing_isp.clients;nil
iclients.each do |iclient|
iclient.invoicing_enabled = "1"
iclient.invoicing_firm_id = invoicing_isp.invoicing_firms.first.id
iclient.vat_condition = "fantasy"
iclient.kind_invoice = "voucher"
iclient.save
end;nil


####En el caso de que se desee activar solo algunos clientes de facturacion

irb(main):001:0> isp = Isp.find_by_name("AVIDTEL")
=> #<Isp id: "2e9ecec5-ba36-41e6-82f9-e487820061bb", name: "AVIDTEL", city: nil, skype: nil, email: "avidtel.eu@hotmail.com", language: "es", sender_id: nil, description: nil, country_name: "Colombia", telephone_number: nil, mobilephone_number: nil, release_privileges: nil, has_support_subscription: nil, created_at: "2018-07-13 17:23:24", updated_at: "2018-07-13 17:23:25", sender_mail: "avidtel.eu@hotmail.com", time_zone: "America/Bogota">
irb(main):002:0> plans_avidtel = isp.plans;nil
=> nil
irb(main):003:0> nombres_de_planes = ["R-2", "R-4", "C-2", "C-4", "R-4_Temp"]
=> ["R-2", "R-4", "C-2", "C-4", "R-4_Temp"]
irb(main):004:0> 
irb(main):005:0* nombres_de_planes.each do |nombre_plan|
irb(main):006:1* plan = plans_avidtel.find_by_name(nombre_plan)
irb(main):007:1> invoicing_plan = plan.invoicing_plan
irb(main):008:1> iclients = invoicing_plan.contracts&.collect(&:client);nil
irb(main):009:1> iclients.each do |iclient|
irb(main):010:2* iclient.invoicing_enabled = "1"
irb(main):011:2> iclient.invoicing_firm_id = iclient.isp.invoicing_firms.first.id
irb(main):012:2> iclient.vat_condition = "fantasy"
irb(main):013:2> iclient.kind_invoice = "voucher"
irb(main):014:2> iclient.automatic_state = true
irb(main):015:2> iclient.invoicing_enabled = true
irb(main):016:2> iclient.save
irb(main):017:2> puts "id: #{iclient.id} - #{iclient.errors.full_messages}" if iclient.errors.present?
irb(main):018:2> end;nil
irb(main):019:1> end;nil


