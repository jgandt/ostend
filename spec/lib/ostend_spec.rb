require 'spec_helper'

class OstendTester
  include Ostend
end

describe Ostend do

  HASH = {:test_attr_1 => 'test attr 1', :test_attr_2 => 'test attr 2'}

  let(:hash){ {:test_attr_1 => 'test attr 1', :test_attr_2 => 'test attr 2'} }
  let(:ostend_tester){ OstendTester.new }

  shared_examples 'instance variable setter' do |test_hash|
    it 'assigns the value to the instance variable' do
      test_hash.each do |key, value|
        subject.instance_variable_get( "@#{key}" ).should == value
      end
    end
  end

  shared_examples 'writer creator' do |test_hash|
    it 'creates writer methods' do
      test_hash.each do |key, value|
        subject.public_methods.should include "#{key}=".to_sym
      end
    end
  end

  shared_examples 'NON writer creator' do |test_hash|
    it 'does not create writer methods' do
      test_hash.each do |key, value|
        subject.public_methods.should_not include "#{key}=".to_sym
      end
    end
  end

  shared_examples 'reader creator' do |test_hash|
    it 'creates reader methods' do
      test_hash.each do |key, value|
        subject.public_methods.should include "#{key}".to_sym
      end
    end
  end

  shared_examples 'NON reader creator' do |test_hash|
    it 'creates reader methods' do
      test_hash.each do |key, value|
        subject.public_methods.should_not include "#{key}".to_sym
      end
    end
  end

  describe '#ostendify' do
    subject{ ostend_tester }

    context 'when @ostend_attr_type is not set' do
      it 'defaults @ostend_attr_type to :accessor' do
        subject.instance_variable_get('@ostend_attr_type').should be_nil
        subject.ostendify(hash)
        subject.instance_variable_get('@ostend_attr_type').should be :accessor
      end
      context 'it creates attr_accessors' do
        before{ subject.ostendify(hash) }
        it_should_behave_like 'writer creator', HASH
        it_should_behave_like 'reader creator', HASH
        it_should_behave_like 'instance variable setter', HASH
      end
    end

    context 'when @ostend_attr_type is :accessor it creates attr_accessors' do
      before do
        subject.ostend_attr_type = :accessor
        subject.ostendify(hash)
      end
      it_should_behave_like 'writer creator', HASH
      it_should_behave_like 'reader creator', HASH
      it_should_behave_like 'instance variable setter', HASH
    end

    context 'when @ostend_attr_type is :writer it creates attr_accessors' do
      before do
        subject.ostend_attr_type = :writer
        subject.ostendify(hash)
      end
      it_should_behave_like 'writer creator', HASH
      # it_should_behave_like 'NON reader creator', HASH
      it_should_behave_like 'instance variable setter', HASH
    end

    context 'when @ostend_attr_type is :reader it creates attr_accessors' do
      before do
        subject.ostend_attr_type = :writer
        subject.ostendify(hash)
      end
      it_should_behave_like 'writer creator', HASH
      it_should_behave_like 'NON reader creator', HASH
      it_should_behave_like 'instance variable setter', HASH
    end

  end

  describe '#ostend_create_attributes' do
    subject{ ostend_tester }

    context 'when @ostend_attr_type is :accessor' do
      before do
        subject.ostend_attr_type = :accessor
        subject.send(:ostend_create_attributes, hash)
      end
      it_should_behave_like 'writer creator', HASH
      it_should_behave_like 'reader creator', HASH
      it_should_behave_like 'instance variable setter', HASH
    end

    context 'when @ostend_attr_type is :writer' do
      before do
        subject.ostend_attr_type = :writer
        subject.send(:ostend_create_attributes, hash)
      end
      it_should_behave_like 'writer creator', HASH
      it_should_behave_like 'NON reader creator', HASH
      it_should_behave_like 'instance variable setter', HASH
    end

    context 'when @ostend_attr_type is :reader' do
      before do
        subject.ostend_attr_type = :reader
        subject.send(:ostend_create_attributes, hash)
      end
      it_should_behave_like 'NON writer creator', HASH
      it_should_behave_like 'reader creator', HASH
      it_should_behave_like 'instance variable setter', HASH
    end

    it 'creates attr_* only for the singleton class, not the core class' do
      subject{ OstendTester.new }
      ostend_tester.ostend_attr_type = :accessor
      ostend_tester.send('ostend_create_attributes', hash )

      OstendTester.new.should_not respond_to( hash.keys.first )
    end
  end

end
