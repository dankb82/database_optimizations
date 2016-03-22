class ReportsController < ApplicationController
  helper_method :memory_in_mb

  def all_data
    @start_time = Time.now
    @assembly = Assembly.find_by_name(params[:name])
    @hits = @assembly.hits.order(percent_similarity: :desc)
    @memory_used = memory_in_mb
  end


  def search
    @start_time = Time.now

    if params[:search_term]
      @hits = []
      @hits += Hit.joins(:gene).where('genes.dna like ?', "%#{params[:search_term]}%")
      @assembly = Assembly.find_by_name(params[:search_term])
      @hits += @assembly.hits if @assembly
      @hits += Hit.where('match_gene_name like ?', "%#{params[:search_term]}%" )
    else
      @hits = Hit.all.order('percent_similarity DESC')
    end

    @memory_used = memory_in_mb
  end

  private def memory_in_mb
    `ps -o rss -p #{$$}`.strip.split.last.to_i / 1024
  end
end
