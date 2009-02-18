module SmartMonth
  # Responsible for all math related functionality.
  module Math
    
    # adds a number to the month value and returns a Fixnum.
    def +(int)
      self.to_i + int
    end

    # subtracts a number to the month value and returns a Fixnum.
    def -(int)
      self.to_i - int
    end
    
    # multiplies a number to the month value and returns a Fixnum.
    def *(int)
      self.to_i * int
    end

    # divides a number to the month value and returns a Fixnum.
    def /(int)
      self.to_i / int
    end
    
    # exponents a number to the month value and returns a Fixnum.
    def **(int)
      self.to_i ** int
    end
    
    # modulos a number to the month value and returns a Fixnum.
    def %(int)
      self.to_i % int
    end
    
    # compares the current month to another month.
    def ==(month)
      self.inspect! == month.inspect! 
    end
    
  end
end