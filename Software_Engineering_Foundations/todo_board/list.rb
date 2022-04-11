require_relative "item"

class List
    attr_reader :label

    def initialize(label)
        @label = label
        @items = []
    end

    def label=(new_label)
        @label = new_label 
    end

    def add_item(title, deadline, description = "")
        return false if !Item.valid_date?(deadline)
        @items << Item.new(title, deadline, description)
        true
    end

    def size
        @items.length
    end

    def valid_index?(index)
        (0...self.size).include?(index)
    end

    def swap(index_1, index_2)
        if self.valid_index?(index_1) && self.valid_index?(index_2)
            @items[index_1], @items[index_2] = @items[index_2], @items[index_1]
            return true
        else
            return false
        end
    end

    def [](index)
        return nil if !self.valid_index?(index)
        @items[index]
    end

    def priority
        self[0]
    end

    def print
        puts "-------------------------------------------------"
        puts "                #{@label.upcase} "
        puts "-------------------------------------------------"
        puts "Index | Item                 | Deadline   | Done?"
        puts "-------------------------------------------------"
        @items.each_with_index do |item, i|
            puts "#{i.to_s.ljust(5)} | #{item.title.ljust(20)} | #{item.deadline.ljust(10)} | #{item.is_done.to_s.ljust(5)}"
        end
        puts "-------------------------------------------------"
    end

    def print_full_item(index)
        puts "------------------------------------------"
        puts "#{self[index].title.ljust(30)}  #{self[index].deadline.ljust(10)}"
        puts self[index].description
        puts "Is done?: #{self[index].is_done}"
        puts "------------------------------------------"
    end

    def print_priority
        puts "------------------------------------------"
        puts "#{self.priority.title.ljust(30)}  #{self.priority.deadline.ljust(10)}"
        puts self.priority.description
        puts "Is done?: #{self[0].is_done}"
        puts "------------------------------------------"
    end

    def up(index, amount = 1)
        return false if !self.valid_index?(index)

        amount.times do 
            if self.valid_index?(index) && self.priority != self[index]
                @items[index], @items[index - 1] = @items[index - 1], @items[index]
            end
            
            index -= 1
        end

        true
    end

    def down(index, amount = 1)
        return false if !self.valid_index?(index)

        amount.times do 
            if self.valid_index?(index) && @items[-1] != self[index]
                @items[index], @items[index + 1] = @items[index + 1], @items[index]
            end
            
            index += 1
        end

        true
    end

    def sort_by_date!
        @items.sort_by! { |item| item.deadline }
    end

    def toggle_item(index)
        self[index].toggle
    end

    def remove_item(index)
        if self.valid_index?(index)
            @items.delete_at(index)
            return true
        else
            return false
        end
    end

    def purge
        i = 0
        while i < self.size
            if self[i].is_done
                self.remove_item(i)
            else
                i += 1
            end
        end
    end
end