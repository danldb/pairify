require 'spec_helper'
require 'pair_partner'

describe PairPartner do

  let(:a){ PairPartner.new }
  let(:b){ PairPartner.new }
  let(:c){ PairPartner.new }
  let(:d){ PairPartner.new }
  let(:e){ PairPartner.new }

  it 'can be paired' do
    pairs = []
    expect(a.find_pair(potential_partners: [b,c,d], pairs: pairs)).to be b
    expect(a.find_pair(potential_partners: [b,c,d], pairs: pairs)).to be c
    expect(a.find_pair(potential_partners: [b,c,d], pairs: pairs)).to be d
    expect(a.find_pair(potential_partners: [b,c,d], pairs: pairs)).to be b
    expect(pairs).to eq([[a,b],[a,c],[a,d],[a,b]])
  end

  context 'pairing a cohort' do

    it 'generates pairs' do
      cohort = [a, b, c, d]
      expect(PairPartner.generate_pairs(cohort)).to eq([[a,b],[c,d]])
    end

    it 'generates a triple' do
      uneven_cohort = [a, b, c, d, e]
      expect(PairPartner.generate_pairs(uneven_cohort)).to eq([[a,b,e],[c,d]])
    end
  end

end
