module StorageGem
  class Node

    def initialize(value = nil)
      @leafs = []
      @value = value
    end

    def value
      @value
    end

    def leafs
      @leafs
    end

    def add(word)
      compare_value = word[0]
      word = word.split("")
      word.shift
      cut_word = word.join
      exists_flag = 0

      @leafs.each do |leafs_item|
        if leafs_item.value == compare_value
          exists_flag = 1
          leafs_item.add(cut_word) if cut_word.length > 0
        end
      end

      if exists_flag == 0

        index = 0
        put_node_flag = -1
        new_node = Node.new(compare_value)

        while index < @leafs.size do
          put_node_flag = index if compare_value < @leafs[index].value and put_node_flag == -1
          index += 1
        end

        if put_node_flag == -1
          @leafs.push new_node
        elsif put_node_flag == 0
          @leafs.unshift new_node
        else
          @leafs.insert(put_node_flag, new_node)
        end
        new_node.add(cut_word) if cut_word.length > 0
      end

    end
  end
end