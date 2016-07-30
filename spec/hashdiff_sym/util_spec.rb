require 'spec_helper'

describe HashDiffSym do
  it "should be able to decode property path" do
    decoded = HashDiffSym.send(:decode_property_path, "a.b[0].c.city[5]")
    decoded.should == ['a', 'b', 0, 'c', 'city', 5]
  end

  it "should be able to decode property path with custom delimiter" do
    decoded = HashDiffSym.send(:decode_property_path, "a\tb[0]\tc\tcity[5]", "\t")
    decoded.should == ['a', 'b', 0, 'c', 'city', 5]
  end

  it "should be able to tell similiar hash" do
    a = {'a' => 1, 'b' => 2, 'c' => 3, 'd' => 4, 'e' => 5}
    b = {'a' => 1, 'b' => 2, 'c' => 3, 'e' => 5}
    HashDiffSym.similar?(a, b).should be_truthy
    HashDiffSym.similar?(a, b, :similarity => 1).should be_falsey
  end

  it "should be able to tell similiar hash with values within tolerance" do
    a = {'a' => 1.5, 'b' => 2.25, 'c' => 3, 'd' => 4, 'e' => 5}
    b = {'a' => 1.503, 'b' => 2.22, 'c' => 3, 'e' => 5}
    HashDiffSym.similar?(a, b, :numeric_tolerance => 0.05).should be_truthy
    HashDiffSym.similar?(a, b).should be_falsey
  end

  it "should be able to tell numbers and strings" do
    HashDiffSym.similar?(1, 2).should be_falsey
    HashDiffSym.similar?("a", "b").should be_falsey
    HashDiffSym.similar?("a", [1, 2, 3]).should be_falsey
    HashDiffSym.similar?(1, {'a' => 1, 'b' => 2, 'c' => 3, 'e' => 5}).should be_falsey
  end

  it "should be able to tell true when similarity == 0.5" do
    a = {"value" => "New1", "onclick" => "CreateNewDoc()"}
    b = {"value" => "New", "onclick" => "CreateNewDoc()"}

    HashDiffSym.similar?(a, b, :similarity => 0.5).should be_truthy
  end

  it "should be able to tell false when similarity == 0.5" do
    a = {"value" => "New1", "onclick" => "open()"}
    b = {"value" => "New", "onclick" => "CreateNewDoc()"}

    HashDiffSym.similar?(a, b, :similarity => 0.5).should be_falsey
  end

  describe '.compare_values' do
    it "should compare numeric values exactly when no tolerance" do
      expect(HashDiffSym.compare_values(10.004, 10.003)).to be_falsey
    end

    it "should allow tolerance with numeric values" do
      expect(HashDiffSym.compare_values(10.004, 10.003, :numeric_tolerance => 0.01)).to be_truthy
    end

    it "should compare other objects with or without tolerance" do
      expect(HashDiffSym.compare_values('hats', 'ninjas')).to be_falsey
      expect(HashDiffSym.compare_values('hats', 'ninjas', :numeric_tolerance => 0.01)).to be_falsey
      expect(HashDiffSym.compare_values('horse', 'horse')).to be_truthy
    end

    it 'should compare strings exactly by default' do
      expect(HashDiffSym.compare_values(' horse', 'horse')).to be_falsey
      expect(HashDiffSym.compare_values('horse', 'Horse')).to be_falsey
    end

    it 'should strip strings before comparing when requested' do
      expect(HashDiffSym.compare_values(' horse', 'horse', :strip => true)).to be_truthy
    end

    it "should ignore string case when requested" do
      expect(HashDiffSym.compare_values('horse', 'Horse', :case_insensitive => true)).to be_truthy
    end

  end
end
