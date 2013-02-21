module GSGraph
  class AdKeywordSuggestion < AdKeyword
    def self.search_query_param
      :keyword_list
    end
  end
end

