# frozen_string_literal: true

module ::Jobs
  class ToxicityClassifyChatMessage < ::Jobs::Base
    def execute(args)
      return unless SiteSetting.ai_toxicity_enabled

      return if (chat_message_id = args[:chat_message_id]).blank?

      chat_message = ::Chat::Message.find_by(id: chat_message_id)
      return if chat_message&.message.blank?

      DiscourseAi::ChatMessageClassificator.new(
        DiscourseAi::Toxicity::ToxicityClassification.new,
      ).classify!(chat_message)
    end
  end
end
