require 'spec_helper'

describe GSGraph::Education, '.new' do

  it 'should setup all supported attributes' do
    attributes = {
      :school => {
        :id => 110149592341159,
        :name => "\u540c\u5fd7\u793e\u5927\u5b66"
      },
      :degree => {
        :id => 110616875633830,
        :name => "Master of Engineering"
      },
      :year => {
        :id => 104926492884272,
        :name => "2007"
      },
      :concentration => [
        {
          :id => 112303688789448,
          :name => "Engineering"
        },
        {
          :id => 102358546472290,
          :name => "Intelligent Information"
        },
        {
          :id => 108311762535367,
          :name => "Intelligent Systems Design Laboratory"
        }
      ]    }
    education = GSGraph::Education.new(attributes)
    education.school.should == GSGraph::Page.new(
      110149592341159,
      :name => "\u540c\u5fd7\u793e\u5927\u5b66"
    )
    education.degree.should == GSGraph::Page.new(
      110616875633830,
      :name => "Master of Engineering"
    )
    education.year.should == GSGraph::Page.new(
      104926492884272,
      :name => "2007"
    )
    education.concentration.should == [
      GSGraph::Page.new(
        112303688789448,
        :name => "Engineering"
      ),
      GSGraph::Page.new(
        102358546472290,
        :name => "Intelligent Information"
      ),
      GSGraph::Page.new(
        108311762535367,
        :name => "Intelligent Systems Design Laboratory"
      )
    ]
  end
end