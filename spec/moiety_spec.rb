require 'spec_helper'
require 'moiety'

describe Moiety do

  let(:a){ Moiety.new }
  let(:b){ Moiety.new }
  let(:c){ Moiety.new }
  let(:d){ Moiety.new }

  it 'can be paired' do
    pairs = []
    expect(a.find_pair(potential_partners: [b,c,d], pairs: pairs)).to be b
    expect(a.find_pair(potential_partners: [b,c,d], pairs: pairs)).to be c
    expect(a.find_pair(potential_partners: [b,c,d], pairs: pairs)).to be d
    expect(a.find_pair(potential_partners: [b,c,d], pairs: pairs)).to be b
    expect(pairs).to eq([[a,b],[a,c],[a,d],[a,b]])
  end

  context 'pairing a cohort' do
    let(:cohort){ [a, b, c, d]}
    #let(:student_a){ double :student, id: 1}
    #let(:student_b){ double :student, id: 2}
    #let(:student_c){ double :student, id: 3}
    #let(:student_d){ double :student, id: 4}

    it 'generates pairs' do
      expect(Moiety.generate_pairs(cohort)).to eq([[a,b],[c,d]])
    end
  end

end
