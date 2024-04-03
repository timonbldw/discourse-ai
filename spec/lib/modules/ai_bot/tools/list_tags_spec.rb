#frozen_string_literal: true

RSpec.describe DiscourseAi::AiBot::Tools::ListTags do
  let(:bot_user) { User.find(DiscourseAi::AiBot::EntryPoint::MISTRAL_7B_ID) }
  let(:llm) { DiscourseAi::Completions::Llm.proxy("open_ai:mistral-7b-instruct") }

  before do
    SiteSetting.ai_bot_enabled = true
    SiteSetting.tagging_enabled = true
  end

  describe "#process" do
    it "can generate correct info" do
      Fabricate(:tag, name: "america", public_topic_count: 100)
      Fabricate(:tag, name: "not_here", public_topic_count: 0)

      info = described_class.new({}).invoke(bot_user, llm)

      expect(info.to_s).to include("america")
      expect(info.to_s).not_to include("not_here")
    end
  end
end
