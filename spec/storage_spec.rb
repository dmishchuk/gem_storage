require 'simplecov'
SimpleCov.start
require 'spec_helper'
require 'storage_gem'

describe StorageGem::Storage do
  describe '.add' do
    let(:word) { 'qwerty' }
    let(:storage) { StorageGem::Storage.new }
    let(:wrong_word) { 'qwertyu' }
    before(:each) do
      storage.add(word)
    end
    it "should add correct word" do
      expect(storage.dictionary.include?(word)).to be true
    end
    it "should not contain wrong word" do
      expect(storage.dictionary.include?(wrong_word)).to be false
    end
    it "adds only one item" do
      expect(storage.dictionary.length).to equal(1)
    end
  end
  describe '.add' do
    let(:word1) { 'cbda' }
    let(:word2) { 'bcda' }
    let(:word) { 'abcd' }
    let(:storage) { StorageGem::Storage.new }
    it "adds tree on each place" do
      storage.add(word)
      storage.add(word1)
      storage.add(word2)
      expect(storage.leafs_array[1].value).to eq('b')
    end
  end
  describe '.add' do
    let(:word) { 'qwerty' }
    let(:word2) { 'qrewq' }
    let(:storage) { StorageGem::Storage.new }
    it "creates node" do
      storage.add(word)
      storage.add(word2)
      expect(storage.leafs_array.length).to equal(1)
    end
  end
  describe '.find_other_words' do
    let(:word) { 'qwerty' }
    let(:cut_word) { 'qwer' }
    let(:storage) { StorageGem::Storage.new }
    before(:each) do
      storage.add(word)
      storage.find_like_words(cut_word.split(""), storage.leafs_array)
      storage.parse_like_words(cut_word)
    end
    it "find such word" do
      expect(storage.like_words.include?(word)).to be true
    end
  end
  describe '.check_word' do
    let(:word) { 'qwerty' }
    let(:wrong_word) { 'qwerti' }
    let(:storage) { StorageGem::Storage.new }
    before(:each) do
      storage.add(word)
    end
    it "find this word" do
      expect(storage.check_word(word)).to eq("found")
    end
    it "find this word" do
      expect(storage.check_word(wrong_word)).to eq("not found")
    end
  end
  it '.load_from_file calls File.read' do
    expect(File).to receive(:read).with('load_from/txt/data.txt')
    StorageGem::Storage.new.load_from_file('load_from/txt/data.txt')
  end
  it '.load_to_file calls File.write' do
    expect(File).to receive(:write).with('save_to/txt/data.txt','qwerty')
    StorageGem::Storage.new.load_to_file('save_to/txt/data.txt', 'qwerty')
  end

end
