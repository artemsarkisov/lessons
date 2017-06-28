module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def add_instance
      @instances ||= 0
      @instances += 1
    end

    def instances
      puts @instances
    end
  end

  module InstanceMethods

    private
    def register_instance
      self.class.add_instance
    end
  end
end