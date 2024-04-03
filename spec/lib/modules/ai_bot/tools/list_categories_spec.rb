# frozen_string_literal: true

RSpec.describe DiscourseAi::AiBot::Tools::ListCategories do
  let(:bot_user) { User.find(DiscourseAi::AiBot::EntryPoint::MISTRAL_7B_ID) }
  let(:llm) { DiscourseAi::Completions::Llm.proxy("open_ai:mistral-7b-instruct") }

  before { SiteSetting.ai_bot_enabled = true }

  describe "#process" do
    it "list available categories" do
      Fabricate(:category, name: "america", posts_year: 999)

      info = described_class.new({}).invoke(bot_user, llm).to_s

      expect(info).to include("america")
      expect(info).to include("999")
    end
  end
end
