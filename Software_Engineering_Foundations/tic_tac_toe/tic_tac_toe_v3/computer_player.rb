class ComputerPlayer
    attr_reader :mark

    def initialize(mark_value)
        @mark = mark_value
    end

    def get_position(legal_positions)
        pos = legal_positions.sample
        p "Computer #{@mark} chose position #{pos}"
        pos
    end
end