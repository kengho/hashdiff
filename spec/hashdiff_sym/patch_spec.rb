require 'spec_helper'

describe HashDiffSym do
  it "it should be able to patch key addition" do
    a = {"a"=>3, "c"=>11, "d"=>45, "e"=>100, "f"=>200}
    b = {"a"=>3, "c"=>11, "d"=>45, "e"=>100, "f"=>200, "g"=>300}
    diff = HashDiffSym.diff(a, b)

    HashDiffSym.patch!(a, diff).should == b

    a = {"a"=>3, "c"=>11, "d"=>45, "e"=>100, "f"=>200}
    b = {"a"=>3, "c"=>11, "d"=>45, "e"=>100, "f"=>200, "g"=>300}
    HashDiffSym.unpatch!(b, diff).should == a
  end

  it "should be able to patch value type changes" do
    a = {"a" => 3}
    b = {"a" => {"a1" => 1, "a2" => 2}}
    diff = HashDiffSym.diff(a, b)

    HashDiffSym.patch!(a, diff).should == b

    a = {"a" => 3}
    b = {"a" => {"a1" => 1, "a2" => 2}}
    HashDiffSym.unpatch!(b, diff).should == a
  end

  it "should be able to patch value array <=> []" do
    a = {"a" => 1, "b" => [1, 2]}
    b = {"a" => 1, "b" => []}
    diff = HashDiffSym.diff(a, b)

    HashDiffSym.patch!(a, diff).should == b

    a = {"a" => 1, "b" => [1, 2]}
    b = {"a" => 1, "b" => []}
    HashDiffSym.unpatch!(b, diff).should == a
  end

  it "should be able to patch value array <=> nil" do
    a = {"a" => 1, "b" => [1, 2]}
    b = {"a" => 1, "b" => nil}
    diff = HashDiffSym.diff(a, b)

    HashDiffSym.patch!(a, diff).should == b

    a = {"a" => 1, "b" => [1, 2]}
    b = {"a" => 1, "b" => nil}
    HashDiffSym.unpatch!(b, diff).should == a
  end

  it "should be able to patch array value removal" do
    a = {"a" => 1, "b" => [1, 2]}
    b = {"a" => 1}
    diff = HashDiffSym.diff(a, b)

    HashDiffSym.patch!(a, diff).should == b

    a = {"a" => 1, "b" => [1, 2]}
    b = {"a" => 1}
    HashDiffSym.unpatch!(b, diff).should == a
  end

  it "should be able to patch array under hash key with non-word characters" do
    a = {"a" => 1, "b-b" => [1, 2]}
    b = {"a" => 1, "b-b" => [2, 1]}
    diff = HashDiffSym.diff(a, b)

    HashDiffSym.patch!(a, diff).should == b

    a = {"a" => 1, "b-b" => [1, 2]}
    b = {"a" => 1, "b-b" => [2, 1]}
    HashDiffSym.unpatch!(b, diff).should == a
  end

  it "should be able to patch hash value removal" do
    a = {"a" => 1, "b" => {"b1" => 1, "b2" =>2}}
    b = {"a" => 1}
    diff = HashDiffSym.diff(a, b)

    HashDiffSym.patch!(a, diff).should == b

    a = {"a" => 1, "b" => {"b1" => 1, "b2" =>2}}
    b = {"a" => 1}
    HashDiffSym.unpatch!(b, diff).should == a
  end

  it "should be able to patch value hash <=> {}" do
    a = {"a" => 1, "b" => {"b1" => 1, "b2" =>2}}
    b = {"a" => 1, "b" => {}}
    diff = HashDiffSym.diff(a, b)

    HashDiffSym.patch!(a, diff).should == b

    a = {"a" => 1, "b" => {"b1" => 1, "b2" =>2}}
    b = {"a" => 1, "b" => {}}
    HashDiffSym.unpatch!(b, diff).should == a
  end

  it "should be able to patch value hash <=> nil" do
    a = {"a" => 1, "b" => {"b1" => 1, "b2" =>2}}
    b = {"a" => 1, "b" => nil}
    diff = HashDiffSym.diff(a, b)

    HashDiffSym.patch!(a, diff).should == b

    a = {"a" => 1, "b" => {"b1" => 1, "b2" =>2}}
    b = {"a" => 1, "b" => nil}
    HashDiffSym.unpatch!(b, diff).should == a
  end

  it "should be able to patch value nil removal" do
    a = {"a" => 1, "b" => nil}
    b = {"a" => 1}
    diff = HashDiffSym.diff(a, b)

    HashDiffSym.patch!(a, diff).should == b

    a = {"a" => 1, "b" => nil}
    b = {"a" => 1}
    HashDiffSym.unpatch!(b, diff).should == a
  end

  it "should be able to patch similar objects between arrays" do
    a = [{'a' => 1, 'b' => 2, 'c' => 3, 'd' => 4, 'e' => 5}, 3]
    b = [1, {'a' => 1, 'b' => 2, 'c' => 3, 'e' => 5}]

    diff = HashDiffSym.diff(a, b)
    HashDiffSym.patch!(a, diff).should == b

    a = [{'a' => 1, 'b' => 2, 'c' => 3, 'd' => 4, 'e' => 5}, 3]
    b = [1, {'a' => 1, 'b' => 2, 'c' => 3, 'e' => 5}]
    HashDiffSym.unpatch!(b, diff).should == a
  end

  it "should be able to patch similar & equal objects between arrays" do
    a = [{'a' => 1, 'b' => 2, 'c' => 3, 'd' => 4, 'e' => 5}, {'x' => 5, 'y' => 6, 'z' => 3}, 1]
    b = [1, {'a' => 1, 'b' => 2, 'c' => 3, 'e' => 5}]

    diff = HashDiffSym.diff(a, b)
    HashDiffSym.patch!(a, diff).should == b

    a = [{'a' => 1, 'b' => 2, 'c' => 3, 'd' => 4, 'e' => 5}, {'x' => 5, 'y' => 6, 'z' => 3}, 1]
    b = [1, {'a' => 1, 'b' => 2, 'c' => 3, 'e' => 5}]
    HashDiffSym.unpatch!(b, diff).should == a
  end

  it "should patch hashes with symbols correctly" do
    a = {a: 3}
    b = {a: {a1: 1, a2: 2}}
    diff = HashDiffSym.diff(a, b)
    HashDiffSym.patch!(a, diff).should == b
  end

  it "should patch hashes with both symbol and string keys correctly" do
    a = {a: 3, "b" => 4}
    b = {a: {a1: 1, a2: 2}, "b" => 5}
    diff = HashDiffSym.diff(a, b)
    HashDiffSym.patch!(a, diff).should == b
  end
end
