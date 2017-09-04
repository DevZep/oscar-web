module AdvancedSearches
  class DomainScoreSqlBuilder

    def initialize(domain_id, rule)
      @operator     = rule['operator']
      @value        = rule['value']
      @domain_id    = domain_id
    end

    def get_sql
      sql_string = 'clients.id IN (?)'
      assessments = Assessment.joins(:assessment_domains)

      case @operator
      when 'equal'
        assessments = assessments.where(assessment_domains: { domain_id: @domain_id, score: @value })
      when 'not_equal'
        assessments = assessments.where('assessment_domains.domain_id = ? and assessment_domains.score != ?', @domain_id, @value)
      when 'between'
        assessments = assessments.where(assessment_domains: { domain_id: @domain_id, score: @value.first..@value.last })
      end
      { id: sql_string, values: assessments.pluck(:client_id).uniq }
    end
  end
end