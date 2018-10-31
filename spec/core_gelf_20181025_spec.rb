require 'json_spec'

describe "core GELF 201810225" do
  before do
    @good_json = File.read("spec/fixtures/core_gelf_20181025/good.json")
    @test_output_json = File.read("artifacts/test_output.json")
  end

  it "yielded equivalent JSON output" do
    @good_json.json.should be_json_eql(@test_output_json)
  end
end
