require 'fog/core/model'

module Fog
  module Compute
    class XenServer
    
      class VIF < Fog::Model
        # API Reference here:
        # http://docs.vmd.citrix.com/XenServer/5.6.0/1.0/en_gb/api/?c=VIF
        
        identity :reference
        
        attribute :mac,                :aliases => :MAC
        attribute :uuid
        attribute :allowed_operations
        attribute :currently_attached
        attribute :device
        attribute :mac_autogenerated,  :aliases => :MAC_autogenerated
        attribute :metrics
        attribute :mtu,                :aliases => :MTU
        attribute :__network,          :aliases => :network
        attribute :status_code
        attribute :status_detail
        attribute :__vm,               :aliases => :VM
        

        def destroy
          connection.destroy_vif reference
        end

        def network
          connection.networks.get __network
        end

        def server
          connection.servers.get __vm
        end

        def save
          requires :server
          raise ArgumentError.new('network is required for this operation') \
            unless attributes[:__network]
          ref = connection.create_vif attributes[:server], attributes[:__network]
          merge_attributes connection.vifs.get(ref).attributes
        end

      end
      
    end
  end
end
