class Item
    attr_reader :title, :deadline, :description, :is_done

    def self.valid_date?(str)
        valid_month = (1..12).to_a
        valid_date = (1..31).to_a
        valid_year = (0..9).map(&:to_s)
        check_date = str.split('-')

        return false if check_date.length != 3
        return false if check_date[0].split("").any? { |ch| !valid_year.include?(ch) } #check year
        return false if !valid_month.include?(check_date[1].to_i) #check year
        return false if !valid_date.include?(check_date[2].to_i) #check date

        true
    end

    def initialize(title, deadline, description)
        raise "Invalid date" if !Item.valid_date?(deadline)

        @is_done = false
        @title = title
        @deadline = deadline
        @description = description
    end

    def title=(new_title)
        @title = new_title
    end

    def deadline=(new_deadline)
        @deadline = new_deadline
    end

    def description=(new_description)
        @description = new_description
    end

    def toggle
        if @is_done == false
            @is_done = true
        else
            @is_done = false
        end

        @is_done
    end
end