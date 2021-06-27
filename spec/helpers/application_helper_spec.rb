require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "Application Title helpers" do
    it "タイトルが正常に表示される" do
      expect(full_title("test")).to eq "test - Aquarist"
    end
    
    context "引数がblankの時" do
      it "正常なタイトルが表示される" do
        expect(full_title("")).to eq "Aquarist"
      end
    end

    context "引数がnilの時" do
      it "正常なタイトルが表示される" do
        expect(full_title(nil)).to eq "Aquarist"
      end
    end
  end
end
