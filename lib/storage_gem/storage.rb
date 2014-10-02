module StorageGem
  class Storage

    def initialize
      @root = Node.new
      @like_words_array = []
      @dictionary = []
    end

    def load_from_file(file_path)
      add(File.read(file_path))
    end

    def load_to_file(file_path, input_string)
      File.write(file_path, input_string)
    end

    def add(input_string)
      input_words_array = input_string.split(',')
      @dictionary.push(input_string)
      input_words_array.each { |word| @root.add word }
    end

    def like_words
      @like_words_array
    end

    def parse_like_words(word)
      str_storage = word
      temp_like_array = []
      @like_words_array.each do |word_item|
        temp = str_storage
        temp += word_item
        temp_like_array.push(temp)
      end
      @like_words_array = temp_like_array
    end

    def leafs_array
      @root.leafs
    end

    def find_word(mas_word, dictionary_arr)
      mas_word_value = mas_word[0]
      mas_word.shift
      word_exists_flag = 0
      dictionary_arr.each do |dictionary_arr_item|
        node_value = dictionary_arr_item.value
        if mas_word_value == node_value
          word_exists_flag = 1
          find_word(mas_word, dictionary_arr_item.leafs) if mas_word.length > 0
        end
      end
      raise MatchNotFound.new if word_exists_flag == 0
    end

    def find_other_words(node_item, word_beginning = "")
      if node_item.length > 0
        node_item.each do |node|
          temp_str = word_beginning
          temp_str += node.value
          @like_words_array.push(temp_str)
          find_other_words(node.leafs, temp_str) if node.leafs.length > 0
        end
      end
    end

    def find_like_words(mas_word, dictionary_arr)
      mas_word_value = mas_word[0]
      mas_word.shift
      dictionary_arr.each do |dictionary_arr_item|
        node_value = dictionary_arr_item.value
        if mas_word_value == node_value
          if mas_word.length > 0
            find_like_words(mas_word, dictionary_arr_item.leafs)
          else
            find_other_words(dictionary_arr_item.leafs)
          end
        end
      end
    end

    def dictionary
      @dictionary
    end

    def check_word (word)
      word = word.split("")
      begin
        find_word(word, leafs_array)
      rescue MatchNotFound
        return "not found"
      else
        return "found"
      end
    end
  end
end
