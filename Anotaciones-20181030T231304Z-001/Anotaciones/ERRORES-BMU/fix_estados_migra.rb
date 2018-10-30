def fix_contracts_state(server_configuration_id = nil, file)
  require 'byebug'
  return if server_configuration_id.nil?
  sc = ServerConfiguration.find(server_configuration_id)
  isp = sc.isp
  contracts_to_disable = []
  imported = JSON.load(File.read(file))
  imported["clients"].each_slice(10) do |client_group|
    ActiveRecord::Base.transaction do
      client_group.each do |c|
        client = isp.clients.find_by name: c['name']
        c['contracts'].each do |co|
          if co['state'] == 'disabled'
            contracts_to_disable << co['ip']
          end
        end
      end
    end
  end
  ActiveRecord::Base.transaction do
    contracts = []
    contracts_to_disable.each do |ctd|
      contracts << isp.contracts.joins(:address).includes(:address).where("addresses.ip = '#{ctd}'").first
    end
    Contract.all.where(id: contracts.collect(&:id)).update_all(state: 'disabled')
  end
end


#se ejecuta de la siguiente manera:
#fix_contracts_state('id_bmu','/tmp/exported_clients.json')
