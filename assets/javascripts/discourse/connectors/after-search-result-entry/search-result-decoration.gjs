import icon from "discourse-common/helpers/d-icon";
import i18n from "discourse-common/helpers/i18n";

const SearchResultDecoration = <template>
  <div
    class="ai-result__icon"
    title={{i18n "discourse_ai.embeddings.ai_generated_result"}}
  >
    {{icon "discourse-sparkles"}}
  </div>
</template>;

export default SearchResultDecoration;
