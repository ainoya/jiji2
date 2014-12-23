# coding: utf-8

require 'jiji/plugin/securities_plugin'

module Jiji
module Test 
module Mock
  
  class MockSecuritiesPlugin
    
    include JIJI::Plugin::SecuritiesPlugin
    
    attr :props
    
    def initialize(id)
      @serial= 0
      @id = id
    end
    
    def plugin_id
      @id
    end
    
    def display_name
      "mock plugin"
    end
    
    def input_infos
      return [
        Input.new( 'a', 'aaa', true,  nil ),
        Input.new( 'b', 'bbb', false, nil ),
        Input.new( 'c', 'ccc', true,  proc {|v| v == "c" ? "error" : nil  } )
      ]
    end
    
    def init_plugin( props, logger ) 
      @props = props
    end
    
    def destroy_plugin
    end
    
    def list_pairs
      return [
        Pair.new(:EURJPY, 10000),
        Pair.new(:EURUSD, 10000),
        Pair.new(:USDJPY, 10000)
      ]
    end
    
    def list_rates
      return {
        :EURJPY => Rate.new(145.110, 119.128, 10, -20),
        :EURUSD => Rate.new(1.2233, 1.2234, 11, -16),
        :USDJPY => Rate.new(119.435, 119.443, -8, 2)
      }
    end
    
    def order( pair, sell_or_buy, count )
      @serial+=1
      return Position.new(@serial)
    end

    def commit( position_id, count )
    end
  end
  
end
end
end


JIJI::Plugin.register( 
  JIJI::Plugin::SecuritiesPlugin::FUTURE_NAME, 
  Jiji::Test::Mock::MockSecuritiesPlugin.new(:mock) )
JIJI::Plugin.register( 
  JIJI::Plugin::SecuritiesPlugin::FUTURE_NAME, 
  Jiji::Test::Mock::MockSecuritiesPlugin.new(:mock2) )