class PairPartner

  class << self

    def generate_pairs(cohort, pairs = [])
      challenger = cohort.shift
      challenger.find_pair(potential_partners: cohort, pairs: pairs)
      potential_partners = cohort.reject{|partner| partner.send(:paired?) }
      return pairs if potential_partners.empty?
      self.generate_pairs(potential_partners, pairs)
    end
  end

  def initialize
    @liaisons = {}
  end

  def find_pair(potential_partners:, pairs: [])
    match = best_pair_from(potential_partners)
    pair_with(match, pairs)
    match
  end

  protected

  attr_accessor :liaisons, :pair

  def best_pair_from(potential_partners)
    potential_partners.inject do |champion, challenger|
      champion.number_of_liaisons(self) <= challenger.number_of_liaisons(self) ? champion : challenger 
    end
  end

  def number_of_liaisons(other)
    self.liaisons[other] ||= 0
  end

  def pair_with(other, pairs = nil)
    return find_triple_from(pairs) unless other
    self.pair = other
    store_pair_in(pairs) if pairs
    increment_number_of_liaisons
    other.pair_with(self) unless other.paired?
  end

  def find_triple_from(pairs)
    match = pairs.sort{|a,b| average_liaisons_with(a) <=> average_liaisons_with(b)}.first
    match.each{|partner| pair_with(partner); partner.pair_with(self) } << self
    match
  end

  def average_liaisons_with(pair)
    pair.map{|partner| number_of_liaisons(partner)}.reduce{|a,b| a + b / 2 }
  end

  def store_pair_in(pairs)
    pairs << [self, pair]
  end

  def increment_number_of_liaisons
    self.liaisons[pair] ||= 0
    self.liaisons[pair] += 1
  end

  def paired?
    !!pair
  end
end
