class Card
    attr_reader :value
    attr_accessor :face_value

    def initialize(value)
        @value = value
        @face_value = ' '
    end

    def face_up?
        !self.face_value == ' '
    end

    def ==(other)
        self.value == other.value
    end

    def hide
        self.face_value = ' ' 
    end

    def reveal
        self.face_value = @value
    end
end