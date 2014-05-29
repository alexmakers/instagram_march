require 'spec_helper'

describe Post do
  let(:post) { create(:post) }

  describe '#tag_names=' do
    describe 'no tags' do
      it 'does nothing' do
        post.tag_names = ''
        expect(post.tags).to be_empty
      end
    end

    describe 'one tag' do
      it 'adds a single tag to the post' do
        post.tag_names = 'yolo'
        expect(post.tags.count).to eq 1
      end

      it 'prepends the tag with a # if neccessary' do
        post.tag_names = 'yolo'
        tag = post.tags.last

        expect(tag.name).to eq '#yolo'
      end

      it 'does not double up #s' do
        post.tag_names = '#yolo'
        tag = post.tags.last

        expect(tag.name).to eq '#yolo'
      end
    end

    describe 'multiple comma-separated tags' do
      it 'adds each tag to the post' do
        post.tag_names = 'yolo, swag'
        expect(post.tags.count).to eq 2
      end

      context 'without spaces' do
        it 'adds each tag to the post' do
          post.tag_names = 'yolo,swag'
          expect(post.tags.count).to eq 2
        end
      end
    end

    describe 'multiple duplicate tags' do
      it 'uses only unique tags' do
        post.tag_names = 'yolo, swag, yolo'
        expect(post.tags.count).to eq 2
      end
    end

    describe 'reusing tags' do
      let!(:tag) { Tag.create(name: '#yolo') }

      it 'reuses tags if they exist' do
        post.tag_names = 'yolo'
        expect(Tag.count).to eq 1

        expect(tag.posts).to include post
      end
    end
  end
end
