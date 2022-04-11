require_relative "list"

class TodoBoard
    def initialize
        @list = {}
    end

    def get_command
        print "\nEnter a command: "
        cmd, lb, *args = gets.chomp.split

        case cmd
        when 'mklist'
            @list[lb] = List.new(lb)
        when 'ls'
            puts "Labels:"
            i = 1
            @list.each_key do |k|
                puts "#{i}. #{k}"
                i += 1
            end
        when 'showall'
            @list.each_key { |k| puts @list[k].print }
        when 'mktodo'
            @list[lb].add_item(*args)
        when 'up'
            @list[lb].up(*args.map(&:to_i))
        when 'down'
            @list[lb].down(*args.map(&:to_i))
        when 'swap'
            @list[lb].swap(*args.map(&:to_i))
        when 'sort'
            @list[lb].sort_by_date!
        when 'priority'
            @list[lb].print_priority
        when 'print'
            if args.length == 1
                @list[lb].print_full_item(*args.map(&:to_i))
            else
                @list[lb].print
            end
        when 'toggle'
            @list[lb].toggle_item(*args.map(&:to_i))
        when 'rm'
            @list[lb].remove_item(*args.map(&:to_i))
        when 'purge'
            @list[lb].purge
        when 'quit'
            return false
        else
            puts "Sorry, that command is not recognized"
        end

        true
    end

    def run
        until self.get_command == false
            self.get_command
        end
    end
end

TodoBoard.new.run