require 'json_spec'

describe "core GELF 201810225" do
  before do
    dir = "spec/fixtures/core_gelf_20181025"
    @good_json = File.read("#{dir}/good.json")
    @test_output_json = File.read("#{dir}/test_output.json")
  end

  it "produced equivalent JSON" do
    @good_json.json.should be_json_eql(@test_output_json)
  end
end
