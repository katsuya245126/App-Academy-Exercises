require_relative "list.rb"

class TodoBoard
  def initialize()
    @lists = {}
  end

  def run
    get_command until get_command == false
  end

  def get_command
    print "Enter a command: "

    command, *args = gets.chomp.split(" ")

    case command
    when 'mklist'
      label = args[0]
      @lists[label] = List.new(label)
    when 'ls'
      @lists.each { |label, list| puts label }
    when 'showall'
      @lists.each { |label, list| list.print }
    when 'mktodo'
      label = args.shift

      if @lists.key?(label)
        @lists[label].add_item(*args)
      else
        puts "No such list."
      end
    when 'up'
      label = args.shift

      if @lists.key?(label)
        if args.length > 1
          idx, amount = args[0],args[1]
          @lists[label].up(idx.to_i, amount.to_i)
        else
          idx = args[0]
          @lists[label].up(idx.to_i)
        end
      else
        puts "No such list."
      end
    when 'down'
      label = args.shift

      if @lists.key?(label)
        if args.length > 1
          idx, amount = args[0],args[1]
          @lists[label].down(idx.to_i, amount.to_i)
        else
          idx = args[0]
          @lists[label].down(idx.to_i)
        end
      else
        puts "No such list."
      end
    when 'swap'
      label = args.shift

      if @lists.key?(label)
        idx1, idx2 = args[0].to_i, args[1].to_i
        @lists[label].swap(idx1, idx2)
      else
        puts "No such list."
      end
    when 'sort'
      label = args.shift

      if @lists.key?(label)
        @lists[label].sort_by_date!
      else
        puts "No such list."
      end
    when 'priority'
      label = args.shift

      if @lists.key?(label)
        @lists[label].print_priority
      else
        puts "No such list."
      end
    when 'print'
      label = args.shift

      if @lists.key?(label)
        if args.empty?
          @lists[label].print 
        else
          idx = args[0].to_i
          @lists[label].print_full_item(idx)
        end
      else
        puts "No such list."
      end
    when 'toggle'
      label = args.shift
      idx = args[0].to_i

      if @lists.key?(label)
        @lists[label][idx].toggle
      else
        puts "No such list."
      end
    when "rm"
      label = args.shift

      if @lists.key?(label)
        idx = args[0]
        @lists[label].remove_item(idx)
      else
        puts "No such list."
      end
    when 'purge'
      label = args.shift

      if @lists.key?(label)
        @lists[label].purge
      else
        puts "No such list."
      end
    when'quit'
      return false
    else
      puts "No such commmand."
    end

    true
  end
end

