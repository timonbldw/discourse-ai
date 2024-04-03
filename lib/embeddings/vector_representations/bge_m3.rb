# frozen_string_literal: true

module DiscourseAi
  module Embeddings
    module VectorRepresentations
      class BgeM3 < Base
        class << self
          def name
            "bge-m3"
          end

          def correctly_configured?
            SiteSetting.ai_openai_api_key.present?
          end

          def dependant_setting_names
            %w[ai_openai_api_key]
          end
        end

        def vector_from(text, asymetric: false)
          response = DiscourseAi::Inference::OpenAiEmbeddings.perform!(text, model: self.class.name)
          response[:data].first[:embedding]
          end
        end

        def inference_model_name
          "bge-m3"
        end

        def dimensions
          1024
        end

        def max_sequence_length
          8192
        end

        def id
          8
        end

        def version
          1
        end

        def pg_function
          "<#>"
        end

        def pg_index_type
          "vector_ip_ops"
        end

        def tokenizer
          DiscourseAi::Tokenizer::BgeM3Tokenizer
        end

        def asymmetric_query_prefix
          "Represent this sentence for searching relevant passages:"
        end
      end
    end
  end
end
