require 'spec_helper'

describe Tag do
  it 'should be unique' do
    Tag.create(name: '#yolo')
    duplicate = Tag.new(name: '#yolo')

    expect(duplicate).to have(1).error_on(:name)
  end
end
