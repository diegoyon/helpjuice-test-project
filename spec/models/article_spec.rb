require 'rails_helper'

RSpec.describe Article, type: :model do
  subject do
    Article.new(title: 'Test title', content: 'Test content', author: 'Test author')
  end

  context 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without content' do
      subject.content = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without an author' do
      subject.author = nil
      expect(subject).to_not be_valid
    end
  end
end
